% Function to compute the PID loop control output
% function [out] = PIDloop(inp, propConst, intConst, difConst);
function [out,intMemMin1,intMemMax1,difMemMin1,difMemMax1] = PIDloop_fp(inp, propConst, intConst, difConst)

persistent intMem;   % accumulated inp
persistent difMem;   % old inp

persistent intMemMax;
persistent difMemMax;

persistent intMemMin;
persistent difMemMin;

%intmemory = intMem
%difmemory = difMem

% Integral - 11,4,1
% Differential - 14,4,1

if isempty(intMem)
   intMem = 0;
end

if isempty(difMem)
   difMem = 0;
end

if isempty(intMemMax)
   intMemMax = 0;
end

if isempty(intMemMin)
   intMemMin = 10000;
end

if isempty(difMemMax)
   difMemMax = 0;
end

if isempty(difMemMin)
   difMemMin = 10000;
end
%inp = quantize1(inp, 16  , 3, 'unsigned', 'trunc');
propConst = quantize1(propConst, 16  , 3, 'unsigned', 'trunc');
intConst  =  quantize1(intConst, 16  , 3, 'unsigned', 'trunc');
difConst  =  quantize1(difConst, 16  , 3, 'unsigned', 'trunc');


intMem = intMem + inp;
intMem = quantize1(intMem, 16, 4, 'signed', 'trunc');
temp = difMem - inp;
temp = quantize1(temp, 16, 1, 'signed', 'trunc');
difMem = quantize1(inp, 16, 1, 'signed', 'trunc');


out = propConst * inp + temp * difConst + intMem * intConst;
out = quantize1(out, 20,0 , 'signed', 'trunc');
if (intMem>intMemMax)
  intMemMax = intMem;
end

if (difMem>difMemMax)
  difMemMax = difMem;
end

if (intMem<intMemMin)
  intMemMin = intMem;
  
end
if (difMem<difMemMin)
  difMemMin = difMem;
end

intMemMax1 = intMemMax;
difMemMax1 = difMemMax;
intMemMin1 = intMemMin;
difMemMin1 = difMemMin;

% End of function

