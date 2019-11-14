%% ------------------------------------------------------
%% Program to implement C/A (Coarse Acquisition) code
%%-------------------------------------------------------
%% (c) MMRFIC Technology Private Limited.
%%-------------------------------------------------------
%% Version History (Reverse chronological order please)
%%-------------------------------------------------------
%%  Ver     Date        Author          Comments
%%
%%  0.1     Aug 19     Sudhanshu Sharma   Started
%%    
%%-------------------------------------------------------
%%  Functions used
%%  None
%%-------------------------------------------------------

function g=cacode(sv,fs)
tap=[2 6;
    3 7;
    4 8;
    5 9;
    1 9;
    2 10;
    1 8;
    2 9;
    3 10;
    2 3;
    3 4;
    5 6;
    6 7;
    7 8;
    8 9;
    9 10;
    1 4;
    2 5;
    3 6;
    4 7;
    5 8;
    6 9;
    1 3;
    4 6;
    5 7;
    6 8;
    7 9;
    8 10;
    1 6;
    2 7;
    3 8;
    4 9
    5 10
    4 10
    1 7
    2 8
    4 10];

% G1 LFSR: x^10+x^3+1
s=[0 0 1 0 0 0 0 0 0 1];
n=length(s);
g1=ones(1,n);   %initialization vector for G1
L=2^n-1;

% G2 LFSR: x^10+x^9+x^8+x^6+x^3+x^2+1
t=[0 1 1 0 0 1 0 1 1 1];
q=ones(1,n);    %initialization vector for G2

% generate C/A Code sequences:
tap_sel=tap(1,:);
for inc=1:L
    g2(:,inc)=mod(sum(q(tap_sel),2),2);
    g(:,inc)=mod(g1(n)+g2(:,inc),2);
   g1=[mod(sum(g1.*s),2) g1(1:n-1)];
   q=[mod(sum(q.*t),2) q(1:n-1)];
end
%upsample to desired rate
##if fs~=1
##    %fractional upsampling with zero order hold
##    index=0;
##    for cnt = 1/fs:1/fs:L
##        index=index+1;
##        if ceil(cnt) > L   %traps a floating point error in index
##            gfs(:,index)=g(:,L);
##        else
##            gfs(:,index)=g(:,ceil(cnt));
##        end
##    end 
##    g=gfs;
##end