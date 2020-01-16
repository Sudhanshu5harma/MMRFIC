%% Function to create the Tx signal for the given list of SVs
%%
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%---------------------------------------------------------------
%% Usage:
%% function [txSignal, payload, hFilt, codeOffsetArray, freqOffsetArray] = gpsTx(svIdArray, numBits, OSR, alpha)
%%
%% Version History: (in reverse chronological order please)
%%
%% ver  0.1   06-Jan-2020   Ganesan, T             Created

function [txSignal, payload, hFilt, codeOffsetArray, freqOffsetArray,GoldcodeSym] = gpsTx(svIdArray, numBits, OSR, alpha)

if (nargin < 1)
    svIdArray = randi(32,5);    % Random 5 SVs
end

if (nargin < 2)
    numBits = 100;  % 10*20 msec duration
end

if (nargin < 3)
    OSR = 10;      % 10x oversampling => 10.23 MHz sampling rate
end

if (nargin < 4)
    alpha = 0.25;   % Default excess bandwidth for root Raised cosine pulse
end

numSVs = length(svIdArray);
payload = 1*(rand(1,numBits) > 0.5);                         % Random payload
payload_OSR = reshape(repmat(payload,20,1),1,numBits*20);    % 50 Hz rate
payload_OSR = 2*payload_OSR-1;
hFilt = rcosdesign(alpha,6,OSR,'sqrt');                      % OSR times oversampled with alpha excess BW
hFiltLen = length(hFilt);

J = sqrt(-1);
MAX_CODE_OFFSET = 64;
MAX_FREQ_OFFSET = 5000;
codeOffsetArray = zeros(1,numSVs);
freqOffsetArray = zeros(1,numSVs);
txSignal = zeros(numSVs,20*numBits*1023*OSR);
GoldcodeSym = zeros(numSVs,1023);
Fs = OSR*1e6;

for nSV = 1:numSVs
    init_g1 = ones(1,10);
    init_g2 = ones(1,10);
    codeLen = 1023;
    fbMode = ['SV',num2str(svIdArray(nSV))];
    codeOffset = floor(rand*MAX_CODE_OFFSET);   % Maximum of 64 code phase
    freqOffset = MAX_FREQ_OFFSET *(rand-0.5);   % +/- 5K freq offset
    
    [code, symbol] = GPS_GoldSequence_generator(init_g1, init_g2, codeLen, fbMode, codeOffset);
    spreadData = kron(payload_OSR,symbol);
    temp = conv(upsample(spreadData, OSR), hFilt);
    temp1 = temp((hFiltLen-1)/2+1:end-(hFiltLen-1)/2);
    temp2 = temp1 .* exp(J*2*pi*freqOffset/Fs*[0:length(temp1)-1]);
    %txSignal(:,nSV) = transpose(temp2);                % make it a column vector
    txSignal(nSV,:) = temp2;                            % sending as a row 
    GoldcodeSym(nSV,:) = symbol;
    codeOffsetArray(nSV) = codeOffset;
    freqOffsetArray(nSV) = freqOffset;
end  % End of nSV

end  % End of function
