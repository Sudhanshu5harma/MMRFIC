K = 3;
Randombits = [1 1 1 0 1 1 0 1 0 0 1 1 1 0 0 0];
trellis = poly2trellis(K,[7 5]);
y = convenc(Randombits,trellis)
Encoded = [1 1 0 1 1 0 0 1 0 0 0 1 0 1 0 0 1 0 1 1 1 1 0 1 1 0 0 1 1 1 0 0];
nextStates=trellis.nextStates;
ref = [0 0 ; 0 1; 1 0  ; 1 1 ];


outputs=trellis.outputs;
for ii = 1:length(y)/2
      r = y(2*ii-1:2*ii); 
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
   survivorPath_v(:,ii) = survivorPath

   end

   % trace back unit
   currState = 1;
   ipHat_v = zeros(1,length(y)/2);
   for jj = length(y)/2:-1:1
      prevState = survivorPath_v(currState,jj)
      ipHat_v(jj) = ipLUT(currState,prevState)
      currState = prevState;
   end
