%%---------------------------------------------------------------
%% Main program to simulate the amplitude control loop
%%
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%---------------------------------------------------------------
%% Version History: (in reverse chronological order please)
%% 
%% V0.7   07-Apr-2020    GanesanT    Used fixed point rms computation and sqrt, changed the ADCwin size as multiples of 1.28usec 
%% V0.6a  25-Mar-2020   GanesanT    New PID controller and initial ampLoop corrections 
%% V0.6   12-Dec-2016     GanesanT    Fixed the quantization for PID Loop 
%% V0.5   26-Sep-2016    GanesanT    Modified to run with new interpolation code 
%% V0.4   15-Sep-2016    GanesanT    Modified to run in Matlab Ver R2016b. 
%%                                   Needs control toolbox function tf()
%% V0.3   25-Aug-2016    GanesanT    Model the ADC clock PPM effects
%% V0.2   12-Aug-2016    GanesanT    Adding noise figure and delays in blocks
%% V0.1   18-Jul-2016    GanesanT    Created  
%%---------------------------------------------------------------
%%
%% Functions called
%%
%%  1. pkDet()
%%  2. tone_genFixPt()
%%  3. PIDControl()
%%  4. DACfilter()
%%  5. TxNonlinearity()
%%---------------------------------------------------------------

%clear all;
close all;

clear intMem;
clear difMem;

rand('seed',123);
randn('seed',456);

%% System Parameters

% Tone parameters
fc            = 11e6;             % in Hz (+/- 100 KHz in 10 KHz steps)
toneWinSize   = 1.28e-6;             % Choices are 1, 2, 4 or 8 usec

% DAC parameters
DAC_ENOB      = 12.5;             % bits
DAC_fs        = 50e6;             % in Hz  (DAC sampling freq)
DAC_flt_fc    = 18e6;             % in Hz (DAC filter corder freq) 
DAC_flt_ord   = 3;                % DAC filter order
DAC_flt_type  = 'butterworth';    % DAC filter type
DAC_step_size = 0.01;             % step size for Gain control
[DAC_filt_num, DAC_filt_den] = butter(DAC_flt_ord,2*pi*DAC_flt_fc,'s');
DAC_filt_sys = tf(DAC_filt_num,DAC_filt_den);   % octave version
%DAC_filt_sys = tf([DAC_filt_num; DAC_filt_den]);    % Matlab version
DAC_Ni = 1;
DAC_Nt = ceil(DAC_ENOB+DAC_Ni);          % 1 sign bit is assumed 
FLT_SCALE_ADJ = 1.0; %1.11  % scaling factor needed at the filter output to compensate for attenuation in lsim()
%% PA, Tx Nonlinearity and attenuator parameters

% PGA (for ADC) parameters
PGA_Gain_Array    = [0 6];        % List of gain steps in dB
PGA_delay_Array   = [0 0];        % List of phase steps (any delay changes with gain)
PGA_GaindB_var    = -10*log10(1-0.06);  % Max Gain deviation in dB
PGA_PhasDeg_var   = 0.01;         % Max Phase deviation in deg
PGA_OPI3          = 46.5;         % in dBm  (-87 dBc @ 30 MHz input and 2Vp-p output)
PGA_Gain_err      = 3*sqrt(PGA_GaindB_var)*randn(1,length(PGA_Gain_Array));  % Random gain variations
PGA_Phas_err      = 3*sqrt(PGA_PhasDeg_var)*randn(1,length(PGA_Gain_Array)); % Random phase variations
PGA_Gain_Array    = PGA_Gain_Array + PGA_Gain_err;
PGA_delay_Array   = PGA_delay_Array + PGA_Phas_err/(2*pi*fc);  
PGA_settling_time = 6e-9;         % in sec (0.1% settling time for step input) 
PGA_NFdB          = 20;           % Noise figure in dB  
PGA_P1dB          = 19.5;         % in dBm
PGA_BW            = 25e6;         % First order pole frequency
%NEB_scale         = pi/4;         % Noise equivalent BW for first order RC = pi/2*3dB Freq
PGA_LPF_order     = 1; 
PGA_LPF_RC = 1/(2*pi*PGA_BW);

%if (PGA_LPF_order == 1)
%  ADC_filt_num = 1/PGA_LPF_RC;
%  ADC_filt_den = [1 -PGA_LPF_RC];
%elseif (PGA_LPF_order == 2)
%  ADC_filt_num = (1/PGA_LPF_RC)^2;
%  ADC_filt_den = [1 -2*PGA_LPF_RC PGA_LPF_RC^2];
%end
[PGA_filt_num, PGA_filt_den] = butter(PGA_LPF_order,2*pi*PGA_BW,'s');
PGA_filt_sys = tf(PGA_filt_num,PGA_filt_den);


% ADC parameters
ADC_ENOB          = 16; %12.4;           % bits
ADC_GainErr       = 1.8;                 % Percent of FS
ADC_offsetErr     = 7e-3;                % in Volts
ADC_fs            = 100e6;                % in Hz
ADC_Ni            = 0;
ADC_Nt            = ceil(ADC_ENOB+ADC_Ni);   % 1 sign bit is assumed 
ADC_CLK_PPM       = 20;                  % in PPM

ADC_LPF_order     = 128;
%ADC_LPF_BW       = 12e6;
Ftemp = [0e6    fc-2e6    fc-1e6 fc+1e6 fc+2e6   ADC_fs/2]/(ADC_fs/2);
Atemp = [0      0         1      1      0        0]; 
Wtemp = [1    1    1]; 
[ADC_filt_num]    = remez(ADC_LPF_order, Ftemp, Atemp, Wtemp, 'bandpass' );

numExpts = 20;
numIter = 100;

% PID Loop parameters
%propConst = 0.79;
%intConst = 0.0007;
%difConst = 0.0001;
loopScale = 1; %1.5 ; %1.5479 %1.0; %1.5674;
ampLoopMin = 1000;
ampLoopMax = -1000;

% Different amplitude experiments
ampArray = quantize1(logspace(-3,0,numExpts),20,1,'unsigned');
%ampArray = [ampArray(randi(numExpts,1,5))];
%ampArray = quantize1([5e-3, 1e-2, 1e-1, 1, 1e-3],20,1,'unsigned');
%numExpts = length(ampArray);
%ampArray = ampArray(randperm(numExpts));  % Random order of amplitudes

J = sqrt(-1);
startSample = 1+J*0;
filtStateDAC = zeros(1,min(length(DAC_filt_den),length(DAC_filt_num))-1);
filtStatePGA = zeros(1,min(length(PGA_filt_den),length(PGA_filt_num))-1);
bpFiltState = zeros(1,length(ADC_filt_num)-1);

startIndexDAC = 0;
startIndexPGA = 0;


% Initialize stat collection arrays
ampMonArray = [];
pkEstArray1 = [];
ampErrRMS = zeros(1,numExpts);
ampLoop = ampArray(1);                 % starting value for the loop variable

%% Run Expts
for exptIndex = 1:numExpts
  ampRef =  ampArray(exptIndex);       % reference amplitude
  clear intFiltState;
  clear difFiltState;
  ampLoop = 1e-3;
  freq = fc;
  %fs = DAC_fs;
  DACnum = floor(toneWinSize * DAC_fs);
  err = 1;
  iterIndex = 1;
  ampErr = 1;
  
  while ((iterIndex <= numIter) && (abs(ampErr) >  1e-3*ampRef))
  
    %if (abs(ampErr) > 0.1*ampRef) 
    %% Working coef sets
    % set 1
    %propConst = 1.0;
    %intConst = 0.01;
    %difConst = 0.1; %0.0002; %0.0006, 0.0007;
    
    % set 2
    %propConst = 0.8;
    %intConst = 0;
    %difConst = 0.01; %0.001; %0.001; %0.0002; %0.0006, 0.0007;

    % set 2a
    %propConst = 0.4;
    %intConst = 0;
    %difConst = 0.01; %0.001; %0.001; %0.0002; %0.0006, 0.0007;
    
    % set 2(a) for new PID controller constants - Working well - converging in 100 usec with 2 usec window
    %propConst = 0.6;
    %intConst = 0.2;
    %difConst = 0.4; 
    
    % set 2(b) for new PID controller constants - Working well - converging in 100 usec with 2 usec window
    %propConst = 0.5;
    %intConst = 0.25;
    %difConst = 0.375; 

    % set 2(c) for new PID controller constants - Working well - converging in 20 usec with 1 usec window & Fast/slow PID mode
    %propConst = 0.75;
    %intConst = 0.5;
    %difConst = 0.25; 

    % set 2(d) for new PID controller constants - Working well - converging in 20 usec with 1 usec window & Fast/slow/superslow PID mode
    propConst = 0.5;
    intConst = 0.625;
    difConst = 0.25; 
    
    % set 3  - 120 usec convergence time
    %propConst = 0.2;
    %intConst = 0;
    %difConst = 0.0; %0.001; %0.001; %0.0002; %0.0006, 0.0007;
    
    % set 4  - 350 usec convergence time
    %propConst = 0.1;
    %intConst = 0;
    %difConst = 0.0; %0.001; %0.001; %0.0002; %0.0006, 0.0007;
    %end

   % Generate tone (2Vpp is default)
    [tone,endSample] = tone_genFixPt(freq, DAC_fs, DACnum, startSample, DAC_Nt, DAC_Ni);
    scaledSig = loopScale * ampLoop * tone;
  
    % Pass thru the DAC filter and upsample the output to imitate continous time
    ADCnum = floor(toneWinSize * ADC_fs);
    ADC_DAC_OSR = floor(ADC_fs/DAC_fs);
    timeVec =  [startIndexDAC+1:startIndexDAC+ADCnum]/(ADC_fs+ADC_CLK_PPM*1e-6*ADC_fs);
    sigVec = reshape(repmat(scaledSig,ADC_DAC_OSR,1),1,ADC_DAC_OSR*DACnum);
    %[filtOut, timeVec1, filtStateDAC] = lsim(DAC_filt_sys, sigVec, timeVec, filtStateDAC);
    [filtOut, timeVec1] = lsim(DAC_filt_sys, sigVec, timeVec-timeVec(1), filtStateDAC);
    startIndexDAC = startIndexDAC+ADCnum;
    %filtStateDAC = filtStateDAC(end,:);    % keep only the last value in the state
    
    % Interpolate to 160 MHz to imitate continuous time signal
    %ADC_OSR = 4;
    %adcInput = resample(filtOut,ADC_OSR,1);
    %dnSampleRate = floor(DAC_fs*ADC_OSR/ADC_Fs);
    %adcOutput = quantize1(adcInput(1:dnSampleRate:end),ADC_Nt, ADC_Ni,'signed');
    adcInput = FLT_SCALE_ADJ * filtOut;
    
    timeVec2 =  [startIndexPGA+1:startIndexPGA+ADCnum]/(ADC_fs+ADC_CLK_PPM*1e-6*ADC_fs);
    sigVec = adcInput; %reshape(repmat(scaledSig,ADC_DAC_OSR,1),1,ADC_DAC_OSR*DACnum);
    %[pgafiltOut, timeVec3, filtStatePGA] = lsim(PGA_filt_sys, sigVec, timeVec2, filtStatePGA);
    [pgafiltOut, timeVec3] = lsim(PGA_filt_sys, sigVec, timeVec2-timeVec2(1), filtStatePGA);
    startIndexPGA = startIndexPGA+ADCnum;
    %filtStatePGA = filtStatePGA(end,:);    % keep only the last value in the state

    
    %% Add noise from the ADC driver
    NEB_scale = 1;   % Since actual filter is used in simulation
    noisePwr = (-174 + PGA_NFdB) + 10*log10(PGA_BW * NEB_scale); 
    

    noiseAmp = 10^(noisePwr/20); 
    adcInput = pgafiltOut + noiseAmp * randn(length(pgafiltOut),1);
    adcOutput = quantize1(adcInput,ADC_Nt, ADC_Ni,'signed');
    
    % Post-ADC filter
    %[bpFiltOut,bpFiltState] = filter(ADC_filt_num,1,adcOutput,bpFiltState);
    
    % Estimate the peak value
    %bpFiltOut = bpFiltOut(:);
    M = length(adcOutput);
    Ts = 1/ADC_fs;
    
    if (0)
       mode = 'float';
      [pkEst, pkEst_fp] = peakEstFixedPt_v2(adcOutput,M,Ts,freq,mode)    ;   
      pkVal = mean(pkEst_fp);
   else
      pkVal = sqrt(2) * rms(adcOutput);
      [rms_val,scale] = rms_fp(adcOutput);
      nt = 18;
      ni =  1;
      roundmode = 'trunc';
      signmode = 'signed';
      numSqrtIter = 3;
      [pkVal_fp, expn_fp] = SQRT_fp(2*rms_val/2^scale,numSqrtIter,nt,ni,signmode,roundmode);
   end
   %pkEstArray(iterIndex) = pkVal;
   pkEstArray(iterIndex) = pkVal_fp * 2^expn_fp;

   % Run the PID loop
   err = 1*(ampRef - pkVal);
   %err = quantize1(err, 32, 0,'signed','trunc'); 
   
   %[ampLoop1,intMemMin,intmemMax,difMemMin,difMemMax] = PIDloop_fp(err, propConst, intConst, difConst);
   [ampLoop0] = PIDloop_v2_fp(err, propConst, intConst, difConst);
   %[ampLoop0] = PIDloop_v2(err, propConst, intConst, difConst);
   ampLoop = ampLoop0;
   %ampLoop = ampLoop + ampLoop0;
    
    if (ampLoopMin > ampLoop)
        ampLoopMin = ampLoop;
    end
    if (ampLoopMax < ampLoop)
        ampLoopMax = ampLoop;
    end
    
    if (ampLoop < 0)
      disp(['*** ampLoop is negative: ',num2str(ampLoop)]); 
      disp(['*** ampLoop is reset to 1: ']); 
      ampLoop = 1;
      %keyboard;
    else
      disp(['ampRef = ',num2str(ampRef),', ampLoop = ' ,num2str(ampLoop)]); 
    end
      
    ampLoop = quantize1(ampLoop, 16  , 2, 'unsigned', 'trunc');
    
  %[ampLoop] = ampLoop + PIDloop(err, propConst, intConst, difConst); %original code
   %ampLoop = loopScale * ampLoop;    % Adjust for overall gain correction
   
   %disp(['Iteration No.: ',num2str(iterIndex),' Amplitude Ref: ',num2str(ampRef/loopScale),' Amplitude Loop ',num2str(ampLoop)]);
      
   ampMon(iterIndex) =  ampLoop;   % Magic constant
   ampErr = ampRef - ampLoop;
   ampErrArray(iterIndex) = ampErr;

   iterIndex = iterIndex + 1;

   end  % for while
   disp(['Iteration No.: ',num2str(iterIndex),' Amplitude Ref: ',num2str(ampRef),' Amplitude Loop ',num2str(ampLoop)]);
   disp(['Amp. Index= ',num2str(exptIndex),' Tracking Amplitude Err Variance = ',num2str(var(ampErrArray(floor(numIter/2)+1:end)))]);
   ampErrRMS(exptIndex) = sqrt(var(ampErrArray(floor(numIter/2)+1:end)));
   %figure(1); clf; 
   %plot(ampMon,'bo-'); hold on; plot(ampRef/loopScale*ones(1,length(ampMon)),'r-.','LineWidth',2);grid;
   
   ampMonArray = [ampMonArray ampMon];
   %figure(2); clf;
   %plot(pkEstArray); grid;
   %keyboard;
   
   pkEstArray1 = [pkEstArray1 pkEstArray];
  
end  % for ampArray

%% Linear plot
%figure(1); clf; 
%timeScale = [0:length(pkEstArray1)-1]*toneWinSize;
%plot(timeScale,pkEstArray1,'bo-','LineWidth',1,'MarkerSize',4); hold on;
%%set(gca, 'linewidth', 0.25, 'fontsize', 18)
%plot(timeScale,reshape(repmat(ampArray,numIter,1),1,length(ampMonArray)),'r+-.','LineWidth',2,'MarkerSize',4);grid;
%%set(gca, 'linewidth', 0.25, 'fontsize', 18)
%legend('Measured Amp','Target Amp','location','northwest'); 
%xlabel('Time (sec)'); ylabel('Tone Amplitude (V)');
%axis([0 timeScale(end) 1e-5 2]);
%print PIDplot1.pdf

%% Logarithmic plot
figure(2); clf; 
timeScale = [0:length(pkEstArray1)-1]*toneWinSize;
semilogy(timeScale,pkEstArray1,'bo-','LineWidth',1,'MarkerSize',4); hold on;
%set(gca, "linewidth", 0.25, "fontsize", 18)
semilogy(timeScale,reshape(repmat(ampArray,numIter,1),1,length(ampMonArray)),'r+-.','LineWidth',2,'MarkerSize',4);grid;
%set(gca, "linewidth", 0.25, "fontsize", 18)
legend('Measured Amp','Target Amp','location','northwest');
xlabel('Time (sec)'); ylabel('Tone Amplitude (V)');
axis([0 timeScale(end) 1e-4 2]);
print PIDplot2.pdf
print PIDplot2.png

%% Tracking error plot
figure(3); clf; 
timeScale = [0:length(pkEstArray1)-1]*toneWinSize;
semilogy(timeScale,pkEstArray1,'bo-','LineWidth',1,'MarkerSize',4); hold on;
%set(gca, "linewidth", 0.25, "fontsize", 18)
semilogy(timeScale,1e-3*ones(1,length(timeScale)),'m+-.','LineWidth',2,'MarkerSize',4);
semilogy(timeScale,abs(pkEstArray1-reshape(repmat(ampArray,numIter,1),1,length(ampMonArray))),'r+-.','LineWidth',2,'MarkerSize',4);grid;
%set(gca, "linewidth", 0.25, "fontsize", 18)
%legend('Measured Amp','Tracking Error','location','northeast');
legend('Measured Amp','Tracking Err: Specs','Tracking Err: Actual','location','southeast');
xlabel('Time (sec)'); ylabel('Amplitude (V)');
axis([0 timeScale(end) 1e-5 2]);
print PIDplot3.pdf
print PIDplot3.png

%% Tracking error - percentage plot
figure(4); clf; 
timeScale = [0:length(pkEstArray1)-1]*toneWinSize;
semilogy(timeScale,pkEstArray1,'bo-','LineWidth',1,'MarkerSize',4); hold on;
%set(gca, "linewidth", 0.25, "fontsize", 18)
% Specs line (1mV to 20 mV 1%, 20 mV to 100 mV 0.5% and 100mV to 1000 mV - 0.1%)
specs = 0.0005*ones(1,length(ampArray));
ind1 = find(ampArray <= 20e-3);
ind2 = find(ampArray <= 100e-3);
specs(1:length(ind2)) = 0.005;
specs(1:length(ind1)) = 0.01;

semilogy(timeScale,reshape(repmat(100*specs,numIter,1),1,length(ampMonArray)),'m','LineWidth',2);
%set(gca, "linewidth", 0.25, "fontsize", 18)
semilogy(timeScale,100*abs(pkEstArray1-reshape(repmat(ampArray,numIter,1),1,length(ampMonArray)))./reshape(repmat(ampArray,numIter,1),1,length(ampMonArray)),'r+-.','LineWidth',1,'MarkerSize',4);grid;
%set(gca, "linewidth", 0.25, "fontsize", 18)
%legend('Measured Amp','Tracking Error (%)','location','north');
legend('Measured Amp','Tracking Err(%): Agreed Specs','Tracking Err(%): Actual','location','southeast');
xlabel('Time (sec)'); ylabel('Amplitude (V)');
axis([0 timeScale(end) 1e-5 1e2]);
print PIDplot4.pdf
print PIDplot4.png

%%% Tracking error plot
%figure(5); clf; 
%%timeScale = [0:length(pkEstArray1)-1]*toneWinSize;
%plot(ampArray,ampErrRMS,'bo-','LineWidth',2,'MarkerSize',4); grid;
%set(gca, "linewidth", 0.25, "fontsize", 18)
%%semilogy(timeScale,abs(pkEstArray1-reshape(repmat(ampArray,numIter,1),1,length(ampMonArray))),'r+-.','LineWidth',2,'MarkerSize',6);grid;
%%set(gca, "linewidth", 0.25, "fontsize", 18)
%%legend('Measured Amp','Tracking Error','location','north');
%xlabel('Amplitude (V)'); ylabel('Tracking Err RMS (V)');
%%print PIDplot5.pdf
