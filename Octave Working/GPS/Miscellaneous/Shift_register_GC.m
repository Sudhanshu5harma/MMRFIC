clear all; close all;
m =4;
G = [1 0 0 1 1];
s = [0 0 1 1];
l = 2^m - 1;
out_shift =[];
for i =1:l
  out_shift = [out_shift s(1)]
  out_shift_temp = xor(G(1)*s(1),G(m)*s(m));
  s(1:m-1)=s(2:m);
  s(m)=out_shift_temp;  
  
endfor
