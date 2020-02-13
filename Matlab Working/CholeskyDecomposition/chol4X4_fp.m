function [L_fp,D_fp,L_trans] = chol4X4_fp(A,nt,ni,signmode,roundmode)
% L = zeros(4,4);
%L_trans = zeros(4,4);
% D = zeros(4,4);

% D(1,1)=A(1,1);
D_fp(1,1)=A(1,1);

% L(2,1)=A(2,1)/D(1,1);
L_fp(2,1) = quantize1(A(2,1)/D_fp(1,1),nt,3*ni,signmode,roundmode);

% L(3,1)=A(3,1)/D(1,1); 
L_fp(3,1) = quantize1(A(3,1)/D_fp(1,1),nt,3*ni,signmode,roundmode);

% L(4,1)=A(4,1)/D(1,1);
L_fp(4,1) = quantize1(A(4,1)/D_fp(1,1),nt,3*ni,signmode,roundmode);

val1 = L_fp(2,1)*D_fp(1,1);

% D(2,2)=A(2,2)-(L(2,1)^2*D(1,1));
D_fp(2,2)=quantize1(A(2,2)-quantize1(L_fp(2,1)*val1,nt,3*ni,signmode,roundmode),nt,3*ni,signmode,roundmode);

% L(3,2)=(A(2,3)-(L(3,1)*L(2,1)*D(1,1)))/D(2,2);
L_fp(3,2) = quantize1(quantize1(A(2,3)-quantize1(L_fp(3,1)*val1,nt,3*ni,signmode,roundmode),nt,3*ni,signmode,roundmode)/D_fp(2,2),nt,3*ni,signmode,roundmode);

% L(4,2)=(A(4,2)-(L(4,1)*L(2,1)*D(1,1)))/D(2,2);
L_fp(4,2) = quantize1(quantize1(A(4,2)-quantize1(L_fp(4,1)*val1,nt,3*ni,signmode,roundmode),nt,3*ni,signmode,roundmode)/D_fp(2,2),nt,3*ni,signmode,roundmode);

val2 = L_fp(3,1)*D_fp(1,1);
val3 = L_fp(3,2)*D_fp(2,2);

% D(3,3)=A(3,3)-L(3,1)^2*D(1,1)-L(3,2)^2*D(2,2);
D_fp(3,3) = quantize1(A(3,3)-quantize1(L_fp(3,1)*val2,nt,3*ni,signmode,roundmode)-quantize1(L_fp(3,2)*val3,nt,3*ni,signmode,roundmode),nt,3*ni,signmode,roundmode);

% L(4,3)=(A(4,3)-(L(4,1)*L(3,1)*D(1,1))-(L(4,2)*L(3,2)*D(2,2)))/D(3,3);
L_fp(4,3) = quantize1(quantize1(A(4,3)-quantize1(L_fp(4,1)*val2,nt,3*ni,signmode,roundmode)-quantize1(L_fp(4,2)*val3,nt,3*ni,signmode,roundmode),nt,3*ni,signmode,roundmode)/D_fp(3,3),nt,3*ni,signmode,roundmode);

% D(4,4)=A(4,4)-L(4,1)^2*D(1,1)-L(4,2)^2*D(2,2)-L(4,3)^2*D(3,3);
D_fp(4,4) = quantize1(A(4,4)-quantize1(L_fp(4,1)*L_fp(4,1)*D_fp(1,1),nt,3*ni,signmode,roundmode)-quantize1(L_fp(4,2)*L_fp(4,2)*D_fp(2,2),nt,3*ni,signmode,roundmode)-quantize1(L_fp(4,3)*L_fp(4,3)*D_fp(3,3),nt,3*ni,signmode,roundmode),nt,3*ni,signmode,roundmode);

% L(1,1)=1;L(2,2)=1;L(3,3)=1;L(4,4)=1;
L_fp(1,1)=1;L_fp(2,2)=1;L_fp(3,3)=1;L_fp(4,4)=1;

% L_trans = L';
L_trans = L_fp';

end