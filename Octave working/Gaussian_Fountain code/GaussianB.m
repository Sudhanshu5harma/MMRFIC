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
function   x = GaussianB(A, b)
  mat = [A b];
  noOnes=0;
  [m n] = size(A); % read the size of the original matrix A
  x = zeros(n, 1);     % just an initialization
  for i = 1 : n
    j = find(mat(i:m, i), 1); % finds the FIRST 1 in i-th column starting at i
    if isempty(j)
      noOnes=1; %changing this
##   error('Not enough 1s available');
    else
      j = j + i -1;    %we need to add i-1 since j starts at i
      temp = mat(j, :);      % swap rows
      mat(j, :) = mat(i,:);
      mat(i, :) = temp;% add i-th row to all rows that contain 1 in i-th column
      % starting at j+1 -remember up to j are zeros
      for k = find(mat( (j+1):m, i ))' 
        mat(j + k, :) = bitxor(mat(j + k, :), mat(i, :));
      end
    end
  end
##  Upertri=mat;
  if(noOnes == 1)
    x;
  else
  for i = n : -1 : 1  % go back from n to 1
    x(i) = bitand(dot(mat(i, i:n), x(i:n)) + mat(i, n + 1), 1);
  end
end
endfunction

