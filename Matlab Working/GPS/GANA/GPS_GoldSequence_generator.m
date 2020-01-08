%%---------------------------------------------------------------
%% Program to generate the GPS L1 C/A codes  
%%
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%---------------------------------------------------------------
%% Version History: (in reverse chronological order please)
%%  0.1  :  17-Dec-2019  :  Ganesan T  :  converted into a function
%%---------------------------------------------------------------
%%
%% Usage:
%% function [code, symbol] = GPS_GoldSequence_generator(init_g1, init_g2, codeLen, fbMode, offset)
%% 
%% Inputs:
%%    init_g1 - LSFR-1's initial value (10 bit array)
%%    init_g2 - LSFR-2's initial value (10 bit array)
%%    codeLen - Generated bit stream length (=codeLen + offset)
%%    fbMode  - code/SV number (from SV0 to SV37)
%%    offset  - Skipping 'offset' number of generated bits
%%
%%    Alternate name for fbMOdes : PRN_Disabled (SV0), PRN1_2xor6 (SV1), PRN2_3xor7, PRN3_4xor8, ...
%%                        PRN4_5xor9, PRN5_1xor9, PRN6_2xor10, PRN7_1xor8, ...
%%                        PRN8_2xor9, PRN9_3xor10, PRN10_2xor3, PRN11_3xor4, ...
%%                        PRN12_5xor6, PRN13_6xor7, PRN14_7xor8, PRN15_8xor9, ...
%%                        PRN16_9xor10, PRN17_1xor4, PRN18_2xor5, PRN19_3xor6, ...
%%                        PRN20_4xor7, PRN21_5xor8, PRN22_6xor9, PRN23_1xor3, ...
%%                        PRN24_4xor6, PRN25_5xor7, PRN26_6xor8, PRN27_7xor9, ...
%%                        PRN28_8xor10, PRN29_1xor6, PRN30_2xor7, PRN31_3xor8, ...
%%                        PRN32_4xor9, PRN33_5xor10, PRN34_4xor10, PRN35_1xor7, ...
%%                        PRN36_2xor8, PRN37_4xor10 (SV37)
%%
%% Outputs:
%%    code    - Generated Gold code bits of length (codeLen)
%%    symbol  - Generated BPSK symbols from the code bits 

function [code, symbol] = GPS_GoldSequence_generator(init_g1, init_g2, codeLen, fbMode, offset)

% addpath('F:\OneDrive - MMRFIC\userdata\work\matlab\bitfun\')
% addpath('F:\OneDrive - MMRFIC\userdata\work\matlab\polyfun\')

if (nargin < 1) 
    initialState_G1 = ones(1,10);
else
    initialState_G1 = init_g1;
end

if (nargin < 2)
    initialState_G2 = ones(1,10);
else
    initialState_G2 = init_g2;
end

if (nargin < 3)
    codeLen = 1023;
end

if (nargin < 4)
    fbMode = 'PRN_Disabled';
    fbMode = 'SV1'; %'PRN2_2xor6';
    %fbMode = 'PRN2_3xor7';
end

if (nargin < 5)
    offset = 0;
end

%polynomial1 = [1 0 0 0 1 1 1 0 1];%X^8+X^4+X^3+X^2+1
%polynomial2 = [1 0 1 0 1 1 1 1 1];%X^8+x^6+X^4+X^3+X^2+X+1
%polynomial1 = [1 0 0 0 1 0 1 1 0 1];%x^9 + x^5 + x^3 + x^2 + 1
%polynomial2 = [1 0 0 1 0 1 1 0 0 1];%x^9 + x^6 + x^4 + x^3 + 1
polynomial1 = [1 0 0 0 0 0 0 1 0 0 1];%x^10 + x^3 +  1
polynomial2 = [1 1 1 0 1 0 0 1 1 0 1];%x^10 + x^9 + x^8 + x^6 + x^3 + x^2 + 1


switch (fbMode)  % SVname
    %disp('Generation of Gold code:')
    case {'PRN_Disabled', 'SV0'}
        prn1 = gf2polyGenPrn(initialState_G1,polynomial1,codeLen + offset);        % PN sequence1
        prn2 = gf2polyGenPrn(initialState_G2,polynomial2,codeLen + offset);        % PN sequence2
        
        gCode = xor(prn1,prn2);                 % Gold code
        code = gCode(1+offset:offset+codeLen);  % Code with a offset    
    case {'PRN2_2xor6','SV1'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(6),gf2State(2)),gf1State(10));
            code = code1(offset+1:end);
        end
    case {'PRN2_3xor7', 'SV2'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(7),gf2State(3)),gf1State(10));
            code = code1(offset+1:end);
        end   
    case {'PRN3_4xor8', 'SV3'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(8),gf2State(4)),gf1State(10));
            code = code1(offset+1:end);
        end        
    case {'PRN4_5xor9', 'SV4'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(9),gf2State(5)),gf1State(10));
            code = code1(offset+1:end);
        end
    case {'PRN5_1xor9', 'SV5'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(9),gf2State(1)),gf1State(10));
            code = code1(offset+1:end);
        end        
    case {'PRN6_2xor10', 'SV6'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(10),gf2State(2)),gf1State(10));
            code = code1(offset+1:end);
        end        
    case {'PRN7_1xor8', 'SV7'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(8),gf2State(1)),gf1State(10));
            code = code1(offset+1:end);
        end        
    case {'PRN8_2xor9', 'SV8'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(9),gf2State(2)),gf1State(10));
            code = code1(offset+1:end);
        end
    case {'PRN9_3xor10', 'SV9'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(10),gf2State(3)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN10_2xor3', 'SV10'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(2),gf2State(3)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN11_3xor4', 'SV11'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(4),gf2State(3)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN12_5xor6', 'SV12'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(5),gf2State(6)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN13_6xor7', 'SV13'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(7),gf2State(6)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN14_7xor8', 'SV14'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(7),gf2State(8)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN15_8xor9', 'SV15'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(9),gf2State(8)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN16_9xor10', 'SV16'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(9),gf2State(10)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN17_1xor4', 'SV17'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(1),gf2State(4)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN18_2xor5', 'SV18'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(2),gf2State(5)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN19_3xor6', 'SV19'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(3),gf2State(6)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN20_4xor7', 'SV20'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(4),gf2State(7)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN21_5xor8', 'SV21'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(5),gf2State(8)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN22_6xor9', 'SV22'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(6),gf2State(9)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN23_1xor3', 'SV23'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(1),gf2State(3)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN24_4xor6', 'SV24'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(4),gf2State(6)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN25_5xor7', 'SV25'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(5),gf2State(7)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN26_6xor8', 'SV26'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(6),gf2State(8)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN27_7xor9', 'SV27'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(7),gf2State(9)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN28_8xor10', 'SV28'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(8),gf2State(10)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN29_1xor6', 'SV29'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(1),gf2State(6)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN30_2xor7', 'SV30'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(2),gf2State(7)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN31_3xor8', 'SV31'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(3),gf2State(8)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN32_4xor9', 'SV32'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(4),gf2State(9)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN33_5xor10', 'SV33'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(5),gf2State(10)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN34_4xor10', 'SV34'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(4),gf2State(10)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN35_1xor7', 'SV35'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(1),gf2State(7)),gf1State(10));
            code = code1(offset+1:end);
        end           
    case {'PRN36_2xor8', 'SV36'}
        gf1State = initialState_G1;
        gf2State = initialState_G2;
        code1 = zeros(1,codeLen+offset);
        for ii = 1:codeLen + offset
            [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
            [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
            code1(ii) = bitxor(bitxor(gf2State(2),gf2State(8)),gf1State(10));
            code = code1(offset+1:end);
        end           
%     case {'PRN37_4xor10', 'SV37'}    % same as SV34
%         gf1State = initialState_G1;
%         gf2State = initialState_G2;
%         code1 = zeros(1,codeLen+offset);
%         for ii = 1:codeLen + offset
%             [prn1,gf1State] = gf2polyGenPrn(gf1State,polynomial1,1);        % PN sequence1
%             [prn2,gf2State] = gf2polyGenPrn(gf2State,polynomial2,1);        % PN sequence2
%             code1(ii) = bitxor(bitxor(gf2State(4),gf2State(10)),gf1State(10));
%             code = code1(offset+1:end);
%         end           
    otherwise
        error('Gold code fbMode not implemented');
end
symbol = 2*code - 1;            % Assigning code value

end

% End of function

