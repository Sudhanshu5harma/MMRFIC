function [res24, res24Shift] = oneBySqrt(num)

% Compute 1/sqrt(num) in newton-raphson method. We start with an initial guess
%   from the look-up table. Each iteration should double the number of bits of
%   accuracy (=> 2 iterations are enough). However we are using 3 iterations
%   to reduce inacuracies due to fixed point implementation.

sqrtTable = floor(0.5./sqrt(0.5+(0:127)*0.5/128)*2^23);

if (num == 0)
    res24 = 2^23-1;
    res24Shift = 0;
else
    % Make sure the norm shift is positive, by limiting num
    num1 = limit48(num);
    num1Shift = clb48(num1);
    num1 = rnd24(floor(num1*2^num1Shift));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Estimate 0.5/sqrt(num1)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    guess24By2 = sqrtTable(floor(num1/2^15)-127);
    res24 = guess24By2;

    for iter = 1:3
        temp24 = (3/4*2^23 - mpyr24(num1, mpyr24(res24, res24)));
        res24 = floor(2 * (res24 * temp24 * 2)/2^24);
    end

    if (rem(num1Shift, 2) == 1)
        res24 = mpy24(res24, floor(sqrt(2)*2^23));
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Get shift factor for 1/sqrt(num1). Add 1 because res24=0.5/sqrt(num1)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    res24Shift = -1-floor(num1Shift/2);
end
