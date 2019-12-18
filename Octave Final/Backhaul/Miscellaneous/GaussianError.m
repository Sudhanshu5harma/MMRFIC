clc;clear all;
rand('seed',123);
randn('seed',456);
encoded = round(rand(441,1));%% 441 bits 
for len=1:length(encoded) %% 1---->-1 & 0----->1
  if(encoded(len)==0)
    ModBpsk(len)=1;
  else
    ModBpsk(len)=-1;
  endif
endfor

%% LLR 
function z = llr(input) %% z = output 
  [row col] = size(input);
  for i=1:row
     for j=1:col
         if input(i,j)>0
             z(i,j) = 0;
         end
         if input(i,j)<0
             z(i,j) = 1;
         end
     end
end
endfunction
%%Experiments
numExpts=1000;
SNR=1:1:10;
for vari=1:length(SNR)
  for i=1:numExpts
    channelOutput(:,vari) = awgn(ModBpsk',SNR(vari));
    Demoded=llr(channelOutput);
    Biterr(vari) = sum(abs(encoded(:,1)-Demoded(:,vari)));
    BiterrSum(vari) = Biterr(vari)
  end
  
Biterr
endfor