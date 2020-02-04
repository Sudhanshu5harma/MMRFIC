clc;
clear all;
close all; 
tic

rand('seed',123);
randn('seed',456);

n = 4;
A = round(rand(n,n)*10);
b = [5;4;8;9];


signmode = 'signed';
roundmode = 'trunc';


A1 = transpose(A)*A;

ni = ceil(log2(max(max(abs(A1)))));    %Number of integer bits
nt = 40;                              %Total number of bits;
%%[L,D,L_Transpose] = chol_fp(A1,nt,ni,signmode,roundmode);
[L,D,L_Transpose] = chol_float(A1)

% L_inv = chol4x4Inv(L);
% D_inv = chol4x4Inv(D);
 L1_inv = Inverse(L);
 D1_inv = Inverse(D);
L_Transpose_inv = L1_inv';

X = (L_Transpose_inv*D1_inv *L1_inv) * (transpose(A)*b);
X_inBuilt = A\b;
[X X_inBuilt]

%% test the equation 
[A(1,:)*X A(2,:)*X A(3,:)*X A(4,:)*X]
toc