%% Function to create the Tx signal for the given list of SVs
%%
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%---------------------------------------------------------------
%% Usage:
%% function [txSignal, payload, hFilt, codeOffsetArray, freqOffsetArray, symbol] = gpsTx(svIdArray, numBits, OSR, alpha)
%%
%% Version History: (in reverse chronological order please)
%%
%% ver  0.1   10-Jan-2020   Sudhanshu             Created

%% changes made:
%% line 56 gpsTx.m
%% Sending goldcode with gpsTx()
%% currently with no codeOffset only with FreqOffsetArray. 


[txSignal, payload, hFilt, codeOffsetArray, freqOffsetArray,symbol] = gpsTx();

%% Adding Noise 
snr = 0;
txSignal = awgn(txSignal,snr);

%% Reciever 
codeLen = 1023;
OSR = 10;
Fs = OSR*1e6;
J = sqrt(-1);
[lengthtx, numSVs] =size(txSignal);
RxData = zeros(200,numSVs);
crossCorrData = zeros((lengthtx/10)+60,numSVs);
for nSV = 1:numSVs
temp2 = txSignal(:,nSV)';
tx = temp2.*exp(J*(-1)*2*pi*freqOffsetArray(nSV)/Fs*[0:lengthtx-1]);
tx = real(tx);
downsamtx = downsample(tx,OSR);
downsamtx_hfilt = conv(downsamtx,hFilt);
downsamtx_hfilt = real(downsamtx_hfilt);
crossCorr = xcorr2(downsamtx_hfilt,symbol(:,1));              
outputData = crossCorr(codeLen:codeLen:end)/codeLen;
RxData(:,nSV) = outputData;
% plot(outputData)
crossCorrData(:,nSV) = crossCorr;
end 

