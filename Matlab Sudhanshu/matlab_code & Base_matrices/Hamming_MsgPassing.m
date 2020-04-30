format short g
EbNodB = 2;
MaxItrs = 8;
R = 4/7; %(7,4) Hamming (4/7 bits/symbol)
EbNo = 10^(EbNodB/10);
sigma = sqrt(1/(2*R*EbNo));
BER_th = 0.5*erfc(sqrt(EbNo));
k = 4; %number of message bits
n = 7; %number of codeword bits

% Parity Matrix - H
H = [ 1 1 1 0 1 0 0;...
    0 1 1 1 0 1 0;...
    1 1 0 1 0 0 1;...
    1 0 1 0 1 1 1];
[col,row]=size(H);
StorageMatrix = H;
Update_StorageMatrix =zeros(col,row);
Nbiterrs = 0; Nblkerrs = 0; Nblocks=100;
for i = 1: Nblocks
%     msg = randi([0 1],1,n); %generate random k-bit message
%     
%     %%Encoding
%     cword = [msg mod(msg(1)+msg(2)+msg(3) ,2) ...
%         mod(msg(2)+msg(3)+msg(4) ,2) ...
%         mod(msg(1)+msg(2)+msg(4) ,2)]; %(7,4) Hamming
%     cword = msg;
	%msg = randi([0 1],1,k); %generate random k-bit message
    msg = zeros(1,k); %all-zero message
	%Encoding 
	cword = zeros(1,n); %all-zero codeword
    BPSK_mod = 1 - 2 * cword; %BPSK bit to symbol conversion
    Channel_Output = BPSK_mod + sigma * randn(1,n); %AWGN channel I
%     Channel_Output = [0.2 -0.3 1.2 -0.5 0.8 0.6 -1.1];
    belief = Channel_Output;
    itr =0;
   while itr < MaxItrs 
    %%Decoding
    for i = 1: row
        Update_StorageMatrix(:,i) = Channel_Output(i)*StorageMatrix(:,i);
    end
    %row operations
    % for now I am only using 1 iteration this can be increase
    for col_val = 1:col
        t = (abs(Update_StorageMatrix(col_val,:)));
        min1 = min(t(t>0));
        pos = find(t==min1);
        if pos==1
            r = abs(Update_StorageMatrix(col_val,pos+1:end));
        else
            r = abs(Update_StorageMatrix(col_val,[1:pos-1 pos+1:end]));
        end
        min2 = min(r(r>0));
        S= sign(Update_StorageMatrix(col_val,:));
        overall_parity = prod(S(S~=0));
        Update_StorageMatrix(col_val,:)=min1;
        Update_StorageMatrix(col_val,pos)=min2;
        Update_StorageMatrix(col_val,:)=overall_parity*S.*Update_StorageMatrix(col_val,:);
    end
    for belief_entry = 1:row
        update_belief(belief_entry) = belief(belief_entry) + sum(Update_StorageMatrix(:,belief_entry));
        for col_val1 = 1:col
            if Update_StorageMatrix(col_val1,belief_entry)~=0
                Update_StorageMatrix(col_val1,belief_entry) = update_belief(belief_entry) - Update_StorageMatrix(col_val1,belief_entry);
            end
        end
    end
    msg_cap = update_belief(1:k) < 0; %decision
    itr = itr+1;
   end
    Nerrs = sum(msg ~= msg_cap);
    if Nerrs > 0
        Nbiterrs = Nbiterrs + Nerrs;
        Nblkerrs = Nblkerrs + 1;
    end
end

BER_sim = Nbiterrs/k/Nblocks;
FER_sim = Nblkerrs/Nblocks;
disp(['    EbNodB: '  num2str(EbNodB)...
      ' BER Sim: ', num2str(BER_sim) ]);
% disp([EbNodB BER_sim FER_sim]);