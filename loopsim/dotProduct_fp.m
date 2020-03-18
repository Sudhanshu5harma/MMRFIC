%% Function for inner product of vectors or columns of matrices, i.e., A^H B is computed
%% function out = dotProduct_fp(vec1,vec2, Nt, Ni) - Fixed point version
function [out, newNi] = dotProduct_fp(vec1,vec2, Nt, Ni)

[m1,n1] = size(vec1);
[m2,n2] = size(vec2);
J = sqrt(-1);

cmplxFlag = ~isreal(vec1) | ~isreal(vec2);

if (m1 ~= m2)
   disp('*** ERROR: Array dimensions do not match');
   out = zeros(n1,n2);
   return;
end

out = zeros(n1,n2);
addlIntBits = ceil(log2(m1));

for i1 = 1:n1
  for i2 = 1:n2
     tempSum = 0;
     if (cmplxFlag > 0)
       for i3 = 1:m1
           tempSum = tempSum + quantize1(real(vec1(i3,i1)) * real(vec2(i3,i2))+imag(vec1(i3,i1)) * imag(vec2(i3,i2)), 2*Nt+1, 2*Ni, 'signed','trunc');
           tempSum = tempSum + J*quantize1(real(vec1(i3,i1)) * imag(vec2(i3,i2))-imag(vec1(i3,i1)) * real(vec2(i3,i2)),2*Nt+1, 2*Ni, 'signed','trunc');
       end
     else
       for i3 = 1:m1
           tempSum = tempSum +   quantize1(vec1(i3,i1) * vec2(i3,i2), 2*Nt, 2*Ni-1, 'signed','trunc');
       end
     end
     out(i1,i2) = quantize1(tempSum, 2*Nt, 2*Ni+addlIntBits-1, 'signed','round');
  end
end
  
newNi = Ni+addlIntBits;

% End of function




