function [goldCode] = generateGoldCode (initState1,initState2,codeLength,numBits)
% The polynomial is taken from IRNSS document
polynomial1 = [1 0 1 1 0 0 1 0 1 1 1]; %X^10 +X^9 + X^8 + X^6 +X^3 + X^2 + 1
polynomial2 = [1 0 0 1 0 0 0 0 0 0 1]; %x^10 + x^3 + 1

initialState_G1 = dec2bits(initState1,numBits);            %Initial state for polynomial 1
initialState_G2 = dec2bits(initState2,numBits);            %Initial state for polynomial 2
      
prn1 = gf2polyGenPrn(initialState_G1,polynomial1,codeLength);        % PN sequence1
prn2 = gf2polyGenPrn(initialState_G2,polynomial2,codeLength);        % PN sequence2 

goldCode = xor(prn1,prn2);                          % ex-or to get the gold code
end 