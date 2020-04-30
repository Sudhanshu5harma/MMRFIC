clear
N = 2*10^6 ;% number of bits 

Eb_N0_dB =  [0:1:10]; % multiple Eb/N0 values
Ec_N0_dB = Eb_N0_dB - 10*log10(7/4);

h = [ 1   0   1 ;    1   1   1;    1   1   0;    0   1   1];
ht = [h ;eye(3)];
g = [eye(4) h];
synRef = [ 5 7 6 3  ];
bitIdx = [ 7 7 4 7 1 3 2].';

c_vec  = zeros(2^4,7);
for (kk = 0:2^4-1)
	m_vec = base2dec(dec2bin(kk,4).',2).';
	c_vec(kk+1,:) = mod(m_vec*g,2);
end

for yy = 1:length(Eb_N0_dB)

   % Transmitter
   ip = rand(1,N)>0.5; % generating 0,1 with equal probability
   
   % Hamming coding (7,4)
   ipM = reshape(ip,4,N/4).';
   ipC = mod(ipM*g,2);
   cip = reshape(ipC.',1,N/4*7);
   
   % Modulation
   s = 2*cip-1; % BPSK modulation 0 -> -1; 1 -> 0 

   % Channel - AWGN
   n = 1/sqrt(2)*[randn(size(cip)) + j*randn(size(cip))]; % white gaussian noise, 0dB variance 

   % Noise addition
   y = s + 10^(-Ec_N0_dB(yy)/20)*n; % additive white gaussian noise

   % Receiver 
   cipHard = real(y)>0; % hard decision

   % Hard decision Hamming decoder
   cipHardM    = reshape(cipHard,7,N/4).';
   syndrome    = mod(cipHardM*ht,2); % find the syndrome
   syndromeDec = sum(syndrome.*kron(ones(N/4,1),[4 2 1]),2); % converting the three bit syndrom to decimal
   syndromeDec(find(syndromeDec==0)) = 1; % to prevent simulation crash, assigning no error bits to parity
   bitCorrIdx  = bitIdx(syndromeDec); % find the bits to correct
   bitCorrIdx  = bitCorrIdx + [0:N/4-1].'*7; % finding the index in the array
   cipHard(bitCorrIdx) = ~cipHard(bitCorrIdx); % correcting bits
   idx = kron(ones(1,N/4),[1:4]) + kron([0:N/4-1]*7,ones(1,4)); % index of data bits
   ipHat_hard = cipHard(idx); % selecting data bits

   % Soft decision Hamming decoder
   cipSoftM    = reshape(real(y),7,N/4).';
   [val idx]   = max(cipSoftM*(2*c_vec.'-1),[],2);
   ipHat_soft  = base2dec(dec2bin(idx-1,4).'(:),2).';	
    
   % counting the errors
   nErr_hard(yy) = size(find([ip- ipHat_hard]),2);
   nErr_soft(yy) = size(find([ip- ipHat_soft]),2);

end


theoryBer = 0.5*erfc(sqrt(10.^(Eb_N0_dB/10))); % theoretical ber uncoded AWGN
simBer_hard    = nErr_hard/N;
simBer_soft    = nErr_soft/N;

close all
figure
semilogy(Eb_N0_dB,theoryBer,'bd-','LineWidth',2);
hold on
semilogy(Eb_N0_dB,simBer_hard,'ms-','LineWidth',2);
semilogy(Eb_N0_dB,simBer_soft,'rp-','LineWidth',2);
axis([0 10 10^-5 0.5])
grid on
legend('theory - uncoded', 'simulation - Hamming 7,4 (hard)','simulation - Hamming 7,4 (soft)');
xlabel('Eb/No, dB');
ylabel('Bit Error Rate');
title('BER for BPSK in AWGN with Hamming (7,4) code');

