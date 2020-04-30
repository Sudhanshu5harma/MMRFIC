%% Function to calculate fixed point Lower triangular matrix for given 4x4 hermitian matrix.
%%------------------------------------------------------------------------------------------
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%------------------------------------------------------------------------------------------
%% Version History: (in reverse chronological order please)
% v0.2   22-Apr-2020    Srinivasan    modified code for complex numbers.   
% v0.1   09-Mar-2020    Srinivasan    Created  
%%------------------------------------------------------------------------------------------
%% Functions called
%  1. SQRT_fp()
%%------------------------------------------------------------------------------------------
function [L] = chol_SQRT_4x4_fp_v2(A,numIter,nt,ni,signmode,roundmode)

    L(1,1) = SQRT_fp(A(1,1),numIter,nt,ni,signmode,roundmode);
    L(2,1) = quantize1(A(2,1)/L(1,1),nt,ni,signmode,roundmode);
    L(3,1) = quantize1(A(3,1)/L(1,1),nt,ni,signmode,roundmode);
    L(4,1) = quantize1(A(4,1)/L(1,1),nt,ni,signmode,roundmode);

    L(2,2) = SQRT_fp((A(2,2)- quantize1(L(2,1)*L(2,1)',nt,ni,signmode,roundmode)),numIter,nt,ni,signmode,roundmode);
    L(3,2) = quantize1(quantize1(A(3,2) - quantize1(L(2,1)'*L(3,1),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode)/L(2,2),nt,ni,signmode,roundmode);
    L(4,2) = quantize1((quantize1(A(4,2) - quantize1(L(4,1) * L(2,1)',nt,ni,signmode,roundmode),nt,ni,signmode,roundmode))/L(2,2),nt,ni,signmode,roundmode);

    L(3,3) = SQRT_fp(quantize1(A(3,3) - quantize1(quantize1(L(3,1)*L(3,1)',nt,ni,signmode,roundmode)+quantize1(L(3,2)*L(3,2)',nt,ni,signmode,roundmode),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode),numIter,nt,ni,signmode,roundmode);
    L(4,3) = quantize1((quantize1(A(4,3) - quantize1(L(3,1)'*L(4,1),nt,ni,signmode,roundmode)-quantize1(L(3,2)'*L(4,2),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode))/L(3,3)',nt,ni,signmode,roundmode);

    L(4,4) = SQRT_fp((quantize1(A(4,4) - quantize1(quantize1(L(4,1)* L(4,1)',nt,ni,signmode,roundmode)+quantize1(quantize1(L(4,2)* L(4,2)',nt,ni,signmode,roundmode)+quantize1(L(4,3)* L(4,3)',nt,ni,signmode,roundmode),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode)),numIter,nt,ni,signmode,roundmode);

end 