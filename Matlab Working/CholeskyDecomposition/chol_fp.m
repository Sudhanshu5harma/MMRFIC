
function[L_fp, D_fp, L_trans] = chol_fp(A,nt,ni,signmode,roundmode)
  N = length(A);
  A_fp = quantize1(A,nt,ni,signmode,roundmode);
  for i = 1:N
  D(i,i) = A(i,i);
  D_fp(i,i) = A_fp(i,i);
  if (i~= 1)
    for k = 1:i-1
%%      temp(j,i) = D(i,i)-(L(i,k)* L(i,k)' * D(k,k));
      D(i,i) = D(i,i)-(L(i,k)* L(i,k)' * D(k,k));
%%      D_fp(i,i) = quantize1(D_fp(i,i)-quantize1((L_fp(i,k)* L_fp(i,k)' * D_fp(k,k)),nt,(3*ni)+1,signmode,roundmode),nt,(3*ni)+1,signmode,roundmode);
      D_fp(i,i) = quantize1(D_fp(i,i)-quantize1((L_fp(i,k)* L_fp(i,k)' * D_fp(k,k)),nt,(ni)+1,signmode,roundmode),nt,(3*ni)+1,signmode,roundmode);
    end 
  end 
%  D_fp(i,i) = quantize1(D_fp(i,i),nt,(2*ni)+1,signmode,roundmode);
  for j = i+1:N
    L(j,i) = A(j,i);
    L_fp(j,i) = A_fp(j,i);
    if (i~= 1)
      for k1 = 1:i-1
%        temp(j,i) = (L(j,k1)*L(i,k1)*D(k1,k1));
        L(j,i) = L(j,i) - (L(j,k1)*L(i,k1)*D(k1,k1));
%%        L_fp(j,i) = quantize1(L_fp(j,i) - quantize1((L_fp(j,k1)*L_fp(i,k1)*D_fp(k1,k1)),nt,(3*ni)+1,signmode,roundmode),nt,(3*ni)+1,signmode,roundmode);
        L_fp(j,i) = quantize1(L_fp(j,i) - quantize1((L_fp(j,k1)*L_fp(i,k1)*D_fp(k1,k1)),nt,(ni)+1,signmode,roundmode),nt,(3*ni)+1,signmode,roundmode);
      end 
    end 
%    L_fp(j,i) = quantize1(L_fp(j,i),nt,13,signmode,roundmode);
    L(j,i) = L(j,i)/D(i,i);
%%    L_fp(j,i) = quantize1(L_fp(j,i)/D_fp(i,i),nt,(2*ni)+1,signmode,roundmode);
    L_fp(j,i) = quantize1(L_fp(j,i)/D_fp(i,i),nt,(ni)+1,signmode,roundmode);
  end 
  L(i,i) = 1;
  L_fp(i,i) = 1;
  end 
%%  L_trans_fp = L_fp';
  L_trans = transpose(L_fp);
end