%% Function to solve system of 4 linear equations 
% Ax = b
% (A*A')x = A'b 
% (LDL')x = A'b
% x = inv(L'DL)*(A'b)
%% (C) MMRFIC Technology Pvt. Ltd,. Bangalore INDIA

function [X] = cheloskeyOutput(A,b)

% n = length(A);
% A = (rand(n,n)*100);
% b = [5;4;8;9];


signmode = 'signed';
roundmode = 'round';


A1 = transpose(A)*A;                                %% To convert the matrix into hermitian 
ni_nor =floor(log2(max(max(abs(A1)))));             % Number nearest power of 2, to normalize the matrix    
A1 = A1/(2^ni_nor);
ni = ceil(log2(max(max(abs(A1)))));                 %Number of integer bits
nt = 22;                                            %Total number of bits;
[L,D,L_Transpose] = chol4X4_fp(A1,nt,ni,signmode,roundmode);
% [L,D,L_Transpose] = chol4X4(A1);

ni =ceil(log2(max(max(abs(L)))));
if (ni==0)
    ni =1;
end
[L_inv] = chol_LowTMatrix4x4Inv_fp_v2(L,nt,ni,signmode,roundmode);
% [L_inv] = chol_LowTMatrix4x4Inv(L);%,nt,ni,signmode,roundmode);

ni =ceil(log2(max(max(abs(D)))));
if (ni==0)
    ni =1;
end
[D_inv] = chol_LowTMatrix4x4Inv_fp_v2(D,nt,ni,signmode,roundmode);
% [D_inv] = chol_LowTMatrix4x4Inv(D);%,nt,ni,signmode,roundmode);

%  L1_inv = Inverse(L);
%  D1_inv = Inverse(D);
L_Transpose_inv = L_inv';
X = (L_Transpose_inv*D_inv *L_inv) * (transpose((A/2^ni_nor))*b);       % Division is to make all matrix with same scaling factor 
end 
