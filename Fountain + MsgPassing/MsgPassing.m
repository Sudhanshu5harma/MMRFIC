function output = MsgPassing(sortedmat,gaussian_out)
[mb,nb] = size(sortedmat); %mb=46 nb=68
MaxItrs = 4;
treg = zeros(mb,nb); %register storage for minsum
L = gaussian_out; %total belief
itr = 0; %iteration number
R = zeros(Slen,z); %storage for row processing
while itr < MaxItrs
    Ri = 0;
    for lyr = 1:mb
        ti = 0; %number of non -1 in row=lyr
        for col = find(sortedmat(lyr,:) ~= -1)
            ti = ti + 1;
            Ri = Ri + 1;
            %Subtraction
            L((col-1)*z+1:col*z) = L((col-1)*z+1:col*z)-R(Ri,:);
            %Row alignment and store in treg
            treg(ti,:) = mul_sh(L((col-1)*z+1:col*z),B(lyr,col));
        end
        %minsum on treg: ti x z
        for i1 = 1:z %treg(1:ti,i1)
            [min1,pos] = min(abs(treg(1:ti,i1))); %first minimum
            min2 = min(abs(treg([1:pos-1 pos+1:ti],i1))); %second minimum
            S = sign(treg(1:ti,i1));
            parity = prod(S);
            treg(1:ti,i1) = min1; %absolute value for all
            treg(pos,i1) = min2; %absolute value for min1 position
            treg(1:ti,i1) = parity*S.*treg(1:ti,i1); %assign signs
        end
        %column alignment, addition and store in R
        Ri = Ri - ti; %reset the storage counter
        ti = 0;
        for col = find(sortedmat(lyr,:) ~= -1)
            Ri = Ri + 1;
            ti = ti + 1;
            %Column alignment
            R(Ri,:) = mul_sh(treg(ti,:),z-sortedmat(lyr,col));
            %Addition
            L((col-1)*z+1:col*z) = L((col-1)*z+1:col*z)+R(Ri,:);
        end
    end
    disp(['.................iteration :',num2str(itr), ])
    msg_cap = L(1:k) < 0; %decision
    itr = itr + 1;
end

%Counting errors
Nerrs = sum(msg ~= msg_cap);
if Nerrs > 0
    Nbiterrs = Nbiterrs + Nerrs;
    Nblkerrs = Nblkerrs + 1;
end
end