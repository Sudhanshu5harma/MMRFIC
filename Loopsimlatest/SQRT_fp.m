%%-------------------------------------------------------------
%% Function to find fixed point square root approximation using Newton-Raphson method
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%---------------------------------------------------------------
%% Version History: (in reverse chronological order please)
%% 
%% V0.1   09-Mar-2020    Srinivasan    Created  
%%---------------------------------------------------------------

function [mant,exp2] = SQRT_fp(number,numIter,nt,ni,signmode,roundmode)
%count = 0;
k = 1;
NUM_TABLE = 64;
TABLE_PREC = 18;
sqrt_table = floor(sqrt([0.5:0.5/NUM_TABLE:1-0.5/NUM_TABLE]) * 2^TABLE_PREC); 

%% check if the input is negative 
    if (number < 0)
       num = abs(number);
    else 
        num = number;
    end 
    %% Add scaling factor for 1e3 for input less than 1e-4
    %if (num <=9e-4)
%         num = num * 1e4;
    %    num = num * 2^14;                 % Multiply by 2^14
    %    count = 1;
    %end 
    %if (num > 2)
    nint = ceil(log2(num));
    num = num/2^nint;
    %end 
    %% Iteration for Newton Raphson 
    LUTindex = min(NUM_TABLE,1+floor((num-0.5)*NUM_TABLE*2));
    if (floor(nint/2)*2==nint)   % if even
       x1 = sqrt_table(LUTindex)/2^TABLE_PREC;
       x = x1;
    else
       x1 = sqrt_table(LUTindex)/2^(TABLE_PREC+1);
       num = num/2;
       nint = nint+1;
       x = x1;
    end
  
    for i = 1:numIter
        x = (x + (num/x))/2;
        x1 = quantize1(quantize1(x1 + quantize1(num/x1,nt,ni,signmode,roundmode), ...
                       nt,ni,signmode,roundmode)/2,nt,ni,signmode,roundmode);
    end
        %% Remove scaling factor 
    %if (count == 1)
    %    x1 = x1/128;                % divide by sqrt(2^14)
    %end 
    %% If input is negative return imaginary number 
    %if (number < 0)
    %    answer = x1 * 1j;
    %else 
    %    answer = x1;
    %end

   mant = x1;
   %if (isodd(nint))
   %  nint = nint-1;
   %  x1 = x1 * sqrt(2*2^16);
  %end
   exp2 = nint/2; 
end