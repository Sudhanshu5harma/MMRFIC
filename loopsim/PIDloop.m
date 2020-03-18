% Function to compute the PID loop control output
% function [out] = PIDloop(inp, propConst, intConst, difConst);
function [out] = PIDloop(inp, propConst, intConst, difConst)

persistent intMem;   % accumulated inp
persistent difMem;   % old inp

if isempty(intMem)
   intMem = 0;
end

if isempty(difMem)
   difMem = 0;
end

intMem = intMem + inp;
temp = difMem - inp;
difMem = inp;

out = propConst * inp + temp * difConst + intMem * intConst;


