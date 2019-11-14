function bits = dec2bits(inVec, decimals)

inVec = inVec(:);
len = length(inVec);

bits = reshape( (bitand(repmat(inVec,1,decimals), ...
 repmat(2.^[decimals-1:-1:0],len,1)) > 0)',1,decimals*len);