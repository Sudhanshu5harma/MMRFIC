% Function [pkEst, phEst1] = peakEstFixedPt(y,M,Ts,f,mode, OSR, OSR1)       
% function [pkEst, phEst] = peakEstFixedPt(x,y,M,Ts,f,mode, OSR, OSR1, Fs)       
%%---------------------------------------------------------------
%% Program to estimate the peak of the sinusoid
%%
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%---------------------------------------------------------------
%% Version History: (in reverse chronological order please)
%% 
%% V0.2   26-Sep-2016    GanesanT    Modified to run with new interpolation code 
%% V0.1   18-Jul-2016    GanesanT    Created  
%%---------------------------------------------------------------
%%
%% Functions called
%%
%%  1. interp_poly_v2()
%%---------------------------------------------------------------
function [pkEst, pkEst_fp] = peakEstFixedPt_v2(y,M,Ts,f,~)       

J = sqrt(-1);
 
z = exp(-J*2*pi*f*(0:M-1)*Ts);         % Compute Fourier coefficient at desired freq
% Fixed point version of the complex tone generator
omode = 'complex';
Nt = 16;
Ni = 0;
startSample = 1+J*0;
num = M;
freq = f;
fs = 1/Ts;
z_fp = tone_genFixPt_v2(freq, fs, num, startSample, Nt, Ni, omode);
z_fp = z_fp(:);
 
Y = dot(y,z);
% Fixed point version of dot product computation
Nt = 24;
Ni = 0;
[Y_fp,newNi] = dotProduct_fp(y,z_fp, Nt, Ni);

% phEst = ((pi/2)+angle(Y));           % Estimate the phase in radians
% Quantize phEst angle
% phEst = (pi/2)+angle(Y_fp);
numIter = 20;
Nt = 24;
phEst_fp = mod((pi/2)+cordic_angleFixPt(real(Y_fp), imag(Y_fp), numIter, Nt, newNi),2*pi);

%% Why this offset is needed to match??
%if (phEst > pi)
%    phEst = phEst - 2*pi;
%end
phEst = phEst_fp;
if (phEst < 0)
     phEst = 2*pi+phEst;
     % Quantize phEst angle
end
%elseif (phEst > pi/2)
%    phEst = -2*pi+phEst;
%end
 
phEst1 = phEst/(2*pi*f);                       % find delay in sec from phase in radians
del1 = (1/4/f)-phEst1;                         % offset from ideal delay (T/4)
% Fixed point version of the division code
Nt = 24;
Ni = 0;
ONE_BY_4PI = quantize1(1/4/pi,Nt,Ni,'unsigned','round');
Nt = 36;
Ni = 0;
ONE_BY_F = quantize1(1/f,Nt,Ni,'unsigned','trunc');
del1_fp = ONE_BY_F*(pi-2*phEst)*ONE_BY_4PI;
 
% if (del1 < 0)
%     del1 = del1 + (1/f);   % take from next cycle
% end
% Quantize del1
if (del1_fp < 0)
    del1_fp = quantize1(del1_fp + ONE_BY_F, Nt,Ni,'unsigned','trunc');   % take from next cycle
end

del1 = del1_fp;
% tVec = [0:M-1]*Ts;
 
%pkEst = interp1(tVec, y, [del1:1/f:(M-1)*Ts], 'spline', 'extrap');  % Matlab interpolation
%pkEst = interp_poly_v2(tVec/Ts, y, [del1:1/f:(M-1)*Ts]/Ts);
Nt = 32;
Ni = 28;
ONE_BY_TS = quantize1(1/Ts,Nt,Ni,'unsigned','trunc');
pkEst = interp_poly_v2((0:M-1), y, (del1*ONE_BY_TS:ONE_BY_TS*ONE_BY_F:(M-1)));
pkEst_fp = interp_poly_v3_fp((0:M-1), y, (del1*ONE_BY_TS:ONE_BY_TS*ONE_BY_F:(M-1)));
 
end

% End of function 