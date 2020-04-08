% Function to compute the PID loop control output
% function [out] = PIDloop(inp, propConst, intConst, difConst);
function [out] = PIDloop_v2_fp(inp, propConst, intConst, difConst)

persistent intFiltState;   % accumulated inp
persistent difFiltState;   % old inp

if isempty(intFiltState)
   intFiltState = [0];
end

if isempty(difFiltState)
   difFiltState = [0];
end

%intMem = intMem + inp;
%temp = difMem - inp;
%difMem = inp;
%[intFiltOut, intFiltState] = filter([1 1],[1 -1],inp,intFiltState);
temp = intFiltState;
intFiltState = quantize1(inp + temp, 18, 3, 'signed','trunc');
intFiltOut = quantize1(intFiltState + temp, 18, 3, 'signed', 'trunc');

%[difFiltOut, difFiltState] = filter([1 -1],[1 -(1-2^-7)],inp,difFiltState);
temp = difFiltState;
difFiltState = quantize1(inp + temp * (1-2^-4), 18, 3, 'signed','trunc');  % Other factors are 2^-4,2^-5,2^-6,2^-7
difFiltOut = quantize1(difFiltState - temp, 18, 3, 'signed', 'trunc');

% Faster convergence - Less accurate - works with PID constants set  2(c) & 2(d) 10 usec convergence - 1 or 2 usec window, 2(b) with 1 or 2 or 4 or 8 usec window
%out = propConst * inp + 2^(-1) * difFiltOut * difConst + 2^(-1) * intFiltOut * intConst;
out1 = quantize1(propConst * inp, 20, 3, 'signed', 'trunc');
out2 = quantize1(2^(-1) * difFiltOut * difConst, 20, 3, 'signed', 'trunc');
out3 = quantize1(2^(-1) * intFiltOut * intConst, 20, 3, 'signed', 'trunc');
out = quantize1(out1 + out2 + out3, 20, 5, 'signed', 'trunc');

% Medium convergence - works with PID constants set 2(c) & 2(d) 10 usec convergence - 1 usec window, 2(b) with 2 usec or 4 usec or 8 usec
%out = propConst * inp + 2^(-2) * difFiltOut * difConst + 2^(-2) * intFiltOut * intConst;
% Slow convergence - works with PID constants set 2(d) 10 usec convergence - 2 usec window
%out = propConst * inp + 2^(-3) * difFiltOut * difConst + 2^(-3) * intFiltOut * intConst;
% Super Slow convergence - More accurate  - works with PID constants set  2(d) - 20 usec convergence - 1 usec window
%out = propConst * inp + 2^(-4) * difFiltOut * difConst + 2^(-4) * intFiltOut * intConst;


