%% Program to run the GPS Rx DFE
%% Function to create the GPS system simulation with antenna steering
%% 
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%---------------------------------------------------------------
%% Usage:
%% function [txSignal, payload, hFilt, codeOffsetArray, freqOffsetArray] = gpsTx(svIdArray, numBits, OSR, alpha)
%%
%% Version History: (in reverse chronological order please)
%%
%% ver  0.1   17-Jan-2020   Ganesan, T             Created. Added freq domain and time domain correlation computation.

clear all;
close all;


%% Simulation parameters
rand('seed',123);
randn('seed',456);
J = sqrt(-1);

NUM_BITS_AVG = 1;   % No. of payload bits used for averaging peaks
NUM_RPTS = 20;      % No. of repetitions per bit (20 msec per bit => 50 Hz payload baud)
MAX_SVs = 32;       % Maximum no. of SVs considered
SNRdB = -25;        % SNR operating point
NUM_SVs  = 6;       % No. of SVs used in simulation (used for DoP prediction)
PAYLOAD_BITS = 10;  % 10*20 msec duration
OSR = 10;           % 10x oversampling => 10.23 MHz sampling rate
ALPHA = 0.25;       % Default excess bandwidth for root Raised cosine pulse 
CODE_LEN = 1023;
MAX_DOPPLER = 5000; % Hz 

% Derived parameters
Fs = CODE_LEN*OSR*1e3;                                     % BB sampling rate
svAngleArray = [2*pi*rand(1,NUM_SVs);pi*rand(1,NUM_SVs)];  % Azimuth and Elevation angle
svArrayVec = zeros(4,NUM_SVs);   % Arrayvector wrt origin (I,II,IV and III quadrants order)

for ii = 1:NUM_SVs
    svArrayVec(:,ii) = sin(svAngleArray(2,ii))*pi/sqrt(2)* ...
        [cos(svAngleArray(1,ii))+sin(svAngleArray(1,ii)); ...
         cos(svAngleArray(1,ii))-sin(svAngleArray(1,ii)); ...
         -(cos(svAngleArray(1,ii))+sin(svAngleArray(1,ii))); ...
         -cos(svAngleArray(1,ii))+sin(svAngleArray(1,ii))];       
end

%% Generate Tx data
svIdArray = randi(32,1,6); % Random 6 satellites
[txSignal, payload, hFilt, codeOffsetArray, freqOffsetArray, svIdArray] = gpsTx(svIdArray, PAYLOAD_BITS, OSR, ALPHA);

%% Generate Rx data
rxSignal = 10^(SNRdB/20) * sum(txSignal,2) + randn(length(txSignal),1);
%% Generate GPS Gold codes (reference)
NUM_SVs = MAX_SVs;                          %length(svIdArray);
refCode = zeros(CODE_LEN*OSR, NUM_SVs);

for nSV = 1:MAX_SVs
    init_g1 = ones(1,10);
    init_g2 = ones(1,10);
    codeLen = CODE_LEN;
    fbMode = ['SV',num2str(nSV)];
    codeOffset = 0; %floor(rand*MAX_CODE_OFFSET);   % Maximum of 64 code phase     
    [code, symbol] = GPS_GoldSequence_generator(init_g1, init_g2, codeLen, fbMode, codeOffset);
    refCode(:,nSV) = reshape(repmat(symbol, OSR, 1),OSR*CODE_LEN,1);
end

%% Rx processing starts here
% Use self correlation to find code offset and freq offset for all SVs
corr = zeros(CODE_LEN*OSR,length(svIdArray),CODE_LEN*OSR);
PAYLOAD_BITS = 1;
dopplerFreqArray = linspace(-MAX_DOPPLER,MAX_DOPPLER,1001);
%svIdArray(1)
%figure;

disp('Code and Freq Offset estimation');
data = rxSignal(1:CODE_LEN*OSR*NUM_RPTS*NUM_BITS_AVG);
for ii = 1:length(svIdArray)
    code = refCode(:,svIdArray(ii));
    disp(['Computing correlation for SVid :',num2str(svIdArray(ii))]);

    %codeFFT = fft(code);
    %for jj = 1:20
        %disp(['Computing correlation for bit :',num2str(jj)]);
        %data = (rxSignal((jj-1)*CODE_LEN*OSR+1:jj*CODE_LEN*OSR));
        %dataFFT = fft(data);
        
        for kk = 1:length(dopplerFreqArray)  % +ve freq offset
            freqOffset1 = dopplerFreqArray(kk);
            disp(['Computing correlation for freq :',num2str(freqOffset1)]);

            data1 = data .* exp(-J*2*pi*freqOffset1/Fs*[0:length(data)-1]');
            %corrFFT = (temp .* conj(codeFFT));
            corr1 = conv(data1,flipud(code));
            corr1_fft = ifft(fft(data1,214830).*fft(flipud(code),214830))
            %corr2 = conv(data1,(code));
            %plot(abs(corr1));hold on; plot(abs(corr2),'r-.');
            corr1 = corr1(5115:end-5115);
            corr1_fft = corr1_fft(5115:end-5115);
            corr(:,ii,kk) = (sum((reshape(corr1,CODE_LEN*OSR,NUM_RPTS*NUM_BITS_AVG)),2));
        end
        %figure(1);plot(abs(corr));
        %title(['SVid: #',num2str(ii)]);
        %pause(1);
    %end
    % Find the maximum peak among the freq offset for each SVcode
    temp = squeeze(corr(:,ii,:));
    [tempMax,maxIndex] = max(abs(temp));
    [maxPeak(ii), freqOffset(ii)] = max(tempMax);
    codeOffset(ii) = floor((CODE_LEN*OSR/2-maxIndex(freqOffset(ii)))/OSR); 
    freqOffset(ii) = dopplerFreqArray(freqOffset(ii));
end

% Save intermediate results
fname = sprintf('GPS_rx_results_%s.mat',date);
save(fname);



