clear
N = 16 ;% number of bits or symbols

Eb_N0_dB = [0:1:10]; % multiple Eb/N0 values
Ec_N0_dB = Eb_N0_dB - 10*log10(2);

ref = [0 0 ; 0 1; 1 0  ; 1 1 ];

ipLUT = [1 1 1 0 1 1 0 1 0 0 1 1 1 0 0 0];

for yy = 1:length(Eb_N0_dB)

   % Transmitter
   ip = rand(1,N)>0.5; % generating 0,1 with equal probability

   % convolutional coding, rate - 1/2, generator polynomial - [7,5] octal
   cip1 = mod(conv(ip,[1 1 1 ]),2);
   cip2 = mod(conv(ip,[1 0 1 ]),2);
   cip = [cip1;cip2];
   cip = cip(:).';

   s = 2*cip-1; % BPSK modulation 0 -> -1; 1 -> 0 

   n = 1/sqrt(2)*[randn(size(cip)) + j*randn(size(cip))]; % white gaussian noise, 0dB variance 

   % Noise addition
   y = s + 10^(-Ec_N0_dB(yy)/20)*n; % additive white gaussian noise

   % receiver - hard decision decoding
   cipHat = real(y)>0;

   % Viterbi decoding
   pathMetric  = zeros(4,1);  % path metric
   survivorPath_v  = zeros(4,length(y)/2); % survivor path
   
   for ii = 1:length(y)/2
      r = cipHat(2*ii-1:2*ii); % taking 2 coded bits
      
      % computing the Hamming distance between ip coded sequence with [00;01;10;11]
      rv = kron(ones(4,1),r);
      hammingDist = sum(xor(rv,ref),2);
 

      if (ii == 1) || (ii == 2) 

         % branch metric and path metric for state 0
         bm1 = pathMetric(1,1) + hammingDist(1);
         pathMetric_n(1,1)  = bm1; 
         survivorPath(1,1)  = 1; 
 
         % branch metric and path metric for state 1
         bm1 = pathMetric(3,1) + hammingDist(3);
         pathMetric_n(2,1) = bm1;
         survivorPath(2,1)  = 3; 
         

         % branch metric and path metric for state 2
         bm1 = pathMetric(1,1) + hammingDist(4);
         pathMetric_n(3,1) = bm1;
         survivorPath(3,1)  = 1; 

         % branch metric and path metric for state 3
         bm1 = pathMetric(3,1) + hammingDist(2);
         pathMetric_n(4,1) = bm1;
         survivorPath(4,1)  = 3; 

      else
         % branch metric and path metric for state 0
         bm1 = pathMetric(1,1) + hammingDist(1);
         bm2 = pathMetric(2,1) + hammingDist(4);
         [pathMetric_n(1,1) idx] = min([bm1,bm2]);
         survivorPath(1,1)  = idx; 
 
         % branch metric and path metric for state 1
         bm1 = pathMetric(3,1) + hammingDist(3);
         bm2 = pathMetric(4,1) + hammingDist(2);
         [pathMetric_n(2,1) idx] = min([bm1,bm2]);
         survivorPath(2,1)  = idx+2; 

         % branch metric and path metric for state 2
         bm1 = pathMetric(1,1) + hammingDist(4);
         bm2 = pathMetric(2,1) + hammingDist(1);
         [pathMetric_n(3,1) idx] = min([bm1,bm2]);
         survivorPath(3,1)  = idx; 

         % branch metric and path metric for state 3
         bm1 = pathMetric(3,1) + hammingDist(2);
         bm2 = pathMetric(4,1) + hammingDist(3);
         [pathMetric_n(4,1) idx] = min([bm1,bm2]);
         survivorPath(4,1)  = idx+2; 

      end
   
   pathMetric = pathMetric_n; 
   survivorPath_v(:,ii) = survivorPath;

   end

   % trace back unit
   currState = 1;
   ipHat_v = zeros(1,length(y)/2);
   for jj = length(y)/2:-1:1
      prevState = survivorPath_v(currState,jj)
      ipHat_v(jj) = ipLUT(currState,prevState);
      currState = prevState;
   end

   % counting the errors
   nErrViterbi(yy) = size(find([ip- ipHat_v(1:N)]),2);

end

simBer_Viterbi = nErrViterbi/N; % simulated ber - Viterbi decoding BER

theoryBer = 0.5*erfc(sqrt(10.^(Eb_N0_dB/10))); % theoretical ber uncoded AWGN

close all
figure
semilogy(Eb_N0_dB,theoryBer,'bd-','LineWidth',2);
hold on
semilogy(Eb_N0_dB,simBer_Viterbi,'mp-','LineWidth',2);
axis([0 10 10^-5 0.5])
grid on
legend('theory - uncoded', 'simulation - Viterbi (rate-1/2, [7,5]_8)');
xlabel('Eb/No, dB');
ylabel('Bit Error Rate');
title('BER for BCC with Viterbi decoding for BPSK in AWGN');
