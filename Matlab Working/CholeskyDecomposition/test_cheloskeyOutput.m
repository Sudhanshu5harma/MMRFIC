%% Test case to solve system of 4 linear equations
clear all
close all
clc

% rand('seed',123);
% randn('seed',456);
n = 4;
A = (rand(n,n)*100);            % Input matrix 
 A = [63.7709   28.9065   25.4790   34.4462;
   95.7694   67.1808   22.4040   78.0520;
   24.0707   69.5140   66.7833   67.5332;
   67.6122    6.7993   84.4392    0.6715];
% A =[    275.0698  804.4496   87.0772  939.3984
%  248.6290  986.1042  802.0914   18.1775
%  451.6388   29.9920  989.1449  683.8386
%  227.7128  535.6642   66.9463  783.7365 ];

A_cond = (cond(A));
disp(['condition of matrix  ', num2str(A_cond)]);
b = [5;4;8;9];                  

X = cheloskeyOutput(A,b);
X_inBuilt = A\b;                
disp('X and X_inbuilt')

[X X_inBuilt];
difference = (X-X_inBuilt);
SNR = 20*log10(sqrt(mean(difference.^2)))
%% test the equation 
output = [A(1,:)*X A(2,:)*X A(3,:)*X A(4,:)*X]
% diff
