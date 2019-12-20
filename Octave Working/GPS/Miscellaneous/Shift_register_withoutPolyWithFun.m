clc,clear all; close all;
function out_shift = pn(m,s)
l = 2^m - 1;
out_shift =[];
for i =1:l
  out_shift = [out_shift s(1)];
  out_shift_temp = xor(s(1),s(2));
  s(1:m-1)=s(2:m);
  s(m)=out_shift_temp; 
endfor
endfunction

m1 = input ("enter the value of m ");
s1 = input ("enter the starting sequence " );
m2 = input ("enter the value of m ");
s2 = input ("enter the starting sequence " );
a= pn(m1,s1)
b= pn(m2,s2)
gold_code = xor(a,b)