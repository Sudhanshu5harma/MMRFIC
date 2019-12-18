clc all;
pkg load communications;
pkg load signal;
pkg load image;
format long;
%GENERATION OF GOLD CODE
clc,clear all; close all;
g1=[0 0 1 0 0 0 0 0 0 1]; % COULDN'T FIND THE ACTUAL VALUE TAKEN RANDOM FOR NOW
g2=[1 1 1 0 1 0 0 1 1 1]; 
n=10;
g1_f=[];
g2_f=[];
N =32; % NUMBER OF BITS IN GOLDCODE
for i=1:N
  g1_f= [ g1_f g1(10) ];
  g1_temp=xor(g1(3),g1(10));
  g1(2:n)=g1(1:n-1);
  g1(1)=g1_temp;
  g2_f= [ g2_f g2(10) ];
  g2_temp = xor(g2(2),g2(3),g2(6),g2(8),g2(9),g2(10));
  g2(2:n)=g2(1:n-1);
  g2(1)=g2_temp; 
endfor
g=xor(g1_f,g2_f);
% POLAR CONVERSION
for m =1:length(g)
  if g(m)==0
    polar_gcode(m)=-1;
  else 
    polar_gcode(m)=1;
  end
endfor
% GENERATION OF PAYLOAD
fs = 32000;
time = 0:1/fs:.1-1/fs;
payload = 2*(rand(1,100) > 0.5)-1
payload1 = reshape(repmat(payload,32,1),1,3200);
% REPEATING GOLDCODE TO MATCH THE PAYLOAD 
gold_g= repmat(polar_gcode,1,100);
baseband= payload1.*gold_g;
baseband_n=awgn(baseband,1);

% CORRELATION OR FILTER
cc= filter(fliplr(polar_gcode),1,baseband);
cc1 = cc(32:32:end);
cc_out=cc1/32;
##plot(1:32:3200,cc(1:32:end),'ro');
cc_n=filter(fliplr(polar_gcode),1,baseband_n);
cc1_n = cc_n(32:32:end);
cc_nout=cc1_n/32
% GRAPHS
subplot(4,1,1);
plot(time,payload1,'r');
xlabel('Time (bit period)');ylabel('Amplitude');
title('Payload with Gold Code');
axis([0 0.1 -2 2]);grid  on;
##hold on;
##plot(time,gold_g);
subplot(4,1,2);
plot(baseband);
xlabel('Time (bit period)');ylabel('Amplitude');
title('Baseband');
axis([-1 3200 -2.0 2.0]);
grid on;
subplot(4,1,3)
plot(cc);
axis([-1 3200 -40.0 40.0]);
title("Filter Output");
grid on;
subplot(4,1,4)
plot(cc_n);
#hold on ; plot(cc_n,'ro')
axis([-1 3200 -40.0 40.0]);
title("Filter Output noise");
grid on;
######################
##for k=2:length(cc_n)-1
##if (cc_n(k)>cc_n(k-1)&&cc_n(k)>cc_n(k+1)&&cc_n(k)>20)||(cc_n(k)<cc_n(k-1)&&cc_n(k)<cc_n(k+1)&&cc_n(k)<-20)
##k
##disp('peak');
##end
##endfor
psnr(cc_n,cc)
psnr(cc,cc_n)
