%## Copyright (C) 2020 MMRFIC
%## Author: MMRFIC <MMRFIC@MMRFIC-PC>
%## Created: 2020-03-25
% Function to compute the RMS value of a vector input
% function [rms_val,scale] = rms_fp(adcOutput);
function [rms_val,scale] = rms_fp(inpvec)
len = length(inpvec);
len2Bits = ceil(log2(len));
sum_fp = 0;
for ii = 1:len
  sum_fp = sum_fp + quantize1(inpvec(ii)*inpvec(ii)/1024,32,0,'unsigned','trunc');
end
rms_val = quantize1(1024*sum_fp, 32, len2Bits,'unsigned','trunc');
scale = len2Bits; %quantize1(1024/2^len2Bits, 16, 10, 'unsigned','trunc');

end % of function rms_fp()
