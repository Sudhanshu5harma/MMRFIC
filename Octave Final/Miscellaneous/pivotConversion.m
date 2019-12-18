%% Function to convert matrix into matrix with pivot diagonals.

function matrix = pivotConversion(matrix)
    [rows, column] = size(matrix);
    for i = 1:column-1 #I'm doing minus 1 because we are using augmented matrix and last 64,64 elememt we don't need to worry abt
        if (matrix(i,i) == 0)
           while(matrix(i,i) == 0)
               for x = i+1:length(matrix)
                   temp = matrix(i,:);
                   matrix(i,:) = matrix(x,:);
                   matrix(x,:) = temp;
               end 
           end 

        end 
    end 
end 