function [empty_1,empty_2] = sortByResponse_ascend(Data_SO, Data_SA,bef)

zscore_avg_1 = mean(Data_SO(:,bef+1:end),2);
zscore_avg_2 = mean(Data_SA(:,bef+1:end),2);

[XXX,ii]=sortrows(zscore_avg_1,'descend');
r(ii) = 1:length(ii);

empty_1 = zeros(size(Data_SO));
empty_2 = zeros(size(Data_SO));


for j=1:size(Data_SO,1)
    sorted_ind = r(j);
    cell_1 = Data_SO(j,:);
    empty_1(sorted_ind,:)=cell_1;
    
     cell_2 = Data_SA(j,:);
    empty_2(sorted_ind,:)=cell_2;
end
end