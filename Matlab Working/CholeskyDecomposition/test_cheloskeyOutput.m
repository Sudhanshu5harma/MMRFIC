%% Test case to solve system of 4 linear equations
clear all
close all
clc

% rand('seed',123);
% randn('seed',456);
n = 4;
A = (-1*rand(n,n)*100);            % Input matrix 
A_cond = log10(cond(A));
disp(['condition of matrix  ', num2str(A_cond)]);
b = [5;4;8;9];                  

X = cheloskeyOutput(A,b);
X_inBuilt = A\b;                
disp('X and X_inbuilt')

[X X_inBuilt]
difference = (X-X_inBuilt);

%% test the equation 
output = [A(1,:)*X A(2,:)*X A(3,:)*X A(4,:)*X]
% diff
