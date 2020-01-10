SVID = randi(32,5);
[txSignal, payload, hFilt, codeOffsetArray, freqOffsetArray] = gpsTx(SVID,10,10,0.25);

%% Adding Noise 
snr = -10;
TxData = awgn(txSignal,snr);

J = sqrt(-1);
MAX_CODE_OFFSET = 64;
MAX_FREQ_OFFSET = 5000;
Fs = 10*1e6;
payload_OSR = reshape(repmat(payload,20,1),1,10*20);
numSVs = length(svIdArray);
for nSV = 1:numSVs
    init_g1 = ones(1,10);
    init_g2 = ones(1,10);
    codeLen = 1023;
    fbMode = ['SV',num2str(svIdArray(nSV))];
    [code, symbol] = GPS_GoldSequence_generator(init_g1, init_g2, codeLen, fbMode, codeOffset);
    symbolFFT = conj(fft(symbol));
    temp = TxData((hFiltLen-1)/2+1:end-(hFiltLen-1)/2);
    temp1 = TxData.*exp(-1)*(J*2*pi*freqOffset/Fs*[0:length(temp)-1]);
    temp2 = conv(downsample(temp1, OSR), hFilt);
%     spreadData = kron(symbol,2*payload_OSR-1);
%     temp = conv(upsample(spreadData, OSR), hFilt);
%     temp1 = temp((hFiltLen-1)/2+1:end-(hFiltLen-1)/2);
%     temp2 = temp1 .* exp(J*2*pi*freqOffset/Fs*[0:length(temp1)-1]);
%     txSignal(:,nSV) = transpose(temp2);                % make it a column vector
%     codeOffsetArray(nSV) = codeOffset;
%     freqOffsetArray(nSV) = freqOffset;

starting = 1+codeOffsetArray(nSV);
i=1;
FrequencyDomain=zeros(1,numBits);
goldCodeFFT = conj(fft(goldCode1));
for val = (offsetval+1023):1023:length(TxData)
  payloadFFT = fft(TxData(starting:val));
  crossCorr_FFT = ifft(payloadFFT .*goldCodeFFT);
   FrequencyDomain(1,i) =crossCorr_FFT(1)/codeLength; 
   starting = starting +1023;
%   disp(['index value for ' num2str(i) ]);
%   [valueP,indexP] = max(crossCorr_FFT);
%   [valueN,indexN] = max(-crossCorr_FFT);
   i=i+1;
end
end  % End of nSV

