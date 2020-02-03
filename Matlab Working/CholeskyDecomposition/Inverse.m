function[x]=Inverse(L,D)
%This function solve a lower triangular system.
b = [1 3 4 3]';
y = L\b;
%y = inv(L)*b;
x = (D*L')\y;
%x = inv(D*L')*y;
end