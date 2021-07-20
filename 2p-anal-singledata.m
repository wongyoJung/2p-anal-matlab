
Data_1_active=[]

%% 
firstLick_1 = floor(260*5);
bef = 2*5*30;
aft = 5*60*10;
%% get z score and draw individual heatplot map 
[zscore_1,zscore_norm_1] = zscoredraw(Data_1_active,bef,firstLick_1);
zscore_aligned_1 = alignFirstLick(zscore_1,firstLick_1,bef,aft);

drawHM_aligned(zscore_aligned_1,'zscore',bef,aft);
title('Data1');

%% sort by avg

zscore_avg_1 = mean(zscore_aligned_1(:,bef+1:end),2);

[XXX,ii]=sortrows(zscore_avg_1,'Ascend');
r(ii) = 1:length(ii);

empty_1 = zeros(size(zscore_aligned_1));

for j=1:size(zscore_aligned_1,1)
    sorted_ind = r(j);
    cell_1 = zscore_aligned_1(j,:);
    empty_1(sorted_ind,:)=cell_1;

end
drawHM_aligned(empty_1,'zscore',bef,aft);
title('G1-5-fed-Lglu-T2');

%% classify by response
inh_color = [0/255 86/255 191/255];
act_color = [255/255, 73/255, 56/255];
no_res_color = [0.5 0.5 0.5];

[ses1_act, ses1_inh, ses1_nores] = getResponsive(empty_1,bef);

drawpie(ses1_act,ses1_inh,ses1_nores);

if(length(ses1_act))
    avgplot(ses1_act,act_color,bef)
end
if(length(ses1_inh))
    avgplot(ses1_inh,inh_color,bef)
end
if(length(ses1_nores))
    avgplot(ses1_nores,no_res_color,bef)
end
 

