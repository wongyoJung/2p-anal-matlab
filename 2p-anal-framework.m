%%
% active cell list from python code
active_list = []
% firstLick, bef, aft should be in frame (hz)
firstLick = floor(303.36556*5);
bef = 2*60*5;
aft = 10*60*5;

[zscore,zscore_norm] = zscoredraw(Data,bef,firstLick);
zscore_aligned = alignFirstLick(zscore,firstLick,bef,aft);

%% individual cell heatmap plot

% if want to sort by  average
% zscore_aligned_sort = sortByAvg(zscore_aligned,bef);
% if want to sort by k-means
zscore_aligned_sort = sortKmeans(zscore_aligned,bef);
drawHM_aligned(zscore_aligned_sort,'zscore',bef,aft);
title('zscore-aligned to first lick');

% not aligned to the first lick
% not normalized
% zscore_raw_sort = sortByAvg(zscore_raw,bef);
zscore_raw_sort = sortKmeans(zscore,firstLick);
drawHM_raw(zscore_raw_sort,firstLick,'zscore',false);
title('individual cell zscore');

% normalized
zscore_raw_norm_sort = sortKmeans(zscore_norm,firstLick);
drawHM_raw(zscore_raw_norm_sort,firstLick,'normalized zscore',true);
title('individual cell normalized zscore');


%% draw averageplot
inh_color = [0/255 86/255 191/255];
act_color = [255/255, 73/255, 56/255];
no_res_color = [0.5 0.5 0.5];

[clust_act,clust_inh,clust_no_res] = responsiveCell(zscore_aligned,bef,aft);
if(length(clust_act))
    avgplot(clust_act,act_color,bef)
end
if(length(clust_inh))
    avgplot(clust_inh,inh_color,bef)
end
if(length(clust_no_res))
    avgplot(clust_no_res,no_res_color,bef)
end

%% draw pie chart
drawpie(clust_act,clust_inh,clust_no_res);

