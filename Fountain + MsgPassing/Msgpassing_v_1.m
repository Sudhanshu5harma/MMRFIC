function out = Msgpassing_v_1(sortedmat,gaussian_out)

MaxItrs = 2;
[col,row]=size(sortedmat);
Update_StorageMatrix = double(sortedmat);
update_belief = gaussian_out';
itr =0;
while itr < MaxItrs
    %%Decoding
    belief = update_belief;
    for i = 1: row
        Update_StorageMatrix(:,i) = update_belief(i)*(abs(Update_StorageMatrix(:,i))>0);
    end
    %row operations
    % for now I am only using 1 iteration this can be increase
    for col_val = 1:col
        t = (abs(Update_StorageMatrix(col_val,:)));
        min1 = min(t(t>0));
        if (isempty(min1))
            min1 = 0;
            min2 = min1;
        else
            pos = find(t==min1);
            if pos==1
                r = abs(Update_StorageMatrix(col_val,pos+1:end));
            else
                r = abs(Update_StorageMatrix(col_val,[1:pos-1 pos+1:end]));
            end
            if isempty(find(abs(r)>0, 1))
                min2 = min1;
            else
                min2 = min(r(r>0));
            end
        end
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
out = (update_belief);
end
