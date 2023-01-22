function [empty_1,empty_2,empty_3] = TripleCompare(Data_1_active,Data_2_active,Data_3_active.f1,f2,f3)
firstLick_1 = floor(f1*5);
firstLick_2 = floor(f2*5);
firstLick_3 = floor(f3*5);


bef = 5*60*2;
aft = 5*60*10;



[zscore_1,zscore_norm_1] = zscoredraw(Data_1_active,bef,firstLick_1);
zscore_aligned_1 = alignFirstLick(zscore_1,firstLick_1,bef,aft);

drawHM_aligned(zscore_aligned_1,'zscore',bef,aft);
title('Data1');

[zscore_2,zscore_norm_2] = zscoredraw(Data_2_active,bef,firstLick_2);
zscore_aligned_2 = alignFirstLick(zscore_2,firstLick_2,bef,aft);

drawHM_aligned(zscore_aligned_2,'zscore',bef,aft);
title('Data2');


[zscore_3,zscore_norm_3] = zscoredraw(Data_3_active,bef,firstLick_3);
zscore_aligned_3 = alignFirstLick(zscore_3,firstLick_3,bef,aft);

drawHM_aligned(zscore_aligned_3,'zscore',bef,aft);
title('Data3');


% sort by average
zscore_avg_1 = mean(zscore_aligned_1(:,bef+1:end),2);
zscore_avg_2 = mean(zscore_aligned_2(:,bef+1:end),2);
zscore_avg_3 = mean(zscore_aligned_3(:,bef+1:end),2);

[XXX,ii]=sortrows(zscore_avg_1,'Ascend');
r(ii) = 1:length(ii);

     
empty_1 = zeros(size(zscore_aligned_1));
empty_2 = zeros(size(zscore_aligned_2));
empty_3 = zeros(size(zscore_aligned_3));


for j=1:size(zscore_aligned_1,1)
    sorted_ind = r(j);
    cell_1 = zscore_aligned_1(j,:);
    empty_1(sorted_ind,:)=cell_1;
%     
     cell_2 = zscore_aligned_2(j,:);
    empty_2(sorted_ind,:)=cell_2;
    
    cell_3 = zscore_aligned_3(j,:);
    empty_3(sorted_ind,:)=cell_3;
end
drawHM_aligned(empty_1,'zscore',bef,aft);
title('fasted Dlu');
drawHM_aligned(empty_2,'zscore',bef,aft);
title('fasted Lipid');
drawHM_aligned(empty_3,'zscore',bef,aft);
title('fasted Lglu');
end
