function [cluser_accuracies] = svmDecoderTimebin_clust_wo(data1,data2,bef,window)
[data1_clust1,data1_clust2, data1_clust3, data1_clust4,data2_clust1,data2_clust2, data2_clust3, data2_clust4 ] = getResponsiveSort_woFig(data1,data2,bef);

d1 = [data1_clust2; data1_clust3; data1_clust4];
d2 = [data2_clust2; data2_clust3; data2_clust4];

if(~isempty(data1_clust1) && ~isempty(data2_clust1))
acc_clust1 = mean(svmDecoderTimebin(d1,d2,window));
else
acc_clust1 = -1;
end


d1 = [data1_clust1; data1_clust3; data1_clust4];
d2 = [data2_clust1; data2_clust3; data2_clust4];

if(~isempty(data1_clust2) && ~isempty(data2_clust2))
acc_clust2 = mean(svmDecoderTimebin(d1,d2,window));
else
acc_clust2 = -1;
end


d1 = [data1_clust1; data1_clust2; data1_clust4];
d2 = [data2_clust1; data2_clust2; data2_clust4];

if(~isempty(data1_clust3) && ~isempty(data2_clust3))
acc_clust3 = mean(svmDecoderTimebin(d1,d2,window));
else
acc_clust3 = -1;
end

d1 = [data1_clust1; data1_clust2; data1_clust3];
d2 = [data2_clust1; data2_clust2; data2_clust3];


if(~isempty(data1_clust4) && ~isempty(data2_clust4))
acc_clust4 = mean(svmDecoderTimebin(d1,d2,window));
else
acc_clust4 = -1;
end
cluser_accuracies= [acc_clust1 acc_clust2 acc_clust3 acc_clust4];
end
