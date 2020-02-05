%% Function to calculate the inverse of a lower triangular 4x4 matrix 

function [matrixInverse] = chol_LowTMatrix4x4Inv(A)

determinant = A(1,1)*A(2,2)*A(3,3)*A(4,4); 
if (determinant==0||1)
    ni = 1;
else
    ni = ceil(log2(max(max(abs(determinant)))));    %Number of integer bits
end
nt = ni +1;
determinant_fp = quantize1(determinant,nt,ni,'signed','round');

adj(1,1) = A(2,2)*A(3,3)*A(4,4);
if (adj(1,1)==0||1)
    ni = 1;
else
    ni = ceil(log2(max(max(abs(adj(1,1))))));    %Number of integer bits
end
nt = ni +1;
adj_fp(1,1) = quantize1(adj(1,1),nt,ni,'signed','round');

adj(2,1) = -A(2,1)*A(3,3)*A(4,4);
if (adj(2,1)==0||1)
    ni = 1;
else
    ni = ceil(log2(max(max(abs(adj(2,1))))));    %Number of integer bits
end
nt = ni +1;
adj_fp(2,1) = quantize1(adj(2,1),nt,ni,'signed','round');
adj(2,2) = A(1,1)*A(3,3)*A(4,4);
if (adj(2,2)==0||1)
    ni = 1;
else
    ni = ceil(log2(max(max(abs(adj(2,2))))));    %Number of integer bits
end
nt = ni +1;
adj_fp(2,2) = quantize1(adj(2,2),nt,ni,'signed','round');

adj(3,1) = A(2,1)*A(3,2)*A(4,4)- A(2,2)*A(3,1)*A(4,4) ;
if (adj(3,1)==0||1)
    ni = 1;
else
    ni = ceil(log2(max(max(abs(adj(3,1))))));    %Number of integer bits
end
nt = ni +1;
adj_fp(3,1) = quantize1(adj(3,1),nt,ni,'signed','round');
adj(3,2) = -A(1,1)* A(3,2)*A(4,4)+ A(1,2)*A(3,1)*A(4,4) + A(1,1)*A(3,4)*A(4,2);
if (adj(3,2)==0||1)
    ni = 1;
else
    ni = ceil(log2(max(max(abs(adj(3,2))))));    %Number of integer bits
end
nt = ni +1;
adj_fp(3,2) = quantize1(adj(3,2),nt,ni,'signed','round');
adj(3,3) = A(1,1)*A(2,2)*A(4,4);
if (adj(3,3)==0||1)
    ni = 1;
else
    ni = ceil(log2(max(max(abs(adj(3,3))))));    %Number of integer bits
end
nt = ni +1;
adj_fp(3,3) = quantize1(adj(3,3),nt,ni,'signed','round');

adj(4,1) = -A(2,1)*A(3,2)*A(4,3) - A(2,2)*A(3,3)*A(4,1)  + A(2,2)*A(3,1)*A(4,3) + A(2,1)*A(3,3)*A(4,2);
if (adj(4,1)==0||1)
    ni = 1;
else
    ni = ceil(log2(max(max(abs(adj(4,1))))));    %Number of integer bits
end
nt = ni +1;
adj_fp(4,1) = quantize1(adj(4,1),nt,ni,'signed','round');
adj(4,2) = A(1,1)*A(3,2)*A(4,3)- A(1,1)*A(3,3)*A(4,2);
if (adj(4,2)==0||1)
    ni = 1;
else
    ni = ceil(log2(max(max(abs(adj(4,2))))));    %Number of integer bits
end
nt = ni +1;
adj_fp(4,2) = quantize1(adj(4,2),nt,ni,'signed','round');
adj(4,3) = -A(1,1)*A(2,2)*A(4,3);
if (adj(4,3)==0||1)
    ni = 1;
else
    ni = ceil(log2(max(max(abs(adj(4,3))))));    %Number of integer bits
end
nt = ni +1;
adj_fp(4,3) = quantize1(adj(4,3),nt,ni,'signed','round');
adj(4,4) = A(1,1)*A(2,2)*A(3,3);
if (adj(4,4)==0||1)
    ni = 1;
else
    ni = ceil(log2(max(max(abs(adj(4,4))))));    %Number of integer bits
end
nt = ni +1;
adj_fp(4,4) = quantize1(adj(4,4),nt,ni,'signed','round');

matrixInverse = adj_fp/determinant_fp;
end 