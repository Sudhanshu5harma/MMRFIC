%%---------------------------------------------------------------
%%
%% Program to calculate chelosky decomposition of given matrix_type
%%
%% (C) MMRFIC Technology Pvt. Ltd., Bangalore INDIA
%%---------------------------------------------------------------
%% Version History: (in reverse chronological order please)
%% V0.3   02-Feb-2020    Sudhanshu.S     Back and forward substitution
%% V0.2   26-Sep-2019    Srinivasan.B    Added hermitian generator   
%% V0.1   24-Sep-2019    Srinivasan.B    Created  
%%---------------------------------------------------------------
clc;

tic
n = 4; %% Number of rows and column for the hermitian matrix
A = round((abs(rherm(n)))*10);
%A = ((abs(rherm(n)))*10);
%A = [4 12 16; 12 37 43; 16 43 98];
%A = [4 12 16 20; 12 37 43 54; 16 43 98 112; 20 41 84 156 ];
%A =  [4 12 16 20;12 37 43 54;16 43 98 112;20 54 112 156];
%A =  [4 12 16 20 28;12 37 43 54 64;16 43 98 114 128 ;20 54 114 156 199;28 64 128 199 256]

N = length(A);
D = zeros(N,N);
L = zeros(N,N);

N = length(A);

for i = 1:N
  D(i,i) = A(i,i);
  if (i~= 1)
    for k = 1:i-1
      D(i,i) = D(i,i)-(L(i,k)* L(i,k)' * D(k,k));
    end 
  end 
  for j = i+1:N
    L(j,i) = A(j,i);
    if (i~= 1)
      for k1 = 1:i-1
        L(j,i) = L(j,i) - (L(j,k1)*L(i,k1)*D(k1,k1));
      end 
    end 
    L(j,i) = L(j,i)/D(i,i);
  end 
  L(i,i) = 1;
end 
matching = sum(sum(A-(L*D*L')));
output = L*D*L';
toc