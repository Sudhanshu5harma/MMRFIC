%% ------------------------------------------------------
%% Function to implement Gaussian Elimination of Galois Field (2)
%%-------------------------------------------------------
%% (c) MMRFIC Technology Private Limited.
%%-------------------------------------------------------
%% Version History (Reverse chronological order please)
%%-------------------------------------------------------
%%  Ver     Date        Author            Comments
%%  1.0     Nov 19     Sudhanshu Sharma   Correction minor fixes
%%  0.3     Nov 19     Sudhanshu Sharma   Working with Binary data
%%  0.2     Oct 19     Sudhanshu Sharma   Working with Integer data
%%  0.1     Oct 19     Sudhanshu Sharma   Started
%%-------------------------------------------------------
%%  Functions used
%%  None
%%-------------------------------------------------------
%%  Variable used
%%  A : CodeMatrix
%%  b : Encoded bits in matrix format
%%  x : Solution of equation
%%-------------------------------------------------------
function [y, x] = GaussianBIntegerVER1(codematrix, demodbits)
format long;
mat = [codematrix demodbits];
noOnes=0;
[m , ~] = size(codematrix); % read the size of the original matrix A
n1=32;
n2=63;

for i = 1 : n2
    if (i<=n1)
        mask = bitsra(2^32,i);
        temp1 =  bitand(mat(i:m, 1), mask) ./ mask;
        j = find(temp1(:,1), 1); % finds the FIRST 1 in i-th column starting at i
        if isempty(j)
            noOnes=1;
        else
            j = j + i -1;    %we need to add i-1 since j starts at i
            temp = mat(j, :);      % swap rows
            mat(j, :) = mat(i,:);
            mat(i, :) = temp;% add i-th row to all rows that contain 1 in i-th column       
            temp2 =  bitand(mat((j+1):m, 1), mask) ./ mask;
            for indices = (find(temp2))'
                mat(j + indices, :) = bitxor(mat(j + indices, :), mat(i, :));
            end
        end
    else
        mask1 = bitsra(2^63,i);
        temp3 =  bitand(mat(i:m, 2), mask1) ./ mask1;
        j = find(temp3(:,1), 1); % finds the FIRST 1 in i-th column starting at i 
        if isempty(j)
            noOnes=1; %changing this
        else
            j = j + i -1;    %we need to add i-1 since j starts at i
            temp4 = mat(j, :);      % swap rows
            mat(j, :) = mat(i,:);
            mat(i, :) = temp4;% add i-th row to all rows that contain 1 in i-th column
            
            temp2 =  bitand(mat((j+1):m, 2), mask1) ./ mask1;
            for indices1 = (find(temp2))'
                mat(j + indices1, :) = bitxor(mat(j + indices1, :), mat(i, :));
            end
        end
    end
end
y = mat;
x1=zeros(32,1);
x2=zeros(31,1);
x=[x1;x2];
% x2(n2) = mat(n2,3);
if(noOnes == 1)
    x;
else
    matbin2 = dec2bin(mat(n1+1:n2,2));
    w = bitor(bitsll(mat(1:n1,1),31),mat(1:n1,2));
    matbin4 = dec2bin(w);

    for i = 63 : -1 : 1  % go back from n to 1
        if (i>n1)
            x(i) = bitand(dot(matbin2(i-32, i-32:31), x(i:n2)) + mat(i, 3), 1);
        else
            x(i) = bitand(dot(matbin4(i, i:n2), x(i:n2)) + mat(i, 3), 1);
        end
        
    end
end
% D77AWQKBF8NQKQ6
% K85EU4QT4FWRDC4
% Q8RXFHZP45GH9AM