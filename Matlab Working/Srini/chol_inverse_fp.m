%% Function to find inverse for 4x4 Lower triangular matrix using cholesky decomposition
%%------------------------------------------------------------------------------------------
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%------------------------------------------------------------------------------------------
%% Version History: (in reverse chronological order please)
% v0.1   16-Apr-2020    Srinivasan    Created  
%%------------------------------------------------------------------------------------------
%% Functions called
%  1. chol_SQRT_4x4_fp_v2(A1,numIter,nt,ni,signmode,roundmode);
%  2. chol_LowTMatrix4x4Inv_fp(L,nt,ni,signmode,roundmode);
%%------------------------------------------------------------------------------------------
function inverse = chol_inverse_fp(A1,numIter,nt,ni,signmode,roundmode)

ni_nor = ceil(log2(max(max(abs(A1)))));

A1 = A1/2^ni_nor;

l_fp = chol_SQRT_4x4_fp_v2(A1,numIter,nt,ni,signmode,roundmode);

l_inv = chol_LowTMatrix4x4Inv_fp(l_fp,nt,ni,signmode,roundmode);

inverse = l_inv'*l_inv/2^ni_nor;

end 