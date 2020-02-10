%% Function to calculate the inverse of a lower triangular 4x4 matrix 

function [matrixInverse] = chol_LowTMatrix4x4Inv_fp_v2(A,nt,ni,signmode,roundmode)
Val_1 = A(3,3)*A(4,4);
Val_2 = A(3,2)*A(4,4);
Val_3 = A(3,2)*A(4,3);
determinant = A(1,1)*A(2,2)*Val_1; 
determinant_fp = quantize1(determinant,nt,3*ni,signmode,roundmode);
adj(1,1) = A(2,2)*Val_1;
adj_fp(1,1) = quantize1(adj(1,1),nt,3*ni,signmode,roundmode);
adj(2,1) = -A(2,1)*Val_1;
adj_fp(2,1) = quantize1(adj(2,1),nt,3*ni,signmode,roundmode);
adj(2,2) = A(1,1)*Val_1;
adj_fp(2,2) = quantize1(adj(2,2),nt,3*ni,signmode,roundmode);
adj(3,1) = A(2,1)*Val_2- A(2,2)*A(3,1)*A(4,4) ;
adj_fp(3,1) = quantize1(adj(3,1),nt,3*ni,signmode,roundmode);
adj(3,2) = -A(1,1)* Val_2+ A(1,2)*A(3,1)*A(4,4) + A(1,1)*A(3,4)*A(4,2);
adj_fp(3,2) = quantize1(adj(3,2),nt,3*ni,signmode,roundmode);
adj(3,3) = A(1,1)*A(2,2)*A(4,4);
adj_fp(3,3) = quantize1(adj(3,3),nt,3*ni,signmode,roundmode);
adj(4,1) = -A(2,1)*Val_3 - A(2,2)*A(3,3)*A(4,1)  + A(2,2)*A(3,1)*A(4,3) + A(2,1)*A(3,3)*A(4,2);
adj_fp(4,1) = quantize1(adj(4,1),nt,3*ni,signmode,roundmode);
adj(4,2) = A(1,1)*Val_3 - A(1,1)*A(3,3)*A(4,2);
adj_fp(4,2) = quantize1(adj(4,2),nt,3*ni,signmode,roundmode);
adj(4,3) = -A(1,1)*A(2,2)*A(4,3);
adj_fp(4,3) = quantize1(adj(4,3),nt,3*ni,signmode,roundmode);
adj(4,4) = A(1,1)*A(2,2)*A(3,3);
adj_fp(4,4) = quantize1(adj(4,4),nt,3*ni,signmode,roundmode);


matrixInverse = adj_fp/determinant_fp;
end 