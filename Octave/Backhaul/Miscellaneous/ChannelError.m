%function to perform channel encoding 
function [Chp, ChO] = ChannelError(P,ChR,encoded_bits) 
  for i=1:length(ChR)
    if (ChR(i)<(1-P))
      ChR(i)=0;
    else
      ChR(i)=1;
    endif
  end
Chp = ChR; % Generated channel Probability
% XORing Channel Probability woth Encoded Bits 
ChO = bitxor(ChR,encoded_bits);
end

