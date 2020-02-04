function [L,D,L_trans] = chol_float(A)
N = length(A);

for i = 1:N
  D(i,i) = A(i,i);
  if (i~= 1)
    for k = 1:i-1
      D(i,i) = D(i,i)-(L(i,k)* L(i,k)' * D(k,k));
    end 
  end 
  for j = i+1:N
    L(j,i) = A(j,i);
    if (i~= 1)
      for k1 = 1:i-1
        L(j,i) = L(j,i) - (L(j,k1)*L(i,k1)*D(k1,k1));
      end 
    end 
    L(j,i) = L(j,i)/D(i,i);
  end 
  L(i,i) = 1;
  L_trans = transpose(A);
end 