
pkg load communications
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
numExpts=10;
BiterrSum=0;
SNR=1:1:10;
for i=1:numExpts
  for vari=1:length(SNR)
    channelOutput(:,vari) = awgn(ModBpsk',SNR(vari));
  end
Demoded=llr(channelOutput);
for q=1:length(SNR)
    Biterr(q) = sum(abs(encoded(:,1)-Demoded(:,q)));
  end
##BiterrSum=Biterr(i)
BiterrSum=Biterr+BiterrSum;
endfor
BiterrAvg= BiterrSum/numExpts/length(encoded)