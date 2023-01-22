function [empty_1,empty_2] = sortByResponse_3(data1, data2, bef)

zscore_avg_1 = mean(data1(:,bef+1:end),2);
zscore_avg_2 = mean(data2(:,bef+1:end),2);

[XXX,ii]=sortrows(zscore_avg_1,'Ascend');
r(ii) = 1:length(ii);

empty_1 = zeros(size(data1));
empty_2 = zeros(size(data1));


for j=1:size(data1,1)
    sorted_ind = r(j);
    cell_1 = data1(j,:);
    empty_1(sorted_ind,:)=cell_1;
    
     cell_2 = data2(j,:);
    empty_2(sorted_ind,:)=cell_2;

end
end