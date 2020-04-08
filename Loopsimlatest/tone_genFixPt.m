%%---------------------------------------------------------------
%% Function to generate tone (DDS) at any sampling frequency
%%
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%---------------------------------------------------------------
%% Version History: (in reverse chronological order please)
%% 
%% V0.1   25-Jul-2016    GanesanT    Created  
%%---------------------------------------------------------------
%%
%% Functions called
%% 
%%  1. quantize1() - Fixed point (Quantization) function
%%---------------------------------------------------------------
%function [tone,endSample] = tone_genFixPt(freq, fs, num, startSample, Nt, Ni)
function [tone,endSample] = tone_genFixPt(freq, fs, num, startSample, Nt, Ni)

J = sqrt(-1);
FIXPT = 1;

if (nargin < 5)
    Nt = 16;
    Ni = 1;
end

if nargin < 4
    startSample = 1+J*0;
end

temp = startSample;
delta = exp(-J*2*pi*freq/fs);

if (FIXPT)
    delta = quantize1(delta, Nt, Ni, 'signed','trunc');
    temp = quantize1(temp, Nt, Ni, 'signed','trunc');
    for index = 1:num
        temp = quantize1(temp * delta, Nt, Ni, 'signed','trunc');
        magn = quantize1(temp * conj(temp), 2*Nt, 2*Ni, 'unsigned','round');
        delm = abs(1 - magn);
        signm = sign(1-magn);
        if (floor(delm*2^Nt) > 0)
            corrfac = quantize1(1+signm*delm/2-signm*3/4*delm^2,Nt, Ni, 'unsigned','round');
            temp = temp * corrfac;
        end
        tone(index) = real(temp);
    end
    endSample = temp;
else
    for index = 1:num
        temp = temp * delta;
        tone(index) = real(temp);
    end
    endSample = temp;
end

% End of function
