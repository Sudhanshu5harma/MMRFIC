clc;
rand('seed',123);
randn('seed',456);
clear all;
close all;   
tic
%% Initial params
numBits = 10;                        % LFSR length
codeLength = 2^numBits-1;            % Spreading code length 

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
TxData1 = payloadData1 +payloadData2;

%% Padding random number and finding the value of offset

TxData = [1*(rand(1,100)>0.5) TxData1];
padded =  xcorr2(TxData(1:3*codeLength),goldCode1);
offset = find(abs(padded) > codeLength/2,1);
offsetval = offset - codeLength;

%% Time Domain 

crossCorr = xcorr2(TxData1,goldCode1);              
outputData = crossCorr(codeLength:codeLength:end)/codeLength;

%% Frequency Domain with padded Tx bits

starting = 1+offsetval;
i=1;
FrequencyDomain=zeros(1,numBits);
goldCodeFFT = conj(fft(goldCode1));
for val = (offsetval+1023):1023:length(TxData)
  payloadFFT = fft(TxData(starting:val));
  crossCorr_FFT = ifft(payloadFFT .*goldCodeFFT);
  FrequencyDomain(1,i) =crossCorr_FFT(1)/codeLength; 
  starting = starting +1023;
  i=i+1;
end

%% Plotting 
stem(FrequencyDomain,'b');grid on;
hold on ; stem(payload1,'r');
toc