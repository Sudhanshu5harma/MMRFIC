Rate = 4/7; %7/4 Hamming code(4/7 bits/symbol)

k = 4 ; %message bits
n = 7;  %codeword bits
PlotMatrix=zeros(10,3);  % to store data
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

Nbit_err1 =0; Nblkerrs1=0; Nbit_err2 =0; Nblkerrs2=0 ;N_blocks =10000;
EbNodB = 1:1:10;

for dBval = 1:length(EbNodB)
    
    EbNo =  10^(EbNodB(dBval)/10);
    sigma = sqrt(1/(2*Rate*EbNo));
    BER_th = 0.5*erfc(sqrt(EbNo));
    disp(['Calculating for dB ',num2str(EbNodB(dBval))])
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
        
        NerrsHard =sum(msg~=msg_cap1);
        if NerrsHard>0
            Nbit_err1 = Nbit_err1 +NerrsHard;
            Nblkersr1 =Nblkerrs1+1;
        end
        NerrsSoft =sum(msg~=msg_cap2);
        if NerrsSoft>0
            Nbit_err2 = Nbit_err2 +NerrsSoft;
            Nblkersr2 =Nblkerrs2+1;
        end
        
    end
    
    BER_simHard = Nbit_err1/k/N_blocks;
    FER_simHard = Nblkerrs1/N_blocks;
    BER_simSoft = Nbit_err2/k/N_blocks;
    FER_simSoft = Nblkerrs2/N_blocks;
    PlotMatrix(dBval,1)=BER_th;
    PlotMatrix(dBval,2)=BER_simHard;
    PlotMatrix(dBval,3)=BER_simSoft;

end
semilogy(EbNodB,PlotMatrix(:,1:end),'-o');
axis([0.5 11 1e-12 1])
xlabel('E_b/N_0 (dB)','FontName','Times','FontSize',16)
ylabel('FER','FontName','Times','FontSize',16)
legend('BER_th', 'HardDecoding','Softdecoding');
% disp([EbNodB FER_sim BER_sim Nblkerrs Nbit_err N_blocks])