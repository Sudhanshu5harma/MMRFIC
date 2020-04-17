%%-------------------------------------------------------------
%% Function to calculate fixed point cholesky decompostion for 4x4 matrix.
%%
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%---------------------------------------------------------------
%% Version History: (in reverse chronological order please)
%% 
%% V0.1   09-Mar-2020    Srinivasan    Created  
%%---------------------------------------------------------------
%%
%% Functions called
%%
%%  1. SQRT_fp()
%%---------------------------------------------------------------
function [L,L1] = chol_SQRT_4x4_fp(A,numIter,nt,ni,signmode,roundmode)


%% Fixed point calculation of L 
%  L1(1,1) = sqrt(A(1,1));
  L(1,1) = SQRT_fp(A(1,1),numIter,nt,ni,signmode,roundmode);
  L(2,1) = quantize1(A(1,2)/L(1,1),nt,ni,signmode,roundmode);
  L(3,1) = quantize1(A(1,3)/L(1,1),nt,ni,signmode,roundmode);
  L(4,1) = quantize1(A(1,4)/L(1,1),nt,ni,signmode,roundmode);
  L(2,2) = SQRT_fp((A(2,2)-L(2,1)^2),numIter,nt,ni,signmode,roundmode);
%   L(2,2) = SQRT_fp_norm(quantize1(A(2,2) - (quantize1(L(2,1)*L(2,1),nt,ni,signmode,roundmode)),nt,ni,signmode,roundmode),numIter,nt,ni,signmode,roundmode);
  
%   L(3,2) = (A(3,2)-L(2,1)*L(3,1))/L(2,2);
  L(3,2) = quantize1(quantize1(A(3,2) - quantize1(L(2,1)*L(3,1),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode)/L(2,2),nt,ni,signmode,roundmode);
%   L(4,2) = (A(4,2) - (L(4,1)*L(2,1)))/L(2,2);
  L(4,2) = quantize1((quantize1(A(4,2) - quantize1(L(4,1) * L(2,1),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode))/L(2,2),nt,ni,signmode,roundmode);
  
%  L(3,3) = SQRT_fp((A(3,3) - L(3,1)^2 - L(3,2)^2),numIter,nt,ni,signmode,roundmode);
  L(3,3) = SQRT_fp(quantize1(A(3,3) - quantize1(quantize1(L(3,1)*L(3,1),nt,ni,signmode,roundmode)+quantize1(L(3,2)*L(3,2),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode),numIter,nt,ni,signmode,roundmode);
%   L(4,3) = (A(3,4) - L(3,1)*L(4,1) - L(3,2)*L(4,2))/L(3,3);
  L(4,3) = quantize1((quantize1(A(3,4) - quantize1(L(3,1)*L(4,1),nt,ni,signmode,roundmode)-quantize1(L(3,2)*L(4,2),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode))/L(3,3),nt,ni,signmode,roundmode);
%   L(4,4) = SQRT_fp(quantize1((A(4,4) - quantize1((quantize1(L(4,1)*L(4,1),nt,ni,signmode,roundmode)+quantize1((quantize1(L(4,2)*L(4,2),nt,ni,signmode,roundmode)+quantize1(L(4,3)*L(4,3),nt,ni,signmode,roundmode)),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode))),nt,ni,signmode,roundmode),numIter,nt,ni,signmode,roundmode);
 L(4,4) = SQRT_fp((quantize1(A(4,4) - quantize1(quantize1(L(4,1)* L(4,1),nt,ni,signmode,roundmode)+quantize1(quantize1(L(4,2)* L(4,2),nt,ni,signmode,roundmode)+quantize1(L(4,3)* L(4,3),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode)),numIter,nt,ni,signmode,roundmode);
%   quantize1((A(4,4) -   quantize1((quantize1(L(4,1)*L(4,1),nt,ni,signmode,roundmode)+quantize1((quantize1(L(4,2)*L(4,2),nt,ni,signmode,roundmode)+quantize1(L(4,3)*L(4,3),nt,ni,signmode,roundmode)),nt,ni,signmode,roundmode),nt,ni,signmode,roundmode))),nt,ni,signmode,roundmode);
  
  %% Floating point calculation of L
  L1(1,1) = sqrt(A(1,1));
  L1(2,1) = A(1,2)/L1(1,1);
  L1(3,1) = A(1,3)/L1(1,1);
  L1(4,1) = A(1,4)/L1(1,1);
  L1(2,2) = sqrt((A(2,2)-L1(2,1)^2));
  L1(3,2) = (A(3,2)-L1(2,1)*L1(3,1))/L1(2,2);
  L1(4,2) = (A(4,2) - (L1(4,1)*L1(2,1)))/L1(2,2);
  L1(3,3) = sqrt((A(3,3) - L1(3,1)^2 - L1(3,2)^2));
  L1(4,3) = (A(3,4) - L1(3,1)*L1(4,1) - L1(3,2)*L1(4,2))/L1(3,3);
  L1(4,4) = sqrt(A(4,4) - L1(4,1)^2 - L1(4,2)^2 - L1(4,3)^2);
end
