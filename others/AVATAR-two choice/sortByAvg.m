function [sorted] = sortByAvg(data,baseline);
criteria = mean(data(:,baseline+1:end),2);
[E, idx] = sortrows(criteria,'ascend');
sorted = sortrows(data,idx);
