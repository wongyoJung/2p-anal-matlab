function [cluster_accuracies] = svmDecoderTimebin_clust(data1,data2,bef,window)
[data1_clust1,data1_clust2, data1_clust3, data1_clust4,data2_clust1,data2_clust2, data2_clust3, data2_clust4 ] = getResponsiveSort_woFig(data1,data2,bef);

if(~isempty(data1_clust1) && ~isempty(data2_clust1))
% acc_clust1 = mean(svmDecoderTimebin(data1_clust1,data2_clust1,window));
acc_clust1 = svmDecoderTimebin(data1_clust1,data2_clust1,window);
% acc_clust1 = svmDecoderTimebin_whole(d1,d2);

else
acc_clust1 = zeros(120,1);
end

if(~isempty(data1_clust2) && ~isempty(data2_clust2))
% acc_clust2 = mean(svmDecoderTimebin(data1_clust2,data2_clust2,window));
acc_clust2 = svmDecoderTimebin(data1_clust2,data2_clust2,window);
% acc_clust2 = svmDecoderTimebin_whole(d1,d2);

else
acc_clust2 = zeros(120,1);
end

if(~isempty(data1_clust3) && ~isempty(data2_clust3))
% acc_clust3 = mean(svmDecoderTimebin(data1_clust3,data2_clust3,window));
acc_clust3 = svmDecoderTimebin(data1_clust3,data2_clust3,window);
% acc_clust3 = svmDecoderTimebin_whole(d1,d2);

else
acc_clust3 = zeros(120,1);
end

if(~isempty(data1_clust4) && ~isempty(data2_clust4))
% acc_clust4 = mean(svmDecoderTimebin(data1_clust4,data2_clust4,window));
acc_clust4 = svmDecoderTimebin(data1_clust4,data2_clust4,window);
% acc_clust4 = svmDecoderTimebin_whole(d1,d2);
else
acc_clust4 =zeros(120,1);
end
% cluser_accuracies= [acc_clust1 acc_clust2 acc_clust3 acc_clust4];
cluster_accuracies(:,1) = acc_clust1;
cluster_accuracies(:,2) = acc_clust2;
cluster_accuracies(:,3) = acc_clust3;
cluster_accuracies(:,4) = acc_clust4;

end
