% Function to compute the angle of the given complex number using CORDIC
% rotations.
% USAGE:
% function [ang] = cordic_angle(re, im, <numIter>)
%
% (C) 2016 MMRFIC Systems

% Version History
% No.      Date         Author            Comment
% 0.1      06-May-16    MMRFIC            Created
function [ang] = cordic_angleFixPt(re, im, numIter, Nt, Ni)

if (nargin < 3)
    numIter = 20;
end 

if (nargin < 4)
    Nt = 16;
end

if (nargin < 5)
    Ni = 4;
end 

quad1 = (re < 0)*2+(im < 0);  % Quadrant information

re = abs(re);
im = abs(im);

wtArray = 2.^(-(0:numIter-1));
angArray = quantize1(atan(wtArray),32,1,'unsigned','round');
ang = 0;
signn = sign(im);

for index = 1:numIter
    ang = ang + signn * angArray(index);
    wt = wtArray(index);
    
    re1 = quantize1(re + signn * wt * im, Nt, Ni,'signed','trunc');
    im1 = quantize1(im - signn * wt * re, Nt, Ni,'signed','trunc');
    
    re = re1;
    im = im1;
    
    signn = sign(im1);
end

switch (quad1)
    case 0     % first quadrant - no correction needed
    case 1     % only -ve imag
        ang = quantize1(2*pi-ang, Nt, Ni, 'unsigned','trunc');
    case 2     % only -ve real
        ang = quantize1(pi-ang, Nt, Ni, 'unsigned','trunc');
    case 3     % real and imag -ve
        ang = quantize1(ang + pi, Nt, Ni, 'unsigned','trunc');
    otherwise
        error('Error in quadrature info');
end

% End of function