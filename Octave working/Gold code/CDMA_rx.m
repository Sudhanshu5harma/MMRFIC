clc;
spread=[];
##Data=((randint(1,8))>.5)+0;
Data=((randi(1,8))>.5)+0;
##Goldcode=((randint(1,15))>.5)+0;
Goldcode=((randi(1,15))>.5)+0;
k=1;
LD=length(Data);
LG=length(Goldcode);
for i=1:LD
for j=1:LG
    spread(1,k)=xor(Data(1,i),Goldcode(1,j));
    k=k+1;
end
end
spread
%.......bit time............
figure
Tb=10;
Data_pulse = rectpulse(Data(1,:),10);
subplot(3,1,1); 
stem(Data_pulse);
ylabel('\bf Original Bit Sequence'); 
title('\bf\it TRANSMITTED MESSAGE');
Gold_pulse = rectpulse(Goldcode(1,:),10);
subplot(3,1,2); 
stem(Gold_pulse);
ylabel('\bf Gold Code');
%.........................
spreaded_pulse = rectpulse(spread(1,:),10);
subplot(3,1,3); 
stem(spreaded_pulse); 
ylabel('\bf Spreaded Sequence')
%-------Demodulation to get original message signal---------
i=1;
k=1;
los= length(spread);
while k < los
    s=0;
for j=1:15
temp(1,j) = xor(spread(1,k),Goldcode(1,j)); 
k=k+1;
s=s+temp(1,j); 
end
if(s==0)
    b2(1,i) = 0;
else
    b2(1,i) = 1; 
end
    i=i+1; 
end
despreaded_signal = b2;
%-----Plotting Despreaded signal------
figure
pattern=[];
for k=1:8
if b2(1,k)==0
   sig=zeros(1,10);
else
 sig=ones(1,10);
end
pattern=[pattern sig]
end
subplot(3,1,1); 
stem(spreaded_pulse);
ylabel('\bf Spreaded Sequence'); 
title('\bf\it Received MESSAGE');
Gold_pulse = rectpulse(Goldcode(1,:),10);
subplot(3,1,2); 
stem(Gold_pulse);
ylabel('\bf Gold Code');
subplot(3,1,3); 
stem(pattern); 
ylabel('\bf Despreaded Sequence')
