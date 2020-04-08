clc;
%clear all;
close all;
N= 1000;
% rand('seed',123);
% randn('seed',456);
% data = rand(1,5000);
% data = randi(100,[1,20000]);
% data = 0.000001:0.0000001:0.001;
data1 = randn(1,N)*1e-6;
data2 = 1000*randn(1,N);
data = abs([data1 data2 randn(1,N)*1e-3]); 
nt = 18;
ni =  1;
roundmode = 'trunc'; %'round'; % 'trunc'
signmode = 'signed';
numIter = 3;
data = sort(data);

for i = 1:length(data)
    outInbuilt(i) = sqrt(data(i));
    %out(i) = SQRT(data(i),numIter);
    [out_fp(i),expn(i)] = SQRT_fp(data(i),numIter,nt,ni,signmode,roundmode);
%    [answer,shift] = oneBySqrt48(data(i)*2^23);
    output(i) = out_fp(i) * 2^expn(i);
    %if (abs(outInbuilt(i)-output(i)) > 1e-3)
    %  keyboard;
    %  [out_fp(i),expn(i)] = SQRT_fp(data(i),numIter,nt,ni,signmode,roundmode);
    %end
end 

difference = (outInbuilt - out_fp.*(2.^expn)).^2;
% SNR1 = 20*log10(sqrt(mean((outInbuilt - out).^2)))
% SNR2 = 20*log10(sqrt(mean((outInbuilt - output).^2)))
SNR = -10*log10(mean(difference));