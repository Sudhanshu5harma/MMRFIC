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
%% ver  0.7   13-Apr-2020   Ganesan, T             Added the false alarm and Pdet computation (Pfa Vs threshold, Pdet)
%%                                                    Modified the Analog, digital beamformer splitting of optimal weights
%% ver  0.6   10-Apr-2020   Ganesan, T             Fixed the two level detection and threshold based on the ratio of large two peaks
%% ver  0.5   25-Feb-2020   Ganesan, T             Fixed the initial Wt selection and fixed the fine freq offset loop
%%                                                 Added the quantized analog weight computation 
%%                                                 Added the optimum digital weight computation 
%% ver  0.4   06-Feb-2020   Ganesan, T             Normalized the initial wts with first or diagonal element to be 1
%%                                                 Added fine freq estimation using Differential correlation method 
%% ver  0.3a  21-Jan-2020   Ganesan, T             Added initial(4) orthogonal weights and 
%%                                                 interference suppression weights
%% ver  0.3   21-Jan-2020   Ganesan, T             Added RRC filtering in RxSignal.
%%                                                 Corrected Elevation angle generation
%%                                                 Added Jammers (tones)
%% ver  0.2a  20-Jan-2020   Ganesan, T             Merged latest changes from Ver 0.1
%% ver  0.2   19-Jan-2020   Ganesan, T             Added direction vector for each SV ix Tx and Rx.
%% ver  0.1   20-Jan-2020   Ganesan, T             Added coherent and non-coherent integration.
%% ver  0.0   17-Jan-2020   Ganesan, T             Created. Added freq domain and time domain correlation computation.

clearvars;  % instead of `clear all'
close all;


%% Simulation parameters
%rand('seed',123);
%randn('seed',456);
rng(1234,'twister');          % New Random seed initialization
J = sqrt(-1);

NUM_BITS_AVG = 10;  % No. of payload bits used for averaging peaks
NUM_RPTS = 20;      % No. of repetitions per bit (20 msec per bit => 50 Hz payload baud)
MAX_SVs = 32;       % Maximum no. of SVs considered
SNRdB = 0;          % SNR operating point
NUM_SVs  = 6;       % No. of SVs used in simulation (used for DoP prediction)
PAYLOAD_BITS = min(100,NUM_BITS_AVG);  % 10*20 msec duration
OSR = 10;           % 10x oversampling => 10.23 MHz sampling rate
ALPHA = 0.25;       % Default excess bandwidth for root Raised cosine pulse
CODE_LEN = 1023;
MAX_DOPPLER = 1*5000; % Hz % Though SV speed only give +/- 5K, doubled for worst case
COHER_INT_CHIPS = 10;   % No of coherent integration for bit averaging
ICRdB = 70;          % Jammers are 90 dB stronger than the GPS signal (it was 70)
NUM_BLOCKERS = 1;    % No. of jammers
ABF_QNT = 0;         % Enable quantization of ABF weights
ABF_NT = 6;
ABF_NI = 2;          % Angle needs 2 integer bits (for -pi to pi)
DET_THRESH_BETA = 1.4;  % DEFAULT: Detection threshold for Pfa = 1e-3, Pfa = (N^2-N) * Beta(N-1,1+beta)
PFA_SIM = 1;
if (PFA_SIM > 0)
    %PFA_SIM_BETA_ARRAY = [1.2 1.4 1.6 2.0 2.4 2.8];  % Detection thresholds used for Pfa simulation
    PFA_SIM_BETA_ARRAY = [1.4 1.6 1.8];  % Detection thresholds used for Pfa simulation
    %PFA_SIM_BETA_ARRAY = [1.2 1.4];  % Detection thresholds used for Pfa simulation
else
    PFA_SIM_BETA_ARRAY = DET_THRESH_BETA;       % Fixed threshold used for Pdet simulation
end

% Derived parameters
Fs = CODE_LEN*OSR*1e3;                                     % BB sampling rate
svAngleArray = [2*pi*rand(1,NUM_SVs);pi/2*rand(1,NUM_SVs)];  % Azimuth and Elevation angle
svArrayVec = zeros(4,NUM_SVs);   % Arrayvector wrt origin (I,II,IV and III quadrants order)
if (PFA_SIM > 0)
    dopplerFreqArray = linspace(-MAX_DOPPLER,MAX_DOPPLER,1001);  % Coarse estimate in 100 Hz grid
else
    dopplerFreqArray = linspace(-MAX_DOPPLER,MAX_DOPPLER,101);  % Coarse estimate in 100 Hz grid
end

for ii = 1:NUM_SVs
    svArrayVec(:,ii) = exp(J*sin(svAngleArray(2,ii))*pi/sqrt(2)* ...
        [cos(svAngleArray(1,ii))+sin(svAngleArray(1,ii)); ...
        cos(svAngleArray(1,ii))-sin(svAngleArray(1,ii)); ...
        -(cos(svAngleArray(1,ii))+sin(svAngleArray(1,ii))); ...
        -cos(svAngleArray(1,ii))+sin(svAngleArray(1,ii))]);
end

%% Generate Tx data
svIdArray = randi(MAX_SVs,1,6); % Random 6 satellites
[txSignal, payload, hFilt, codeOffsetArray, freqOffsetArray, svIdArray] = gpsTxV0p3(svIdArray, PAYLOAD_BITS, OSR, ALPHA, MAX_DOPPLER);
svIdArrayBar = setdiff([1:MAX_SVs],svIdArray);  % Complementary set

freqOffsetArray
codeOffsetArray

% Replace the Last few SV signal with Jammers
for ii = NUM_SVs-NUM_BLOCKERS+1:NUM_SVs
    txSignal(:,ii) = 10^((ICRdB+SNRdB+3)/20) * sin(2*pi*ii*500/Fs*(0:length(txSignal)-1)'); %+3 dB for RMS
end

% Add direction vector for Tx
txSignalVector = zeros(length(txSignal),4,length(svIdArray));
for ii = 1:NUM_SVs
    txSignalVector(:,:,ii) = kron(txSignal(:,ii), svArrayVec(:,ii)');
end

%% Generate Rx data
rxAntennaWts = []; %fft(eye(4))/sqrt(4);                        % Initial Orthogonal wts
txSignalNew = 10^(SNRdB/20) * squeeze(sum(txSignalVector,3));   % Sum all SV data
txSignalNew = txSignalNew + randn(size(txSignalNew));  % Add noise as per SNR
txSignalNew = txSignalNew/max(max(txSignalNew));       % Scale AGC to unit amplitude

%% STEP 1; First get a clean BB signal for the refernece receiver to operate without ABF
Rxx = txSignalNew(1:CODE_LEN,:)' * txSignalNew(1:CODE_LEN,:)/CODE_LEN;  % Initial Rxx for interference
newWt = inv(Rxx);   % Rxx \ eye(4) is used as initial set of weights
% Normalize the weights
%newWt = diag(1./diag(newWt * newWt')) * newWt;  % Normalize the weights for unit energy
%newWt = newWt * diag(1./newWt(1,:));            % Normalize the first element to be 1
newWt = newWt * diag(1./diag(newWt)) ;           % Normalize the diagonal elements to be 1
% NOTE: No need to quantize these weights as they will applied in Digital
% beamformer. However, we can compute the cleanBBSignal here for comparison
% with the final one.
rxAntennaWts = [rxAntennaWts newWt'];
rxSignal = txSignalNew * rxAntennaWts';            % Apply the digital BF weights
cleanBBSignal0 = sum(rxSignal,2);                  % First cleanBBSignal after first digital BF

% % Receive in the direction vector of Rx
% for ii = 1:NUM_SVs
%     txSignal(:,ii) = (squeeze(txSignalVector(:,:,ii)) * rxAntennaWts');
% end
%
% rxSignal = 10^(SNRdB/20) * sum(txSignal,2) + randn(length(txSignal),1);

%% Generate GPS Gold codes (reference)
%NUM_SVs = MAX_SVs;                          %length(svIdArray);
refCode = zeros(CODE_LEN*OSR, MAX_SVs);

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
NUM_NON_COH_INT = floor(NUM_RPTS*NUM_BITS_AVG/COHER_INT_CHIPS); % No. of non-coherent integration
% Use self correlation to find code offset and freq offset for all SVs
%corr = zeros(CODE_LEN*OSR,NUM_NON_COH_INT,length(svIdArray),length(dopplerFreqArray)); % 4-D array
corr = zeros(CODE_LEN*OSR,NUM_NON_COH_INT,length(dopplerFreqArray));  % 3-D array
%svIdArray(1)
%figure;

% Find the code offset and freq offset for each SV
disp('Code and Freq Offset estimation FOR INITIAL WEIGHTS');
maxPeak = zeros(4,length(svIdArray));
codeOffset = zeros(4,length(svIdArray));
timeOffset = zeros(4,length(svIdArray));
freqOffset = zeros(4,length(svIdArray));
finalDetFlag = zeros(4,length(svIdArray));
coarseDetFlag = zeros(4,length(svIdArray));
fineDetFlag = zeros(1,length(svIdArray));
ProbFA = zeros(length(PFA_SIM_BETA_ARRAY),4);
ProbDET = zeros(length(PFA_SIM_BETA_ARRAY),4);

%% STEP 2: Compute the frequency and Code offsets using the digital BFed signal needed for detection
for pfaIndex = 1:length(PFA_SIM_BETA_ARRAY)
    BETA = PFA_SIM_BETA_ARRAY(pfaIndex);
    if (PFA_SIM)
        disp(['Simulating Pfa for threshold (beta): ',num2str(BETA)]);
    else
        disp(['Simulating Pdet for threshold (beta): ',num2str(BETA)]);
    end
    for wtIndex = 1:4
        disp(['Simulating  for Rx weight index: ',num2str(wtIndex)]);

        data = conv(rxSignal(1:CODE_LEN*OSR*NUM_RPTS*NUM_BITS_AVG,wtIndex),hFilt,'same');  % RRC filtering done by HW (reduces noise to certain extend)
        fineFreqOffset = zeros(1,length(svIdArray));
        falseAlarmCount = 0;
        falseAlarmExpt = 0;        
        PdetCount = 0;
        PdetExpt = 0;
        
        for ii = 1:length(svIdArray)
            if (PFA_SIM > 0)
                code = refCode(:,svIdArrayBar(randi(32-NUM_SVs)));
            else
                code = refCode(:,svIdArray(ii));
            end
            disp(['2D-Search: Doppler and Code offset for SVid: ',num2str(svIdArray(ii))]);
            
            %codeFFT = fft(code);
            %for jj = 1:20
            %disp(['Computing correlation for bit :',num2str(jj)]);
            %data = (rxSignal((jj-1)*CODE_LEN*OSR+1:jj*CODE_LEN*OSR));
            %dataFFT = fft(data);
            
            for kk = 1:length(dopplerFreqArray)  % +ve freq offset
                freqOffset1 = dopplerFreqArray(kk);
                %disp(['Computing correlation at Doppler freq: ',num2str(freqOffset1)]);
                
                temp1 = data .* repmat(exp(-J*2*pi*freqOffset1/Fs*(0:length(data)-1)'),1,size(data,2));
                %corrFFT = (temp .* conj(codeFFT));
                corr1 = conv(temp1,flipud(code),'same');   % <---- used to 'same' option to pick the center portion
                %corr2 = conv(data1,(code));
                %plot(abs(corr1));hold on; plot(abs(corr2),'r-.');
                %corr1 = corr1(5115:end-5115);             % <---- conv() with same option does this
                
                % All coherent or non-coherent integration method
                %corr(:,ii,kk) = (sum((reshape(corr1,CODE_LEN*OSR,NUM_RPTS*NUM_BITS_AVG)),2));
                %corr(:,ii,kk) = (sum(abs(reshape(corr1,CODE_LEN*OSR,NUM_RPTS*NUM_BITS_AVG)),2));
                
                % Mixed coherent and non-coherent integration method
                corr(:,:,kk) = 0;  % 1st dim- Corr Lags, 2nd Dim - Non-coh-integ-index, 3rd dim - SVid, 4th dim - FreqOffsetIndex
                corrData = reshape(corr1,CODE_LEN*OSR,NUM_RPTS*NUM_BITS_AVG);
                for jj = 1:NUM_NON_COH_INT
                    corr(:,jj,kk) = corr(:,jj,kk) + ...
                        (sum(corrData(:,(jj-1)*COHER_INT_CHIPS+1:jj*COHER_INT_CHIPS),2));
                end
                corr(:,:,kk) = corr(:,:,kk)/(COHER_INT_CHIPS*NUM_NON_COH_INT);   % Normalize for the integration length
            end % End for kk (Doppler Freq Array)
            %figure(1) ;plot(abs(corr));
            %title(['SVid: #',num2str(ii)]);
            %pause(1);
            %end
            % Find the maximum peak among the freq offset for each SVcode and
            temp = squeeze(sum(corr(:,:,:),2));
            [tempMax,maxIndex] = max(abs(temp));
            [maxPeak(wtIndex,ii), freqOffset1(wtIndex,ii)] = max(tempMax);
            timeOffset(wtIndex,ii) = maxIndex(freqOffset1(wtIndex,ii));
            codeOffset(wtIndex,ii) = floor((CODE_LEN*OSR/2-timeOffset(wtIndex,ii))/OSR);
            freqOffset(wtIndex,ii) = dopplerFreqArray(freqOffset1(wtIndex,ii));
            
            % First level SV detection based on the Coarse freq offset
            detData = abs(temp(:,freqOffset1(wtIndex,ii)));  % Get the correlation values for the best freq estimate
            [first_peak, offset1] = max(detData);
            temp1 = detData;
            firstPkIndex = max(1,min(length(temp),offset1-10));
            temp1(firstPkIndex:firstPkIndex+20) = min(detData);
            [second_peak, offset2] = max(temp1);
            if (first_peak > BETA/2 * second_peak)   % Relax the threshold for coarse search
                coarseDetFlag(wtIndex,ii) = 1;
            else
                coarseDetFlag(wtIndex,ii) = 0;
            end
            if (PFA_SIM>0)
                falseAlarmExpt = falseAlarmExpt + 1;
            else
                PdetExpt = PdetExpt + 1;
            end
            % Estimate the fine freq offset using the differential correlation
            % of the correlation peaks corresponding to the current code Offset
            % estimate obtained by the above 2-D grid search
            if (coarseDetFlag(wtIndex,ii) > 0)
                diffCorr(ii,:) = squeeze(corr(timeOffset(wtIndex,ii),1:end-1,freqOffset1(wtIndex,ii))) .* ...
                    conj(squeeze(corr(timeOffset(wtIndex,ii),2:end,freqOffset1(wtIndex,ii))));
                diffCorrSum(ii) = sum(diffCorr(ii,:));
                %end
                %[~,coarseFreqOffsetIndex] = max(abs(diffCorrSum));
                fineFreqOffset(ii) = -angle(diffCorrSum(ii))/(2*pi*CODE_LEN*OSR/Fs)/OSR;
                freqOffset(wtIndex,ii) =  freqOffset(wtIndex,ii) + fineFreqOffset(ii);   % Compute total freq offset
                
                % Second level of detection using fine freq offset for
                % confirmation
                temp1 = data .* repmat(exp(-J*2*pi*freqOffset(wtIndex,ii)/Fs*(0:length(data)-1)'),1,size(data,2));
                corr1 = conv(temp1,flipud(code),'same');   % <---- used to 'same' option to pick the center portion
                corrData = reshape(corr1,CODE_LEN*OSR,NUM_RPTS*NUM_BITS_AVG);
                corr_fine = sum(corrData(:,1:NUM_NON_COH_INT*COHER_INT_CHIPS),2)/(COHER_INT_CHIPS*NUM_NON_COH_INT);
                
                % Compute the optimal detection flag (based on Thresholding)
                detData = abs(corr_fine);  % Get the correlation values for the best freq estimate
                [first_peak, offset1] = max(detData);
                temp1 = detData;
                firstPkIndex = max(1,min(length(temp),offset1-10));
                temp1(firstPkIndex:firstPkIndex+20) = min(detData);
                [second_peak, offset2] = max(temp1);
                if (abs(first_peak) > BETA * abs(second_peak))
                    fineDetFlag(ii) = 1;
                    maxPeak(wtIndex,ii) = first_peak;  % Update the new peak
                    timeOffset(wtIndex,ii) = offset1;
                    codeOffset(wtIndex,ii) = floor((CODE_LEN*OSR/2-timeOffset(wtIndex,ii))/OSR);
                    if (PFA_SIM > 0)
                        falseAlarmCount = falseAlarmCount + 1;
                    else
                        PdetCount = PdetCount + 1;
                    end
                else
                    fineDetFlag(ii) = 0;
                end
                % Final decision flag
                finalDetFlag(wtIndex,ii) = fineDetFlag(ii);
            end  % for coarse detect flag
        end   % End for ii (svIdArray)
        
        % If some SV is detected, limit the freq search range around the
        % detected freq range
        if (sum(finalDetFlag(wtIndex,:) > 1))
            svIndices = find(finalDetFlag(wtIndex,:) > 0);
        end
        if (PFA_SIM > 0)
            ProbFA(pfaIndex,wtIndex) = falseAlarmCount/falseAlarmExpt
        else
            ProbDET(pfaIndex,wtIndex) = PdetCount/PdetExpt
        end
        
    end % for wtIndex
end  % for PfaIndex

% Save intermediate results for debug
% fname = sprintf('GPS_rx_results_interim_%s.mat',date);
% save(fname);

% Compute the false alarm probability
if (PFA_SIM > 0)
    disp('Probabilty of False Alarm Sim done');
    disp(['Probability of false alarm in 4 weights: ',num2str(mean(ProbFA))]);
    keyboard;
else
    disp('Probabilty of Detection Sim done');
    disp(['Probability of Detectoin in 4 weights: ',num2str(mean(ProbDET))]);
    keyboard;
end

% Check for SVs which are strong and pick those weights
detectionMetric = sum(finalDetFlag,2);
wtIndices = find(detectionMetric > 0);
if ~isempty(wtIndices)
    [~,maxWtIndex] = max(sum(maxPeak.*finalDetFlag,2));  % Choose based on the strength of peaks
else
    error('No SV was detected');
end
selectedCodes = codeOffset(maxWtIndex,:) .* finalDetFlag(maxWtIndex,:);
posIndex = find(selectedCodes > 0);
selectedCodes = selectedCodes(posIndex);
selectedFreqs = freqOffset(maxWtIndex,posIndex);
selectedWt = maxWtIndex;

%% STEP 3: Compute Optimal Spatial Weights based on the known SV angles, freq/code offsets and
%%        current SV positions from the REF rx
rxSignalVec = zeros(4,NUM_RPTS*NUM_BITS_AVG);
%txSignalNew is the raw Rx signal before ABF
% Compute Covariance matrix from Raw data with corrected freq Offset and Code offset
svIndex = posIndex;
detectedSVs = svIdArray(svIndex);
Rxx = zeros(4);
clear temp1;
clear temp2;
for ii = 1:length(detectedSVs)
    timeOffsetSV = timeOffset(selectedWt,svIndex(ii));
    %data = txSignalNew(timeOffset+1:timeOffset+CODE_LEN*OSR*NUM_RPTS*NUM_BITS_AVG,:);
    data = txSignalNew(timeOffset+1:end,:);
    for jj = 1:4
        data(:,jj) = conv(data(:,jj),hFilt,'same');                                            % RRC filtering
    end
    data = data .* repmat(exp(-J*freqOffset(selectedWt,svIndex(ii))/Fs*(0:length(data)-1))',1,4);  % Freq Offset correction
    for jj = 1:4
        %corr1 = conv(temp1,flipud(code),'same');   % <---- used to 'same' option to pick the center portion
        %corrData = reshape(corr1,CODE_LEN*OSR,NUM_RPTS*NUM_BITS_AVG);
        %corr_fine = sum(corrData(:,1:NUM_NON_COH_INT*COHER_INT_CHIPS),2)/(COHER_INT_CHIPS*NUM_NON_COH_INT);
        temp1(:,jj) = conv(data(:,jj), flipud(refCode(:,detectedSVs(ii))),'same');  % Correlation with code
        % Find the initial offset (why it is not fixed since we have
        % already applied the SV time offset??  <===== FIX THIS ======>
        startIndex_coarse = find(abs(temp1) > max(abs(temp1))*0.4,1,'first');
        [~,startIndex_fine] = max(abs(temp1(startIndex_coarse:startIndex_coarse+10)));
        temp2(:,jj) = temp1(startIndex_coarse+startIndex_fine-1:CODE_LEN*OSR:end,jj);                  % Select only peaks
    end
    Rxx = Rxx + temp2' * temp2/length(temp2);                                     % Convariance matrix
end

% Compute MVDR beamformer weights for all known satellite position vectors 
optWtArray = zeros(4,length(svIdArray));
for ii = 1:length(svIdArray)
    arrayVec = exp(J*sin(svAngleArray(2,ii))*pi/sqrt(2)* ...
        [cos(svAngleArray(1,ii))+sin(svAngleArray(1,ii)); ...
        cos(svAngleArray(1,ii))-sin(svAngleArray(1,ii)); ...
        -(cos(svAngleArray(1,ii))+sin(svAngleArray(1,ii))); ...
        -cos(svAngleArray(1,ii))+sin(svAngleArray(1,ii))]);
    optWt = Rxx \ arrayVec;
    optWt = optWt / (arrayVec' * optWt);   % Normalize the steering vector (MVDR beamformer)
    %[pattern,X,Y,Z] = find_array_pattern_2D(2, 0.5, optWt);
    %figure(ii);polarplot3d(X,Y,Z,pattern); grid;
    optWtArray(:,ii) = optWt;
end

%% STEP 4: Compute quantized ABF and use that to compute the optimal digital BF weights
%%
% Split the optimal BF weights into Analog and Digital portions
%% Method 1: Contruct complex Hadamard matrices from a finnite set of complex numbers
% belonging to a cyclic group. Then, multiply the OptWtArray 4 x N matrix
% with the conjugate transpose of Hadamard matrix to create the digital beamformer, 
% while use the Hadamard matrix as the Analog beam former matrix. 
%% Quantification 1: What is the suppression in the interference level due to
% this new Analog beamformer?
%% Method 2: Perform a SVD of the optimal weights matrix, and use the left
% Singular vector as the Analog beamformer but with phase quantization
% done. The remainig as digital beamformer.
%% Quantification 2: What is the suppression in the interference level due to
% this new Analog beamformer with approximate left singular vectors
%% Method 3: Take the amplitude/angle quantized approximation of optimal weights matrix 
% corresponding to 4 strongest SVs. Apply that as the Analog beamformer and
% recompute the optimal digital beamformer weights. 
%% Quantification 3: What is the suppression in the interference level due to
% this new Analog beamformer and the digital beamformer?

% Quantize the optimum weights with finite precision amplitude and phase
NtPH = 6;
NiPH = 3;
NtAMP = 6;
NiAMP = 6;
maxAmp = max(max(abs(optWtArray)));
newWt = optWtArray/maxAmp;  % Actually select only top 4 SV weights
if (ABF_QNT)
    newWtAngle = angle(newWt);
    newWtMag = abs(newWt);
    newWtAngle = quantize1(newWtAngle,NtPH,NiPH,'signed','round');  % Phase ABF_NT bits
    newWtMag = quantize1(newWtMag, NtAMP,NiAMP,'unsigned','trunc');   % Magnitude ABF_NT bits
    newWtQnt = newWtMag .* exp(J*newWtAngle);
else
    newWtQnt = newWt;
end

% Compute the clean BB signal for upconversion to RF and the payload
payload_bits = zeros(NUM_RPTS*NUM_BITS_AVG,NUM_SVs);
clear temp1;
clear temp2;
clear data;
cleanBBSignal1 = zeros(length(txSignalNew),1);   % Second cleanBBSignal after optimal digital BF
% Apply the DBF (using optWeights) to generate the cleanBBSignal1
for ii = 1:length(detectedSVs)
    timeOffsetSV = timeOffset(ii,svIndex(ii));

    optWt = optWtArray(:,svIndex(ii));
    newRxSignal = txSignalNew * optWt;            % Analog Beamformer-ii's output
    cleanBBSignal1 = cleanBBSignal1 + newRxSignal;  % Interference clean signal
    
%     % Decode the payload
%     data = newRxSignal(timeOffsetSV+1:timeOffsetSV+CODE_LEN*OSR*(NUM_RPTS-1)*NUM_BITS_AVG);
%     data = conv(data,hFilt,'same');                                            % RRC filtering
%     data = data .* exp(-J*freqOffset(svIndex(ii))/Fs*(0:length(data)-1))';  % Freq Offset correction
%     temp1 = conv(data, flipud(refCode(:,svIdArray(ii))),'same');  % Correlation with code
%     startIndex_coarse = find(abs(temp1) > max(abs(temp1))*0.4,1,'first');
%     [~,startIndex_fine] = max(abs(temp1(startIndex_coarse:startIndex_coarse+10)));
%     temp2 = temp1(startIndex_coarse+startIndex_fine-1:CODE_LEN*OSR:end);                  % Select only peaks
%     payload_bits(:,ii) = (temp2 > 0);
end


%% STEP 3: Final optimal Analog and Digital BF weights and cleanBBSignal computation
% Compute Covariance matrix from Raw data with corrected freq Offset and Code offset
svIndex = posIndex;
detectedSVs = svIdArray(svIndex);
Rxx = zeros(4);
clear temp1;
clear temp2;
abfOutput = txSignalNew * newWtQnt;
for ii = 1:length(detectedSVs)
    timeOffsetSV = timeOffset(selectedWt,svIndex(ii));
    %data = txSignalNew(timeOffset+1:timeOffset+CODE_LEN*OSR*NUM_RPTS*NUM_BITS_AVG,:);
    data = abfOutput(timeOffset+1:end,:);
    for jj = 1:4
        data(:,jj) = conv(data(:,jj),hFilt,'same');                                            % RRC filtering
    end
    data = data .* repmat(exp(-J*freqOffset(selectedWt,svIndex(ii))/Fs*(0:length(data)-1))',1,4);  % Freq Offset correction
    for jj = 1:4
        %corr1 = conv(temp1,flipud(code),'same');   % <---- used to 'same' option to pick the center portion
        %corrData = reshape(corr1,CODE_LEN*OSR,NUM_RPTS*NUM_BITS_AVG);
        %corr_fine = sum(corrData(:,1:NUM_NON_COH_INT*COHER_INT_CHIPS),2)/(COHER_INT_CHIPS*NUM_NON_COH_INT);
        temp1(:,jj) = conv(data(:,jj), flipud(refCode(:,detectedSVs(ii))),'same');  % Correlation with code
        % Find the initial offset (why it is not fixed since we have
        % already applied the SV time offset??  <===== FIX THIS ======>
        startIndex_coarse = find(abs(temp1) > max(abs(temp1))*0.4,1,'first');
        [~,startIndex_fine] = max(abs(temp1(startIndex_coarse:startIndex_coarse+10)));
        temp2(:,jj) = temp1(startIndex_coarse+startIndex_fine-1:CODE_LEN*OSR:end,jj);                  % Select only peaks
    end
    Rxx = Rxx + temp2' * temp2/length(temp2);                                     % Convariance matrix
end

% Compute MVDR beamformer weights for all known satellite position vectors 
optWtArray = zeros(4,length(svIdArray));
for ii = 1:length(svIdArray)
    arrayVec = exp(J*sin(svAngleArray(2,ii))*pi/sqrt(2)* ...
        [cos(svAngleArray(1,ii))+sin(svAngleArray(1,ii)); ...
        cos(svAngleArray(1,ii))-sin(svAngleArray(1,ii)); ...
        -(cos(svAngleArray(1,ii))+sin(svAngleArray(1,ii))); ...
        -cos(svAngleArray(1,ii))+sin(svAngleArray(1,ii))]);
    optWt = Rxx \ arrayVec;
    optWt = optWt / (arrayVec' * optWt);   % Normalize the steering vector (MVDR beamformer)
    %[pattern,X,Y,Z] = find_array_pattern_2D(2, 0.5, optWt);
    %figure(ii);polarplot3d(X,Y,Z,pattern); grid;
    optWtArray(:,ii) = optWt;
end

%% Fix the digital weight
dbfWights = optWtArray;
% Compute the clean BB signal for upconversion to RF and the payload
payload_bits = zeros(NUM_RPTS*NUM_BITS_AVG,NUM_SVs);
clear temp1;
clear temp2;
clear data;
cleanBBSignal2 = zeros(length(txSignalNew),1);   % Second cleanBBSignal after optimal digital BF

for ii = 1:length(detectedSVs)
    timeOffsetSV = timeOffset(ii,svIndex(ii));

    optWt = dbfWights(:,svIndex(ii));
    newRxSignal = abfOutput * optWt;            % Analog Beamformer-ii's output
    cleanBBSignal2 = cleanBBSignal2 + newRxSignal;  % Interference clean signal  
%     % Decode the payload
%     data = newRxSignal(timeOffsetSV+1:timeOffsetSV+CODE_LEN*OSR*(NUM_RPTS-1)*NUM_BITS_AVG);
%     data = conv(data,hFilt,'same');                                            % RRC filtering
%     data = data .* exp(-J*freqOffset(svIndex(ii))/Fs*(0:length(data)-1))';  % Freq Offset correction
%     temp1 = conv(data, flipud(refCode(:,svIdArray(ii))),'same');  % Correlation with code
%     startIndex_coarse = find(abs(temp1) > max(abs(temp1))*0.4,1,'first');
%     [~,startIndex_fine] = max(abs(temp1(startIndex_coarse:startIndex_coarse+10)));
%     temp2 = temp1(startIndex_coarse+startIndex_fine-1:CODE_LEN*OSR:end);                  % Select only peaks
%     payload_bits(:,ii) = (temp2 > 0);
end

% Save final results
fname = sprintf('GPS_rx_results_final_%s.mat',date);
save(fname);


