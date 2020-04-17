%% Function to calculate the inverse of a lower triangular 4x4 matrix 

function [matrixInverse_fp] = chol_LowTMatrix4x4Inv_fp(A,nt,ni,signmode,roundmode)
determinant = A(1,1)*A(2,2)*A(3,3)*A(4,4); 
determinant_fp = quantize1(quantize1(quantize1(A(1,1)*A(2,2),nt,1,'signed','round')*A(3,3),nt,1,'signed','round')*A(4,4),nt,1,'signed','round'); 

adj(1,1) = A(2,2)*A(3,3)*A(4,4);
adj_fp(1,1) = quantize1(quantize1(A(2,2)*A(3,3),nt,ni,'signed','round')*A(4,4),nt,ni,'signed','round');

adj(2,1) = -A(2,1)*A(3,3)*A(4,4);
adj_fp(2,1) = quantize1(quantize1(-A(2,1)*A(3,3),nt,ni,'signed','round')*A(4,4),nt,ni,'signed','round');
adj(2,2) = A(1,1)*A(3,3)*A(4,4);
adj_fp(2,2) = quantize1(quantize1(A(1,1)*A(3,3),nt,ni,'signed','round')*A(4,4),nt,ni,'signed','round');

adj(3,1) = A(2,1)*A(3,2)*A(4,4)- A(2,2)*A(3,1)*A(4,4) ;
adj_fp(3,1) = A(2,1)*A(3,2)*A(4,4)- A(2,2)*A(3,1)*A(4,4) ;
adj(3,2) = -A(1,1)* A(3,2)*A(4,4)+ A(1,2)*A(3,1)*A(4,4) + A(1,1)*A(3,4)*A(4,2);
adj_fp(3,2) = -A(1,1)* A(3,2)*A(4,4)+ A(1,2)*A(3,1)*A(4,4) + A(1,1)*A(3,4)*A(4,2);
adj(3,3) = A(1,1)*A(2,2)*A(4,4);
adj_fp(3,3) = quantize1(quantize1(A(1,1)*A(2,2),nt,ni,'signed','round')*A(4,4),nt,ni,'signed','round');

adj(4,1) = -A(2,1)*A(3,2)*A(4,3) - A(2,2)*A(3,3)*A(4,1)  + A(2,2)*A(3,1)*A(4,3) + A(2,1)*A(3,3)*A(4,2);
adj_fp(4,1) = -A(2,1)*A(3,2)*A(4,3) - A(2,2)*A(3,3)*A(4,1)  + A(2,2)*A(3,1)*A(4,3) + A(2,1)*A(3,3)*A(4,2);
adj(4,2) = A(1,1)*A(3,2)*A(4,3)- A(1,1)*A(3,3)*A(4,2);
adj_fp(4,2) = A(1,1)*A(3,2)*A(4,3)- A(1,1)*A(3,3)*A(4,2);
adj(4,3) = -A(1,1)*A(2,2)*A(4,3);
adj_fp(4,3) = quantize1(quantize1(-A(1,1)*A(2,2),nt,ni,'signed','round')*A(4,3),nt,ni,'signed','round');
adj(4,4) = A(1,1)*A(2,2)*A(3,3);
adj_fp(4,4) = quantize1(quantize1(A(1,1)*A(2,2),nt,ni,'signed','round')*A(3,3),nt,ni,'signed','round');


matrixInverse = adj/determinant;
x = ceil(log2(max(max(abs(matrixInverse)))));
matrixInverse_fp = (adj_fp/determinant_fp)/(2^x);
matrixInverse_fp = quantize1(matrixInverse_fp,nt,0,signmode,roundmode);
matrixInverse_fp = matrixInverse_fp*2^x;

end 