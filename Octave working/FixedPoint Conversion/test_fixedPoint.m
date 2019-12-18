SNR=1:1:10;
for ErrorPro = 1 : length(SNR) 
    x = sqrt(1/10^(SNR(ErrorPro)/10));
nt=9
##ni=ceil(log2(max(sigma)))
ni=0;
x_fp = quantize1(x,nt,ni,'unsigned','round');
difference = sum(x-x_fp)
end
