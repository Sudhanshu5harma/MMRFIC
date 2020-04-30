%% Function to solve 4x4 equation using cholesky decomposition
%%
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%---------------------------------------------------------------
%% Version History: (in reverse chronological order please)
% v0.1   16-Apr-2020    Srinivasan    Created  
%%---------------------------------------------------------------
%% Functions called
%  1. chol_SQRT_4x4_fp_v2(A1,numIter,nt,ni,signmode,roundmode);
%  2. chol_LowTMatrix4x4Inv_fp(L,nt,ni,signmode,roundmode);
%%---------------------------------------------------------------
function [X] = chol_4x4(A,b,numIter,nt,ni,signmode,roundmode)
    ni_nor = ceil(log2(max(max(abs(A)))))    ;        
    A1 = A/(2^ni_nor);
    %  [L,L1] = chol_SQRT_4x4_fp(A1,numIter,nt,ni,signmode,roundmode);    
    L = chol_SQRT_4x4_fp_v2(A1,numIter,nt,ni,signmode,roundmode);
    [L_inv] = chol_LowTMatrix4x4Inv_fp(L,nt,ni,signmode,roundmode);
    L_Transpose_inv = L_inv';
    X = (L_Transpose_inv * L_inv) * (b)/2^ni_nor;
end  