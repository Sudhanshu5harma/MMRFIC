clc; close all;

format long;
load('Hmat.mat');
matrix = H';
% matrixchar = mat2str(matrix);
% matrix_no_space = matrixchar(~isspace(matrixchar));
% new_matrix = zeros(441,2);
% starting = 2;
% middle = 33;
% last = 64;
% for column = 1:441
% %     disp(['ran : ' num2str(column)]);
%     new_matrix(column,1)=bin2dec(matrix_no_space(1,starting:middle));
%     new_matrix(column,2)=bin2dec(matrix_no_space(1,middle+1:last));
%     starting = starting+64;
%     middle =middle+64;
%     last=last+64;
% end
% 
% new_decmatrix = new_matrix(:,1)*2^31 + new_matrix(:,2);
% reduced_matrix = dec2bin(new_decmatrix);

% Different Approach 
new_decmatrix1 = dec2bin(matrix*2.^[62:-1:0]');
