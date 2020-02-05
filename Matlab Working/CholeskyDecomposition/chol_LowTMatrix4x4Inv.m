%% Function to calculate the inverse of a lower triangular 4x4 matrix 

function [matrixInverse] = chol_LowTMatrix4x4Inv(A);
determinant = A(1,1)*A(2,2)*A(3,3)*A(4,4); 

adj(1,1) = A(2,2)*A(3,3)*A(4,4);

adj(2,1) = -A(2,1)*A(3,3)*A(4,4);
adj(2,2) = A(1,1)*A(3,3)*A(4,4);

adj(3,1) = A(2,1)*A(3,2)*A(4,4)- A(2,2)*A(3,1)*A(4,4) ;
adj(3,2) = -A(1,1)* A(3,2)*A(4,4)+ A(1,2)*A(3,1)*A(4,4) + A(1,1)*A(3,4)*A(4,2);
adj(3,3) = A(1,1)*A(2,2)*A(4,4);

adj(4,1) = -A(2,1)*A(3,2)*A(4,3) - A(2,2)*A(3,3)*A(4,1)  + A(2,2)*A(3,1)*A(4,3) + A(2,1)*A(3,3)*A(4,2);
adj(4,2) = A(1,1)*A(3,2)*A(4,3)- A(1,1)*A(3,3)*A(4,2);
adj(4,3) = -A(1,1)*A(2,2)*A(4,3);
adj(4,4) = A(1,1)*A(2,2)*A(3,3);


matrixInverse = adj/determinant;
end 