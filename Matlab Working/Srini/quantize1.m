function out = quantize1(inp, nt, ni, signmode, roundmode)
%%% (input,totalbits,integerbits, signmode,roundmode)  %%%
J = sqrt(-1);
if (nargin < 4)
    signmode = 'signed';
end
if (nargin < 5)
    roundmode = 'floor';
end

if strcmp(signmode,'signed')
    smode = 1;
else
    smode = 0;
end

rmode = 0;  % undefined mode
if strcmp(roundmode,'floor')
    rmode = 0;
end
if strcmp(roundmode,'round')
    rmode = 1;
end

if isreal(inp)
    cmplx = 0;
else
    cmplx = 1;
end

reInp = real(inp);
imInp = imag(inp);

if (cmplx)
    reOut = quant_real(reInp, nt, ni, smode, rmode);
    imOut = quant_real(imInp, nt, ni, smode, rmode);
    out = reOut + J*imOut;
else
    out = quant_real(inp, nt, ni, smode, rmode);
end

% End of quantize function

function out = quant_real(inp, nt, ni, smode, rmode)

if (~smode)
    index = (inp < 0);
    if ~isempty(index)
%        disp('*** WARNING: Negative number in unsigned format');
%        disp('*** Converting to postive number');
        inp(index) = -inp(index);
    end
end

nf = nt-smode-ni;

if (rmode == 0)
    out = floor(inp * 2^nf);   % quantize to nt-sign bits
elseif (rmode == 1)
    out = round(inp * 2^nf);   % round it nearest fraction bit
else
    out = fix(inp * 2^nf);   % default mode
end

MAX_POS = (2^(ni+nf))-1;
MAX_NEG = -2^(ni+nf);
%posIndex = (out > 0);
%out(posIndex) = floor(out(posIndex)*(2^nf-1))/2^nf;
index = (out >= MAX_POS);
out(index) = MAX_POS;   % saturate on positive side
index = (out <= MAX_NEG);
out(index) = MAX_NEG;   % saturate on negative side

out = out/2^nf;

% End of quant_real function

