%% Function to generate PRN sequence from the given GF(2)
%% polynomial
%% Syntax:
%% function [outBits] = gf2polyGenPrn(state,poly,numBits)
%%
%% state - Initial shift register value
%% poly  - Polynomial, poly(1) is the coef for highest degree
%% numBits - Number of bit to generate

function [outBits,outState] = gf2polyGenPrn(state,gf2poly,numBits)

order = length(state);
outBits = zeros(1,numBits);

if (order ~= length(gf2poly)-1)
  error('Polynomial and Initial State should be of the same order');
end

index = find(gf2poly>0);
numPaths = length(index);

for ii = 1:numBits
   outBits(ii) = state(1);
   fbBit = fix(rem(sum(bitand(state,gf2poly(1:end-1))),2));
   state = [state(2:end) fbBit];

%  fbBit = state(1);
%  state([index]) = bitxor(state([index]),fbBit*ones(1,numPaths));
%  outBits(ii) = fbBit;
%  state = [state(2:end) fbBit];
%  outState(ii) = packBits(state,order);
end

outState = state;
