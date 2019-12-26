clc;
rand('seed',123);
randn('seed',456);
clear all;
close all;   
tic
%% Initial params
numBits = 10;                        % LFSR length
codeLength = 2^numBits-1;           % Spreading code length 

payload1 = 1*(rand(1,10)>0.5);

payload1 = 2*payload1 - 1;            %BPSK Modulation 

%% PN code generation
                       
% initial sequence is taken from IRNSS document
goldCode1 = generateGoldCode(935,239,codeLength,numBits);
goldCode1 = 2*goldCode1-1;                        % Assign code to 1 to 1 and -1 to 0

%% At transmitter part 
payloadData1 = kron(payload1,goldCode1); 

TxData = payloadData1 ;

%% Time Domain 
crossCorr = xcorr2(TxData,goldCode1);              
outputData = crossCorr(codeLength:codeLength:end)/codeLength;

Timedomain = outputData - payload1 ;
%% Frequency Domain
starting = 1;
i=0;
crossCorr_temp=0;%[zeros(1,100)] ;
goldCodeFFT = conj(fft(goldCode2));
for val = 1023:1023:1023%length(TxData)
  payloadFFT = fft(TxData(starting:val));
  crossCorr_FFT = ifft(payloadFFT .*goldCodeFFT);
  corr_time = crossCorr_FFT(1:end)/codeLength;
  starting = starting +1023;
  i=i+1;
%  crossCorr_temp(1,i) = corr_time;
end

toc