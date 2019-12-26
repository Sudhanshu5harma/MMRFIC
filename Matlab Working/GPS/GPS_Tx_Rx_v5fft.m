% clc;
rand('seed',123);
randn('seed',456);
% clear all;
% close all;   
tic
%% Initial params
numBits = 10;                        % LFSR length
codeLength = 2^numBits-1;           % Spreading code length 

payload1 = 1*(rand(1,1000)>0.5);

payload1 = 2*payload1 - 1;    

payload2 = 1*(rand(1,1000)>0.5);

payload2 = 2*payload2 - 1;  %BPSK Modulation 

%% PN code generation
                       
% initial sequence is taken from IRNSS document
goldCode1 = generateGoldCode(935,239,codeLength,numBits);
goldCode1 = 2*goldCode1-1;                        % Assign code to 1 to 1 and -1 to 0

goldCode2 = generateGoldCode(38,381,codeLength,numBits);
goldCode2 = 2*goldCode2-1;                        % Assign code to 1 to 1 and -1 to 0

%% At transmitter part 
payloadData1 = kron(payload1,goldCode1); 
payloadData2 = kron(payload2,goldCode2);
TxData = payloadData1 +payloadData2;

%% Time Domain 
crossCorr = xcorr2(TxData,goldCode1);              
outputData = crossCorr(codeLength:codeLength:end)/codeLength;

Timedomain = outputData - payload1 ;
%% Frequency Domain

starting = 1;
i=1;
FrequencyDomain=zeros(1,numBits);
goldCodeFFT = conj(fft(goldCode1));
for val = 1023:1023:length(TxData)
  payloadFFT = fft(TxData(starting:val));
  crossCorr_FFT = ifft(payloadFFT .*goldCodeFFT);
   FrequencyDomain(1,i) =crossCorr_FFT(1)/codeLength; 
%    FrequencyDomain(1,i) = sum(crossCorr_FFT);
  starting = starting +1023;
  i=i+1;
end
stem(FrequencyDomain);grid on;
hold on ; stem(payload1,'r');
toc