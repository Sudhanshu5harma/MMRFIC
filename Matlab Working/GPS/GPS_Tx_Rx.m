%%---------------------------------------------------------------
%% Program to implement GPS Transmitter and Receiver.
%%
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%---------------------------------------------------------------
%% Version History: (in reverse chronological order please)
%%  0.1  :  29-Nov-2019  :  Srinivasan  :  Created
%%---------------------------------------------------------------

clc;
clear all;
close all;

%% Initial params
numBits = 9;                        % LFSR length
codeLength = 2^numBits-1;           % Spreading code length 
payload = 1*(rand(1,100)>0.5);
% payload = 1:100;
payload = 2*payload - 1;            %BPSK Modulation 

%%PN code generation
polynomial1 = [1 0 0 1 0 1 1 1 1 1]; %x^9 + x^8 + x^7 + x^6 + x^5 + x^3 + 1
polynomial2 = [1 0 1 0 0 1 0 0 0 1]; %x^9 + x^5 + x^3 + x^2 + 1

initialState_G1 = dec2bits(255,numBits);            %Initial state for polynomial 1
initialState_G2 = dec2bits(255,numBits);            %Initial state for polynomial 2
      
prn1 = gf2polyGenPrn(initialState_G1,polynomial1,codeLength);        % PN sequence1
prn2 = gf2polyGenPrn(initialState_G2,polynomial2,codeLength);        % PN sequence2 

goldCode = xor(prn1,prn2);                      % ex-or to get the gold code 
goldCode = 2*goldCode-1;                        % Assign code to 1 and -1

%% At transmitter part 
payloadData = kron(payload,goldCode);         % Product of payload data and gold code 
    
%% At receiver part 
crossCorr = xcorr2(payloadData,goldCode);              
outputData = crossCorr(codeLength:codeLength:end)/codeLength;

if (sum(outputData - payload) == 0)
    disp('Payload data detected.....')
end 


