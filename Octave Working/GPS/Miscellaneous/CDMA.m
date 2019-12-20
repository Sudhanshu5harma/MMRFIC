clc;
close all;
clear all;
pkg load communications
rand('seed',123);
randn('seed',456);
Size_ip=20;
b = round(rand(1,Size_ip));
ln=length(b);

% Converting bit 0 to -1  
inputbits  = (2*b-1);
% Generating the bit sequence with each bit 8 samples long
sampled_input=reshape(repmat(b,8,1),1,160);
len=length(sampled_input);
subplot(2,1,1);
stairs(sampled_input,'linewidth',2); axis([0 len -2 3]);
title('ORIGINAL BIT SEQUENCE input(t)');
% Generating the pseudo random bit pattern for spreading 
%GENERATION OF GOLD CODE
g1=[1 0 0 1 0 0 0 0 0 0 1];%G1: X^10 + X^3 + 1 and G2: X^10 +X^9 + X^8 + X^6 +X^3 + X^2 + 1 % COULDN'T FIND THE ACTUAL VALUE TAKEN RANDOM FOR NOW
g2=[1 0 1 1 0 0 1 0 1 1 1]; 
n=10; % linear shift registers
g1_f=[];
g2_f=[];
N =len; % NUMBER OF BITS IN GOLDCODE
for i=1:N
  g1_f= [ g1_f g1(10) ];
  g1_temp=xor(g1(1),g1(4),g1(6),g1(7),g1(9),g1(10));
  g1(2:n)=g1(1:n-1);
  g1(1)=g1_temp;
  g2_f= [ g2_f g2(10) ];
  g2_temp = xor(g2(3),g2(4),g2(5),g2(6),g2(7),g2(8),g2(9),g2(10));
  g2(2:n)=g2(1:n-1);
  g2(1)=g2_temp; 
endfor
goldcode=xor(g1_f,g2_f);
% POLAR CONVERSION
polar_gcode  = (2*goldcode-1);
absolute_self_correlation = sum(xcorr(polar_gcode))
subplot(2,1,2);
stairs(polar_gcode,'linewidth',2); axis([0 len -2 3]);
title('PSEUDORANDOM BIT SEQUENCE polar_gcode(t)');
% Multiplying bit sequence with Pseudorandom Sequence
for i=1:len
   bbs(i)=sampled_input(i).*polar_gcode(i);
end
%OUTPUT SEQUENCE inputbits(t)*goldcode(t)
Sampled_output=bbs.*polar_gcode;
op1=reshape(Sampled_output,8,20);
[inputbits' op1(1,:)'];
% Modulating the hopped signal
dsss=[];
t=0:1/10:2*pi;   
c1=cos(t);
c2=cos(t+pi);
for k=1:len
    if bbs(1,k)==-1
        dsss=[dsss c1];
    else
        dsss=[dsss c2];
    end
end
figure,
subplot(2,1,1);
stairs(bbs,'linewidth',2); axis([0 len -2 3]);
title('MULTIPLIER OUTPUT SEQUENCE inputbits(t)*goldcode(t)');
subplot(2,1,2);
stairs(Sampled_output,'linewidth',2); axis([0 length(Sampled_output) -2 3]);
title(' output ');
figure
plot(dsss);axis([0 length(dsss) -2 2])
title(' DS-SS SIGNAL...');