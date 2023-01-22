function [data1_clust1,data1_clust2, data1_clust3, data1_clust4,data2_clust1,data2_clust2, data2_clust3, data2_clust4 ] = getResponsiveSort(data1,data2,bef)

% clust 1 : data1 inh and data2 activated
% clust2 : data1 inh and data2 not act
% clust 3: data 1 not inh and data2 act
% clust 4: data1 not inh and data2 not act

res1 = mean(data1(:,bef:end),2);
res2 = mean(data2(:,bef:end),2);

clust1_idx = find(res1<=-1 & res2>=1);
clust2_idx = find(res1<=-1 & res2<1);
clust3_idx = find(res1>-1 & res2>=1);
clust4_idx = find(res1>-1 & res2<1);
% 
% data1_clust1 = mean(data1(clust1_idx,bef:bef+10*5*60),2);
% data1_clust2 = mean(data1(clust2_idx,bef:bef+10*5*60),2);
% data1_clust3 = mean(data1(clust3_idx,bef:bef+10*5*60),2);
% data1_clust4 = mean(data1(clust4_idx,bef:bef+10*5*60),2);
% 
% data2_clust1 = mean(data2(clust1_idx,bef:bef+10*5*60),2);
% data2_clust2 = mean(data2(clust2_idx,bef:bef+10*5*60),2);
% data2_clust3 = mean(data2(clust3_idx,bef:bef+10*5*60),2);
% data2_clust4 = mean(data2(clust4_idx,bef:bef+10*5*60),2);


data1_clust1 = data1(clust1_idx,bef:bef+10*5*60);
data1_clust2 = data1(clust2_idx,bef:bef+10*5*60);
data1_clust3 = data1(clust3_idx,bef:bef+10*5*60);
data1_clust4 = data1(clust4_idx,bef:bef+10*5*60);

data2_clust1 = data2(clust1_idx,bef:bef+10*5*60),2;
data2_clust2 = data2(clust2_idx,bef:bef+10*5*60),2;
data2_clust3 = data2(clust3_idx,bef:bef+10*5*60),2;
data2_clust4 = data2(clust4_idx,bef:bef+10*5*60),2;

%% draw pie
population = [size(clust1_idx,1); size(clust2_idx,1); size(clust3_idx,1); size(clust4_idx,1)];
total = sum(population);

clust1 = sprintf('clust1 (%d)',floor(population(1)));
clust2 = sprintf('clust2 (%d)',floor(population(2)));
clust3 = sprintf('clust3 (%d)',floor(population(3)));
clust4 = sprintf('clust4 (%d)',floor(population(4)));


figure;
labels={clust1, clust2, clust3, clust4};
p = pie(population,labels);
patchHand = findobj(p, 'Type', 'Patch'); 
% Set the color of all patches using the nx3 newColors matrix
% Or set the color of a single wedge
clust1_color = [107 173 37]/255;
clust2_color = [49 96 235]/255;
clust3_color = [173 25 26]/255;
clust4_color = [173 173 173]/255;
patchHand(1).FaceColor = clust1_color;
patchHand(2).FaceColor = clust2_color;
patchHand(3).FaceColor = clust3_color;
patchHand(4).FaceColor = clust4_color;

%% plot
inh_color = [0/255 86/255 191/255];
act_color = [183/255, 51/255, 21/255];
no_res_color = [0.5 0.5 0.5];

figure;
avgplot_2(data1(clust1_idx,:),inh_color,bef);
hold on;
avgplot_2(data2(clust1_idx,:),act_color,bef);
title('cluster1');

figure;
avgplot_2(data1(clust2_idx,:),inh_color,bef);
hold on;
avgplot_2(data2(clust2_idx,:),act_color,bef);
title('cluster2');

figure;
avgplot_2(data1(clust3_idx,:),inh_color,bef);
hold on;
avgplot_2(data2(clust3_idx,:),act_color,bef);
title('cluster3')

figure;
avgplot_2(data1(clust4_idx,:),inh_color,bef);
hold on;
avgplot_2(data2(clust4_idx,:),act_color,bef);
title('cluster4')



end
