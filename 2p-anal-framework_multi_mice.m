%%
% active cell list from python code
% Data_1 : SO . Data_2 : SA

Data_1=[]
Data_2=[]
Data_3=[]
Data_4=[]
Data_5=[]
Data_6=[]


% firstLick, bef, aft should be in frame (hz)
firstlicks=[]


% bef = 3*60*5;
bef = 2*30*5;
aft = 10*60*5;
% aft = 5*60*5;

%% pick common active cells
firstLicks=floor(firstlicks*5);

[zscore_1,zscore_norm_1] = zscoredraw(Data_1,bef,firstLicks(1));
zscore_aligned_1 = alignFirstLick(zscore_1,firstLicks(1),bef,aft);

[zscore_2,zscore_norm_2] = zscoredraw(Data_2,bef,firstLicks(2));
zscore_aligned_2 = alignFirstLick(zscore_2,firstLicks(2),bef,aft);

[zscore_3,zscore_norm_3] = zscoredraw(Data_3,bef,firstLicks(3));
zscore_aligned_3 = alignFirstLick(zscore_3,firstLicks(3),bef,aft);

[zscore_4,zscore_norm_4] = zscoredraw(Data_4,bef,firstLicks(4));
zscore_aligned_4 = alignFirstLick(zscore_4,firstLicks(4),bef,aft);

[zscore_5,zscore_norm_5] = zscoredraw(Data_5,bef,firstLicks(5));
zscore_aligned_5 = alignFirstLick(zscore_5,firstLicks(5),bef,aft);

[zscore_6,zscore_norm_1] = zscoredraw(Data_6,bef,firstLicks(6));
zscore_aligned_6 = alignFirstLick(zscore_6,firstLicks(6),bef,aft);



Data_SO = [zscore_aligned_1; zscore_aligned_3; zscore_aligned_5];
Data_SA = [zscore_aligned_2; zscore_aligned_4; zscore_aligned_6];

drawHM_aligned(Data_SA,'zscore',bef,aft);
title('SA');

drawHM_aligned(Data_SO,'zscore',bef,aft);
title('SO');





%% pick common active cells (norm)
firstLicks=floor(firstlicks*5);

[zscore_1,zscore_norm_1] = zscoredraw(Data_1,bef,firstLicks(1));
zscore_aligned_1 = alignFirstLick(zscore_norm_1,firstLicks(1),bef,aft);

[zscore_2,zscore_norm_2] = zscoredraw(Data_2,bef,firstLicks(2));
zscore_aligned_2 = alignFirstLick(zscore_norm_2,firstLicks(2),bef,aft);

[zscore_3,zscore_norm_3] = zscoredraw(Data_3,bef,firstLicks(3));
zscore_aligned_3 = alignFirstLick(zscore_norm_3,firstLicks(3),bef,aft);

[zscore_4,zscore_norm_4] = zscoredraw(Data_4,bef,firstLicks(4));
zscore_aligned_4 = alignFirstLick(zscore_norm_4,firstLicks(4),bef,aft);

[zscore_5,zscore_norm_5] = zscoredraw(Data_5,bef,firstLicks(5));
zscore_aligned_5 = alignFirstLick(zscore_norm_5,firstLicks(5),bef,aft);

[zscore_6,zscore_norm_6] = zscoredraw(Data_6,bef,firstLicks(6));
zscore_aligned_6 = alignFirstLick(zscore_norm_6,firstLicks(6),bef,aft);



Data_SO = [zscore_aligned_1; zscore_aligned_3; zscore_aligned_5];
Data_SA = [zscore_aligned_2; zscore_aligned_4; zscore_aligned_6];

drawHM_aligned(Data_SA,'zscore',bef,aft);
title('SA');

drawHM_aligned(Data_SO,'zscore',bef,aft);
title('SO');

%% divide into k means

[zscore_aligned_1_sorted,clust1_1,clust2_1,clust3_1,idx_1] = sortKmeans_multi(Data_SO,bef);
sorted=[];
clust1_2 = [];
clust2_2 = [];
clust3_2 = [];
for k=1:size(Data_SA,1)
    if(idx_1(k)==1)
%         clust1=[clust1; zscores_integrated(k,:)];
        clust1_2=[clust1_2; Data_SA(k,:)];
    elseif(idx_1(k)==2)
%         clust2=[clust2; zscores_integrated(k,:)];
        clust2_2=[clust2_2; Data_SA(k,:)];
    elseif(idx_1(k)==3)
%         clust3=[clust3; zscores_integrated(k,:)];
        clust3_2=[clust3_2; Data_SA(k,:)];
    end
end

sorted = [clust1_2; clust2_2; clust3_2];

drawHM_aligned(zscore_aligned_1_sorted,'zscore',bef,aft);
title('Data1');
drawHM_aligned(sorted,'zscore',bef,aft);
title('Data2');

%% sort by average
zscore_avg_1 = mean(Data_SO(:,bef+1:end),2);
zscore_avg_2 = mean(Data_SA(:,bef+1:end),2);

[XXX,ii]=sortrows(zscore_avg_1,'Ascend');
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
drawHM_aligned(empty_1,'zscore',bef,aft);
title('SO');
drawHM_aligned(empty_2,'zscore',bef,aft);
title('SA');

%% compare two sessions
comparison=[]
comp_SO=[]
comp_SA=[]
for x=1:size(Data_SO,1)
    rowcell = Data_SO(x,:);
    baseline = rowcell(1:bef);
    res = rowcell(bef+1:aft);
    mu = mean(baseline);
    sig = std(baseline);
    meanZ = mean((res-mu)/sig);
   
     rowcell_SA = Data_SA(x,:);
    baseline_SA = rowcell_SA(1:bef);
    res_SA = rowcell_SA(bef+1:aft);
    mu_SA = mean(baseline_SA);
    sig_SA = std(baseline_SA);
    meanZ_SA = mean((res_SA-mu_SA)/sig_SA);
       comp_SO=[comp_SO; meanZ];
    comp_SA=[comp_SA; meanZ_SA];

    comp = [meanZ meanZ_SA];
    comparison=[comparison; comp];
end
 %  
b1 = comp_SO\comp_SA;
yCalc1 = b1*comp_SO;
figure;
 scatter(comp_SO,comp_SA,'k')
 xlabel("sucrose");
 ylabel("sucralose");
% 
hold on
plot(comp_SO,yCalc1)
Rsq1 = 1 - sum((comp_SA - yCalc1).^2)/sum((comp_SA - mean(comp_SA)).^2)

%% scatter plot 
comparison=[]
comp_SO=[]
comp_SA=[]
for x=1:size(Data_SO,1)
    rowcell = Data_SO(x,:);
    baseline = rowcell(1:bef);
    res = rowcell(bef+1:aft);
    mu = mean(baseline);
    sig = std(baseline);
    meanZ = mean((res-mu)/sig);
   
     rowcell_SA = Data_SA(x,:);
    baseline_SA = rowcell_SA(1:bef);
    res_SA = rowcell_SA(bef+1:aft);
    mu_SA = mean(baseline_SA);
    sig_SA = std(baseline_SA);
    meanZ_SA = mean((res_SA-mu_SA)/sig_SA);
       comp_SO=[comp_SO; meanZ];
    comp_SA=[comp_SA; meanZ_SA];

    comp = [meanZ meanZ_SA];
    comparison=[comparison; comp];
end
figure;
x = comp_SO;
y = comp_SA;
inh_idx =  find(x<-1);

x=x(inh_idx);
y=y(inh_idx);
X = [ones(length(x),1) x];

b = X\y;
yCalc2 = X*b;
figure;

plot(x,yCalc2,'--')
hold on;
scatter(comp_SO,comp_SA,'k');
hold on;
scatter(x,y,'red')

 xlabel("sucrose");
 ylabel("sucralose");

%% sort by peak time
% normalize zscore
zscore_aligned_1_norm=[];
for x=1:size(Data_SO,1)
    rowcell = Data_SO(x,:);
    baseline = rowcell(1:bef);
    mu = mean(baseline);
    sig = std(baseline);
    normZ = (rowcell-mu)/sig;
    zscore_aligned_1_norm = [zscore_aligned_1_norm; normZ];
end

[zscore_min_1,zscore_min_1_ind] = min(zscore_aligned_1_norm(:,bef:end),[],2);
zscore_avg_2 = mean(Data_SA(:,bef+1:end),2);

[XXX,ii]=sortrows(zscore_min_1_ind,'Ascend');
r(ii) = 1:length(ii);

     
empty_1 = zeros(size(Data_SO));
empty_2 = zeros(size(Data_SA));


for j=1:size(Data_SO,1)
    sorted_ind = r(j);
    cell_1 = Data_SO(j,:);
    empty_1(sorted_ind,:)=cell_1;
    
     cell_2 = Data_SA(j,:);
    empty_2(sorted_ind,:)=cell_2;  
end
drawHM_aligned(empty_1,'zscore',bef,aft);
title('SO');
drawHM_aligned(empty_2,'zscore',bef,aft);
title('SA');

%% autocorrelation
autos=[];
for h=1:size(empty_1,1)
    roww = empty_1(h,bef+1:end);
    auto = autocorr(roww,'NumLags',aft);
    autos=[autos;auto];
end
figure;
tt = 1:size(autos,2);
shadedErrorBar(tt,mean(autos,1),std(autos,1,1));
ylim([0 1]);

% data_mean = mean(autos,1);                           % Mean Across Columns
% data_SEM = std(autos,[],1)/sqrt(size(autos,1));       % SEM Across Columns
% figure()
% errorbar(tt, data_mean, data_SEM)
% grid
% axis([-130  0    ylim])



%% divide by average
SO_inh=[]
SO_act=[]
SO_nores=[]

SO_inh_match=[]
SO_act_match=[]
SO_nores_match=[]



SA_inh=[]
SA_act=[]
SA_nores=[]


for c = 1:size(Data_SO,1)
    cell = Data_SO(c,:);
    cell_match = Data_SA(c,:);
    res = cell(bef:end);
    res_mean = mean(res);
    if(res_mean<-2)
        SO_inh=[SO_inh;cell];
        SO_inh_match=[SO_inh_match;cell_match];
        
    elseif(res_mean>2)
       SO_act=[SO_act;cell];
       SO_act_match=[SO_act_match;cell_match];
 
    else
        SO_nores=[SO_nores;cell];
        SO_nores_match=[SO_nores_match;cell_match];

    end
end


for c = 1:size(Data_SA,1)
    cell = Data_SA(c,:);
    res = cell(bef:end);
    res_mean = mean(res);
    if(res_mean<-2)
        SA_inh=[SA_inh;cell];
    elseif(res_mean>2)
       SA_act=[SA_act;cell];
    else
        SA_nores=[SA_nores;cell];
    end
end

inh_color = [0/255 86/255 191/255];
act_color = [255/255, 73/255, 56/255];
no_res_color = [0.5 0.5 0.5];
figure;
avgplot(SO_inh,inh_color,bef)
avgplot(SO_act,act_color,bef)
avgplot(SO_nores,no_res_color,bef)

avgplot(SO_inh_match,inh_color,bef)
avgplot(SO_act_match,act_color,bef)
avgplot(SO_nores_match,no_res_color,bef)

avgplot(SA_inh,inh_color,bef)
avgplot(SA_act,act_color,bef)
avgplot(SA_nores,no_res_color,bef)

drawpie(SO_act,SO_inh,SO_nores);
drawpie(SA_act,SA_inh,SA_nores);

avgplot(Data_SO,no_res_color,bef)
avgplot(Data_SA,no_res_color,bef)




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
avgplot_2(clust1_2,no_res_color,bef)
hold on
avgplot_2(clust2_2,act_color,bef)
hold on
avgplot_2(clust3_2,inh_color,bef)

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

%% draw pie chart
drawpie(clust_act,clust_inh,clust_no_res);

%% normalize
X = [Data_SO;  Data_SA];
norm_X=[];
for c = 1:size(X,1)
    cell = X(c,:);	
    base = cell(1:bef);
    responsive = cell(bef:end);
    mu = mean(base);
    sig = std(base);
    norm = (responsive-mu)/sig;
    norm_X = [norm_X; norm];
end

%% GLM 
SO = zeros(1,size(Data_SO,1))+1; 
SA = zeros(1,size(Data_SO,1)); 
Y = [SO  SA] ;
XX = norm_X';
YY = Y';
[b dev] = glmfit(norm_X,YY,'binomial','link','logit')
% yfit = glmval(b,norm_X);
yfit = glmval(b,norm_X,'logit' );
figure;
plot(YY,'o');
figure;
plot(yfit,'o');

plot(norm_X, YY,'o',norm_X,yfit,'-','LineWidth',2)

plot(norm_X,yfit,'-','LineWidth',2)



%% PCA
[coeff,score,latent,tsquared,explained,mu] = pca(norm_X);
plot(explained);
cumexp = 0;
id=1;
while(cumexp<90);
   cumexp = cumexp+explained(id);
   id=id+1
end
pc3= coeff(:,1:3);
s = size(norm_X,1);
SO_norm_X=norm_X(1:s/2,:);
SA_norm_X=norm_X(s/2:s,:);


Y_SO = SO_norm_X*pc3;
Y_SA = SA_norm_X*pc3;


scatter3(Y_SO(:,1),Y_SO(:,2),Y_SO(:,3),'red')
hold on;
scatter3(Y_SA(:,1),Y_SA(:,2),Y_SA(:,3),'blue')

%% T-SNE
figure;
Y_tsne = tsne(norm_X);
gscatter(Y_tsne(:,1),Y_tsne(:,2),Y)

%% classifier using decoder
Data_mice_1 = [zscore_aligned_1; zscore_aligned_2];
y_label_1 = [ones(1,size(zscore_aligned_1,1)) zeros(1,size(zscore_aligned_2,1))];
res_1 = Data_mice_1(:,bef:end);
Data_mice_1_label=[res_1'; y_label_1];

Data_mice_2 = [zscore_aligned_3; zscore_aligned_4];
y_label_2 = [ones(1,size(zscore_aligned_3,1)) zeros(1,size(zscore_aligned_4,1))];
res_2 = Data_mice_2(:,bef:end);
Data_mice_2_label=[res_2'; y_label_2];

Data_mice_3 = [zscore_aligned_5; zscore_aligned_6];
y_label_3 = [ones(1,size(zscore_aligned_5,1)) zeros(1,size(zscore_aligned_6,1))];
res_3 = Data_mice_3(:,bef:end);
Data_mice_3_label=[res_3'; y_label_3];



% shuffled data
y_label_shuffle_id = randsample(size(zscore_aligned_1,1)+size(zscore_aligned_2,1),size(zscore_aligned_1,1));
z = zeros(1,size(zscore_aligned_1,1)+size(zscore_aligned_2,1));
z(y_label_shuffle_id)=1;
Data_mice_1_shuffled =[res_1'; z];

y_label_shuffle_id = randsample(size(zscore_aligned_3,1)+size(zscore_aligned_4,1),size(zscore_aligned_4,1));
z = zeros(1,size(zscore_aligned_3,1)+size(zscore_aligned_4,1));
z(y_label_shuffle_id)=1;

Data_mice_2_shuffled =[res_2'; z];

y_label_shuffle_id = randsample(size(zscore_aligned_5,1)+size(zscore_aligned_6,1),size(zscore_aligned_6,1));
z = zeros(1,size(zscore_aligned_5,1)+size(zscore_aligned_6,1));
z(y_label_shuffle_id)=1;

Data_mice_3_shuffled =[res_3'; z];


