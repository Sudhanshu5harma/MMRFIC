%% Function to calculate cholesky decompostion for 4x4 matrix.
function [L,L1] = chol_SQRT_4x4(A,numIter,nt,ni,signmode,roundmode)
%  L1(1,1) = sqrt(A(1,1));
  L(1,1) = SQRT(A(1,1),numIter,nt,ni,signmode,roundmode);
  L(2,1) = A(1,2)/L(1,1);
  L(3,1) = A(1,3)/L(1,1);
  L(4,1) = A(1,4)/L(1,1);
  L(2,2) = SQRT((A(2,2)-L(2,1)^2),numIter,nt,ni,signmode,roundmode);
  L(3,2) = (A(3,2)-L(2,1)*L(3,1))/L(2,2);
  L(4,2) = (A(4,2) - (L(4,1)*L(2,1)))/L(2,2);
  L(3,3) = SQRT((A(3,3) - L(3,1)^2 - L(3,2)^2),numIter,nt,ni,signmode,roundmode);
  L(4,3) = (A(3,4) - L(3,1)*L(4,1) - L(3,2)*L(4,2))/L(3,3);
  L(4,4) = SQRT(A(4,4) - L(4,1)^2 - L(4,2)^2 - L(4,3)^2,numIter,nt,ni,signmode,roundmode);
  
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
  
  
  L_trasnpose = L';
  L1_trasnpose = L1';
end
