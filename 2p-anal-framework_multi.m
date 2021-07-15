%%
% active cell list from python code
% Data_1 : SO . Data_2 : SA


% firstLick, bef, aft should be in frame (hz)
firstLick_1 = floor(180*5);
firstLick_2 = floor(300*5);

% bef = 3*60*5;
bef = 1*5*30;
aft = 5*60*10;
% aft = 5*60*5; .
Data_1_active=[]
Data_2_active=[]

%% pick common active cells

% 
% for k=1:length(match)
%     i = match(k);
%     cell1 = activelist(1,:);
%     cell2 = activelist(2,:);
%     cell1_ind = find(cell1==i);
%     cell2_ind = find(cell2==i);
% 
%     cell1_active = Data_1(cell1_ind,:);
%     Data_1_active = [Data_1_active; cell1_active];
% 
%     cell2_active = Data_2(cell2_ind,:);
%     Data_2_active = [Data_2_active; cell2_active]; 
% end


[zscore_1,zscore_norm_1] = zscoredraw(Data_1_active,bef,firstLick_1);
zscore_aligned_1 = alignFirstLick(zscore_1,firstLick_1,bef,aft);

drawHM_aligned(zscore_aligned_1,'zscore',bef,aft);
title('Data1');

[zscore_2,zscore_norm_2] = zscoredraw(Data_2_active,bef,firstLick_2);
zscore_aligned_2 = alignFirstLick(zscore_2,firstLick_2,bef,aft);


drawHM_aligned(zscore_aligned_2,'zscore',bef,aft);
title('Data2');

%% divide into k means

[zscore_aligned_1_sorted,clust1_1,clust2_1,clust3_1,idx_1] = sortKmeans_multi(zscore_aligned_1,bef);

clust1 = [];
clust2 = [];
clust3 = [];
for k=1:size(zscore_aligned_2,1)
    if(idx_1(k)==1)
%         clust1=[clust1; zscores_integrated(k,:)];
        clust1=[clust1; zscore_aligned_2(k,:)];
    elseif(idx_1(k)==2)
%         clust2=[clust2; zscores_integrated(k,:)];
        clust2=[clust2; zscore_aligned_2(k,:)];
    elseif(idx_1(k)==3)
%         clust3=[clust3; zscores_integrated(k,:)];
        clust3=[clust3; zscore_aligned_2(k,:)];
    end
end

sorted = [clust1; clust2; clust3];

drawHM_aligned(zscore_aligned_1_sorted,'zscore',bef,aft);
title('Data1');
drawHM_aligned(sorted,'zscore',bef,aft);
title('Data2');


%% divide by average
avgs_1=[]
for c = 1:size(zscore_aligned_1_sorted,1)
    cell = zscore_aligned_1_sorted(c,:);
    res = cell(bef:end);
    res_mean = mean(res);
%     avgs_1=[avgs_1 ;res_mean];
    if(res_mean<-1)
        avgs_1=[avgs_1;-1];
    elseif(res_mean>1)
       avgs_1=[avgs_1;1];
    else
       avgs_1=[avgs_1;0];
    end
end

avgs_2=[]
for c = 1:size(sorted,1)
    cell = sorted(c,:);
    res = cell(bef:end);
    res_mean = mean(res);
%     avgs_1=[avgs_1 ;res_mean];
    if(res_mean<-1)
        avgs_2=[avgs_2;-1];
    elseif(res_mean>1)
       avgs_2=[avgs_2;1];
    else
       avgs_2=[avgs_2;0];
    end
end

figure; imagesc(avgs_1); caxis([-1 1]); colorbar
figure; imagesc(avgs_2); caxis([-1 1]);

drawHM_aligned(zscore_aligned_1_sorted_avg,'zscore',bef,aft);
title('Data1');
drawHM_aligned(sorted,'zscore',bef,aft);
title('Data2');

%% draw averageplot
inh_color = [0/255 86/255 191/255];
act_color = [255/255, 73/255, 56/255];
no_res_color = [0.5 0.5 0.5];
figure;
avgplot_2(clust1_1,no_res_color,bef)
hold on
avgplot_2(clust2_1,act_color,bef)
hold on
avgplot_2(clust3_1,inh_color,bef)

figure;
avgplot_2(clust1,no_res_color,bef)
hold on
avgplot_2(clust2,act_color,bef)
hold on
avgplot_2(clust3,inh_color,bef)

[clust_act,clust_inh,clust_no_res] = responsiveCell(zscore_aligned_1,bef,aft);
if(length(clust_act))
    avgplot(clust_act,act_color,bef)
end
if(length(clust_inh))
    avgplot(clust_inh,inh_color,bef)
end
if(length(clust_no_res))
    avgplot(clust_no_res,no_res_color,bef)
end

avgplot(Data_1_active,act_color,bef);
%% draw pie chart
drawpie(clust_act,clust_inh,clust_no_res);


%% sort by average
zscore_avg_1 = mean(zscore_aligned_1(:,bef+1:end),2);
zscore_avg_2 = mean(zscore_aligned_2(:,bef+1:end),2);

[XXX,ii]=sortrows(zscore_avg_1,'Ascend');
r(ii) = 1:length(ii);

     
empty_1 = zeros(size(zscore_aligned_1));
empty_2 = zeros(size(zscore_aligned_2));


for j=1:size(zscore_aligned_1,1)
    sorted_ind = r(j);
    cell_1 = zscore_aligned_1(j,:);
    empty_1(sorted_ind,:)=cell_1;
%     
     cell_2 = zscore_aligned_2(j,:);
    empty_2(sorted_ind,:)=cell_2;
end
drawHM_aligned(empty_1,'zscore',bef,aft);
title('G1-5-fed-Lglu-T');
drawHM_aligned(empty_2,'zscore',bef,aft);
title('T2');


%% classify inh/act/nores
clust_1_act=[];
clust_1_inh=[];
clust_1_nores=[];
clust_2_act=[];
clust_2_inh=[];
clust_2_nores=[];

clust_2_act_match=[];
clust_2_inh_match=[];
clust_2_nores_match=[];



inh_color = [0/255 86/255 191/255];
act_color = [255/255, 73/255, 56/255];
no_res_color = [0.5 0.5 0.5];

for k=1:size(zscore_aligned_1,1)
    cell = zscore_aligned_1(k,:);
    cell2 = zscore_aligned_2(k,:);

        
    res = cell(:,bef:end);
    m = mean(res);
    if(m>1)
        clust_1_act=[clust_1_act; cell];
        clust_2_act_match=[clust_2_act_match;cell2 ];
        
    elseif(m<-1)
        clust_1_inh=[clust_1_inh; cell];
        clust_2_inh_match=[ clust_2_inh_match; cell2];

    else
        clust_1_nores=[clust_1_nores; cell];
        clust_2_nores_match=[clust_2_nores_match; cell2];

        
    end
end


avgplot(clust_1_act,act_color,bef);
avgplot(clust_1_inh,inh_color,bef);
avgplot(clust_1_nores,no_res_color,bef);

drawpie(clust_1_act,clust_1_inh,clust_1_nores);

[ses2_act, ses2_inh, ses2_nores] = getResponsive(empty_2,bef);
drawpie(ses2_act,ses2_inh,ses2_nores);
avgplot(ses2_act,act_color,bef);
avgplot(ses2_inh,inh_color,bef);
avgplot(ses2_nores,no_res_color,bef);




avgplot(clust_2_act_match,act_color,bef);
avgplot(clust_2_inh_match,inh_color,bef);
avgplot(clust_2_nores_match,no_res_color,bef);

% show distributions of act/inh/no res clusters from session 1 in session 2
[ses1Inh_ses2_act, ses1Inh_ses2_inh, ses1Inh_ses2_nores] = getResponsive(clust_2_inh_match,bef);
drawpie(ses1Inh_ses2_act,ses1Inh_ses2_inh,ses1Inh_ses2_nores);

[ses1Act_ses2_act, ses1Act_ses2_inh, ses1Act_ses2_nores] = getResponsive(clust_2_act_match,bef);
drawpie(ses1Act_ses2_act,ses1Act_ses2_inh,ses1Act_ses2_nores);

[ses1Nores_ses2_act, ses1Nores_ses2_inh, ses1Nores_ses2_nores] = getResponsive(clust_2_nores_match,bef);
drawpie(ses1Nores_ses2_act,ses1Nores_ses2_inh,ses1Nores_ses2_nores);



[ses2_act, ses2_inh, ses2_nores] = getResponsive(empty_1,bef);
if(length(ses2_act))
    avgplot(ses2_act,act_color,bef)
end
if(length(ses2_inh))
    avgplot(ses2_inh,inh_color,bef)
end
if(length(ses2_nores))
    avgplot(ses2_nores,no_res_color,bef)
end


drawpie(ses2_act, ses2_inh, ses2_nores);



%% 
comparison=[]
comp_1=[]
comp_2=[]
for x=1:size(zscore_aligned_1,1)
    rowcell = zscore_aligned_1(x,:);
    baseline = rowcell(1:bef);
    res = rowcell(bef+1:aft);
    mu = mean(baseline);
    sig = std(baseline);
    meanZ = mean((res-mu)/sig);
   
     rowcell_2 = zscore_aligned_2(x,:);
    baseline_2 = rowcell_2(1:bef);
    res_2 = rowcell_2(bef+1:aft);
    mu_2 = mean(baseline_2);
    sig_2 = std(baseline_2);
    meanZ_2 = mean((res_2-mu_2)/sig_2);
       comp_1=[comp_1; meanZ];
    comp_2=[comp_2; meanZ_2];

    comp = [meanZ meanZ_2];
    comparison=[comparison; comp];
end
figure;
 scatter(comp_1,comp_2,'k')
 xlabel("fasted D glucose ");
 ylabel("fasted lipid ");
 
 
 x = comp_1;
 y = comp_2;
  b1 = x\y
 yCalc1 = b1*x;
scatter(x,y)
hold on
plot(x,yCalc1)
xlabel('Population of state')
ylabel('Fatal traffic accidents per state')
title('Linear Regression Relation Between Accidents & Population')
grid on



