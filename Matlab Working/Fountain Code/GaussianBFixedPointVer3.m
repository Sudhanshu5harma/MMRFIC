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
function  x = GaussianBFixedPointVer3(A, b)
mat = [A b];
noOnes=0;
[m , ~] = size(A); % read the size of the original matrix A
n=63;
x = zeros(n, 1);     % just an initialization
for i = 1 : n
      mask = bitsra(2^63,i);

    temp1 =  bitand(mat(i:m, 1), mask) ./ mask;

    j = find(temp1(:,:), 1); % finds the FIRST 1 in i-th column starting at i

    if isempty(j)
        noOnes=1; %changing this
        %%   error('Not enough 1s available');
    else
        j = j + i -1;    %we need to add i-1 since j starts at i
        temp = mat(j, :);      % swap rows
        mat(j, :) = mat(i,:);
        mat(i, :) = temp;% add i-th row to all rows that contain 1 in i-th column

        temp2 =  bitand(mat((j+1):m, 1), mask) ./ mask;
        for indices = (find(temp2 > 0))'
            mat(j + indices, :) = bitxor(mat(j + indices, :), mat(i, :));
        end
    end
end
% val=mat;
%x(n) = mat(n,2);
if(noOnes == 1)
    x;
else
    matbin = dec2bin(mat(1:n));
    x = mod(matbin * mat(1:n,2),2);
%     for i = n-1 : -1 : 1  % go back from n to 1
% %        x(i) = bitand(dot(matbin(i, i:n), x(i:n)) + mat(i, 2), 1);
%          x(i) = mod(matbin(i,i:n) * mat(i:n,2),2) ;
% %           x(i) = bitand(mat(i,1),mat(i,2)); % ERROR IN LOGIC
%     end
end
end