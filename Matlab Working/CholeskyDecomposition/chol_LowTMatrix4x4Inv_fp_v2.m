%% Function to calculate the fixed point inverse of a lower triangular 4x4 matrix 
% inv(A) = adj(A)/det(A);
% Adjoint and determinant is calculated. This function is specifically calculated for 4x4 lower
% triagular matrix
%% (C) MMRFIC Technology Pvt. Ltd,. Bangalore INDIA

function [matrixInverse_fp] = chol_LowTMatrix4x4Inv_fp_v2(A,nt,ni,signmode,roundmode)
% storing the repeated constants to save multipliers

Val_1 = quantize1(A(3,3)*A(4,4),nt,5*ni,signmode,roundmode);
Val_2 = quantize1(A(3,2)*A(4,4),nt,5*ni,signmode,roundmode);
Val_3 = quantize1(A(3,2)*A(4,3),nt,5*ni,signmode,roundmode);

determinant = A(1,1)*A(2,2)*Val_1; 
determinant_fp = quantize1(A(1,1)*A(2,2)*Val_1,nt,5*ni,signmode,roundmode);

adj(1,1) = A(2,2)*Val_1;
adj_fp(1,1) = quantize1(A(2,2)*Val_1,nt,5*ni,signmode,roundmode);

adj(2,1) = -A(2,1)*Val_1;
adj_fp(2,1) = quantize1(-A(2,1)*Val_1,nt,5*ni,signmode,roundmode);

adj(2,2) = A(1,1)*Val_1;
adj_fp(2,2) = quantize1(A(1,1)*Val_1,nt,5*ni,signmode,roundmode);

adj(3,1) = A(2,1)*Val_2- A(2,2)*A(3,1)*A(4,4) ;
adj_fp(3,1) = quantize1(quantize1(A(2,1)*Val_2,nt,5*ni,signmode,roundmode) - quantize1(A(2,2)*A(3,1)*A(4,4),nt,5*ni,signmode,roundmode),nt,5*ni,signmode,roundmode);

adj(3,2) = -A(1,1)* Val_2+ A(1,2)*A(3,1)*A(4,4) + A(1,1)*A(3,4)*A(4,2);
adj_fp(3,2) = quantize1(quantize1(-A(1,1)* Val_2,nt,5*ni,signmode,roundmode)+ quantize1(A(1,2)*A(3,1)*A(4,4),nt,5*ni,signmode,roundmode) + quantize1(A(1,1)*A(3,4)*A(4,2),nt,5*ni,signmode,roundmode),nt,5*ni,signmode,roundmode);

adj(3,3) = A(1,1)*A(2,2)*A(4,4);
adj_fp(3,3) = quantize1(A(1,1)*A(2,2)*A(4,4),nt,5*ni,signmode,roundmode);

adj(4,1) = -A(2,1)*Val_3 - A(2,2)*A(3,3)*A(4,1)  + A(2,2)*A(3,1)*A(4,3) + A(2,1)*A(3,3)*A(4,2);
adj_fp(4,1) = quantize1(quantize1(-A(2,1)*Val_3,nt,5*ni,signmode,roundmode) - quantize1(A(2,2)*A(3,3)*A(4,1),nt,5*ni,signmode,roundmode)  + quantize1(A(2,2)*A(3,1)*A(4,3),nt,5*ni,signmode,roundmode) + quantize1(A(2,1)*A(3,3)*A(4,2),nt,5*ni,signmode,roundmode),nt,5*ni,signmode,roundmode);

adj(4,2) = A(1,1)*Val_3 - A(1,1)*A(3,3)*A(4,2);
adj_fp(4,2) = quantize1(quantize1(A(1,1)*Val_3,nt,5*ni,signmode,roundmode) - quantize1(A(1,1)*A(3,3)*A(4,2),nt,5*ni,signmode,roundmode),nt,5*ni,signmode,roundmode);

adj(4,3) = -A(1,1)*A(2,2)*A(4,3);
adj_fp(4,3) = quantize1(-A(1,1)*A(2,2)*A(4,3),nt,5*ni,signmode,roundmode);

adj(4,4) = A(1,1)*A(2,2)*A(3,3);
adj_fp(4,4) = quantize1(A(1,1)*A(2,2)*A(3,3),nt,5*ni,signmode,roundmode);

matrixInverse = adj/determinant;
matrixInverse_fp = quantize1(adj_fp/determinant_fp,nt,5*ni,signmode,roundmode);
end 