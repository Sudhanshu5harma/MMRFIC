function out = Msgpassing_v_1(sortedmat,gaussian_out)

MaxItrs = 8;
[col,row]=size(sortedmat);
StorageMatrix = sortedmat;
Update_StorageMatrix =zeros(col,row);
gaussian_out = gaussian_out';
belief = gaussian_out;
itr =0;
while itr < MaxItrs
    %%Decoding
    for i = 1: row
        Update_StorageMatrix(:,i) = gaussian_out(i)*StorageMatrix(:,i);
    end
    %row operations
    % for now I am only using 1 iteration this can be increase
    for col_val = 1:col
        t = (abs(Update_StorageMatrix(col_val,:)));
        min1 = min(t(t>0));
        pos = find(t==min1);
        if pos==1
            r = abs(Update_StorageMatrix(col_val,pos+1:end));
        else
            r = abs(Update_StorageMatrix(col_val,[1:pos-1 pos+1:end]));
        end
        min2 = min(r(r>0));
        S= sign(Update_StorageMatrix(col_val,:));
        overall_parity = prod(S(S~=0));
        Update_StorageMatrix(col_val,:)=min1;
        Update_StorageMatrix(col_val,pos)=min2;
        Update_StorageMatrix(col_val,:)=overall_parity*S.*Update_StorageMatrix(col_val,:);
    end
    for belief_entry = 1:row
        update_belief(belief_entry) = belief(belief_entry) + sum(Update_StorageMatrix(:,belief_entry));
        for col_val1 = 1:col
            if Update_StorageMatrix(col_val1,belief_entry)~=0
                Update_StorageMatrix(col_val1,belief_entry) = update_belief(belief_entry) - Update_StorageMatrix(col_val1,belief_entry);
            end
        end
    end
    itr = itr+1;
end
out = update_belief;
end
