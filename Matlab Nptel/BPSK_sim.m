R = 1/3; %uncoded BPSK
EbNodB = 6; 
EbNo =  10^(EbNodB/10);
sigma = sqrt(1/(2*R*EbNo));
BER_th = 0.5*erfc(sqrt(EbNo));
k = 1 ; %message
n = 3;  %codeword
N_err =0; N_blocks =10000;
for i = 1:N_blocks
    msg = randi([0,1],1,k);
    %encoding
    cword = [msg msg msg];
    
    s = 1 - 2*cword;
    r = s + sigma*randn(1,n);
    % hard decision 
    b = (r<0);
    if sum(b)>1
        msg_cap1 = 1;
    else 
        msg_cap1 = 0;
    end
    %soft decision
    if sum(r)<0
        msg_cap2 =1;
    else
        msg_cap2 =0;
    end
    
    N_err = N_err + sum(msg~=msg_cap2);
end
BER_sim = N_err/k/N_blocks;

disp([EbNodB BER_th BER_sim N_err N_blocks])