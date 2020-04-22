R = 4/7; %7/4 Hamming code(4/7 bits/symbol)
EbNodB = 4; 
EbNo =  10^(EbNodB/10);
sigma = sqrt(1/(2*R*EbNo));


k = 4 ; %message bits 
n = 7;  %codeword bits 
cwords = [  0   0     0     0     0     0     0;  
     0     0     0     1     0     1     1;
     0     0     1     0     1     1     0;
     0     0     1     1     1     0     1;
     0     1     0     0     1     1     1;
     0     1     0     1     1     0     0;
     0     1     1     0     0     0     1;
     0     1     1     1     0     1     0;
     1     0     0     0     1     0     1;
     1     0     0     1     1     1     0;
     1     0     1     0     0     1     1;
     1     0     1     1     0     0     0;
     1     1     0     0     0     1     0;
     1     1     0     1     0     0     1;
     1     1     1     0     1     0     0;
     1     1     1     1     1     1     1];
Nbit_err =0; Nblkerrs=0; N_blocks =10000;
for i = 1:N_blocks
    msg = randi([0,1],1,k); % generate random k-bits message
    %Encoding
    cword = [msg mod(msg(1)+msg(2)+msg(3),2)...
            mod(msg(2)+msg(3)+msg(4),2)...
            mod(msg(1)+msg(2)+msg(4),2)]; % (7,4) hamming 
    
    Bit2symbol = 1 - 2*cword; % BPSK bits to symbol conversion
    Channeloutput = Bit2symbol + sigma*randn(1,n); % AWGN channel
   
    % Hard decision Decoding - dist(Channeloutput,codeword)
    Threshold = (Channeloutput<0); % threshold at zero
    dist = mod(repmat(Threshold,16,1)+cwords,2)*ones(7,1);
    [mind1,pos1] = min(dist);
    msg_cap1 = cwords(pos1,1:4);
    
    %soft decision Decoding - 
    % Method 1 - distance between real received codewords and possible symbol vector- Euclidian distance
    % Method 2 - max correlation with recevied vector in case of BPSK hence max(dot product) 
    corr = (1-2*cwords)*Channeloutput';
    [mind2,pos2] =max(corr);
    msg_cap2 = cwords(pos2,1:4);
    
    Nerrs =sum(msg~=msg_cap1);
    if Nerrs>0
        Nbit_err = Nbit_err +Nerrs;
        Nblkersr =Nblkerrs+1;
    end   
    
end

BER_sim = Nbit_err/k/N_blocks;
FER_sim = Nblkerrs/N_blocks;



disp([EbNodB FER_sim BER_sim Nblkerrs Nbit_err N_blocks])