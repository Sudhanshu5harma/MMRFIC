%%---------------------------------------------------------------
%% Program to implement GPS Transmitter and Receiver.
%%
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%---------------------------------------------------------------
%% Version History: (in reverse chronological order please)
%%  0.4                                   Correlate single output data
%%  0.3     18-Dec-2019     Srinivasan     Receiver done with frequency domain data acquisation
%%  0.2     02-Dec-2019     Srinivasan     Added multiple payload in Tx  
%%  0.1  :  29-Nov-2019  :  Srinivasan  :  Created
%%---------------------------------------------------------------

clc;
clear all;
close all;

tic
%% Initial params
numBits = 10;                        % LFSR length
codeLength = 2^numBits-1;           % Spreading code length 

payload1 = 1*(rand(1,100)>0.5);
payload2 = 1*(rand(1,100)>0.5);
payload3 = 1*(rand(1,100)>0.5);

payload1 = 2*payload1 - 1;            %BPSK Modulation 
payload2 = 2*payload2 - 1;            %BPSK Modulation 
payload3 = 2*payload3 - 1;            %BPSK Modulation 

## payload1 = ones(1,10);
## payload2 = ones(1,10)*2;
## payload3 = ones(1,10)*3;
%% PN code generation
                       
% initial sequence is taken from IRNSS document
goldCode1 = generateGoldCode(935,239,codeLength,numBits);
goldCode1 = 2*goldCode1-1;                        % Assign code to 1 to 1 and -1 to 0

goldCode2 = generateGoldCode(38,381,codeLength,numBits);
goldCode2 = 2*goldCode2-1;

goldCode3 = generateGoldCode(564,561,codeLength,numBits);
goldCode3 = 2*goldCode3-1;

%% At transmitter part 
payloadData1 = kron(payload1,goldCode1);         % Product of payload data and gold code to spread the sequence
payloadData2 = kron(payload2,goldCode2);    
payloadData3 = kron(payload3,goldCode3);


TxData = (payloadData1 + payloadData2 + payloadData3);

%% At receiver part 
%% Time Domain 
crossCorr = xcorr2(TxData,goldCode2);              
outputData = crossCorr(codeLength:codeLength:end)/codeLength;

% orthogonalTest1 = goldCode1*goldCode2'
% orthogonalTest2 = goldCode3*goldCode2'
% orthogonalTest3 = goldCode3*goldCode1'
if (abs(sum((round(outputData)) - payload2)) < 1e-3)
    disp('Payload data detected in Time domain.....')
end 
%% Frequency domain 

numOut = length(TxData) + length(goldCode2) - 1;
payloadFFT = fft(TxData,numOut);
goldCodeFFT = conj(fft(goldCode2,numOut));
crossCorr_FFT = ifft(payloadFFT .* goldCodeFFT); #abs(ifft(payloadFFT .* goldCodeFFT));
corr_time = crossCorr_FFT(1:codeLength:end)/codeLength;
corr_time = corr_time(1:length(payload1));
if (abs(sum((round(corr_time)) - payload2)) < 1e-3)
    disp('Payload data detected in Frequency domain.....')
end 
toc