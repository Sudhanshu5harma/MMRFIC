%% function [xHat, pp] = interp_poly_v2(tVec,xVec,tOut)
%%---------------------------------------------------------------
%% Program to interpolate the peak of the sinusoid
%%
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%---------------------------------------------------------------
%% Version History: (in reverse chronological order please)
%% 
%% V0.2   27-Sep-2016    GanesanT    Modified to run no time axis scaling
%% V0.1   18-Jul-2016    GanesanT    Created  
%%---------------------------------------------------------------
%%
%% Functions called
%%
%%  None
%%---------------------------------------------------------------
function [xHat, pp] = interp_poly_v2(tVec_pt,xVec_pt,tOut)

linSlopeVec = diff(xVec_pt);   % N subtractions
numInpPts = length(tVec_pt);
numOutPts = length(tOut);

%Ensure that 3 input pts are available before & after first/last output pt.
if tVec_pt(3) > tOut(1)
    disp('Output time vector starts too early ... shortening it');
    nVec = find(tOut >= tVec_pt(3));
    tOut1 = tOut(nVec);
else
    tOut1 = tOut;
    nVec = 1:length(tOut);
end
indexTout = nVec;

if tVec_pt(end-2) < tOut1(end)
    disp('Output time vector goes on for too long ... shortening it');
    nVec = find(tOut1 <= tVec_pt(end-2));
    tOut2 = tOut1(nVec);
else
    tOut2 = tOut1;
    nVec = 1:length(tOut1);
end

indexTout = indexTout(nVec);
numSlopePts = numInpPts - 1;
numOutPts = length(tOut2);
             
pp_coef = zeros(numOutPts,4);
xHat_pp = zeros(1,numOutPts);

% Total complexity: 11 Additions + 3 Multiplications per output sample computation
for (n=1:numOutPts)    
    x1_n = max(find(tVec_pt < tOut2(n)));  % Find the time sample which is closest to the output time 
    
    xVec = tVec_pt(x1_n - 1:x1_n + 2);     % Take 1 sample before and 2 samples after the output time
    yVec = xVec_pt(x1_n - 1:x1_n + 2);    
    
    %Get the 4 samples points of interest
    x1 = xVec(1);x2 = xVec(2);x3 = xVec(3);x4 = xVec(4);
    y1 = yVec(1);y2 = yVec(2);y3 = yVec(3);y4 = yVec(4);
        
    %Get slopes of interest (3 Additions - 3A)    
    m2 = (y2-y1);   
    m3 = (y3-y2); 
    m4 = (y4-y3);

    %Compute (t3-m3) and (t4 - m3) .... (2A)
    t3_m3 = 0.5*(m2 - m3);% w2/(w2+w1)*(m2 - m3);
    t4_m3 = 0.5*(m4 - m3);% w2/(w2+w3)*(m4 - m3);  
   
    % Get Coeff: 1A
    pp_coef(n,4) = y2;
    pp_coef(n,3) = m3;    
    pp_coef(n,2) = -(t3_m3);
    pp_coef(n,1) = (t3_m3+t4_m3);    
    
    % Get Diffs: 2A
    x_x1 = (tOut2(n) - x2); 
    x_x2 = x_x1-1;
    
    % Eval poly: 3M + 3A 
    xHat_pp(n) = pp_coef(n,4) + x_x1*(pp_coef(n,3) + x_x2*(pp_coef(n,2) + pp_coef(n,1)*x_x1));

end

xHat = xHat_pp;
pp = pp_coef;

% End of function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
