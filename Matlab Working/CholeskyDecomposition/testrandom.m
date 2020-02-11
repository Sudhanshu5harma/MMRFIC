A= rand(4,4);
A= A*A';
[L,D,L_trans]=chol_float(A);
[L1,D1,L1_trans]=chol4X4(A);
