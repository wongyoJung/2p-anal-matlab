%%
% active cell list from python code
% Data_1 : SO . Data_2 : SA

Data_1=[]
Data_2=[]
Data_3=[]
Data_4=[]
Data_5=[]
Data_6=[]
Data_7=[]
Data_8=[]
Data_9=[]
Data_10=[]

% firstLick, bef, aft should be in frame (hz)
firstlicks=[]


% bef = 3*60*5;
bef = 5*60*2;
aft = 5*60*11;
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

[zscore_6,zscore_norm_6] = zscoredraw(Data_6,bef,firstLicks(6));
zscore_aligned_6 = alignFirstLick(zscore_6,firstLicks(6),bef,aft);

[zscore_7,zscore_norm_7] = zscoredraw(Data_7,bef,firstLicks(7));
zscore_aligned_7 = alignFirstLick(zscore_7,firstLicks(7),bef,aft);

[zscore_8,zscore_norm_8] = zscoredraw(Data_8,bef,firstLicks(8));
zscore_aligned_8 = alignFirstLick(zscore_8,firstLicks(8),bef,aft);

[zscore_9,zscore_norm_9] = zscoredraw(Data_9,bef,firstLicks(9));
zscore_aligned_9 = alignFirstLick(zscore_9,firstLicks(9),bef,aft);

[zscore_10,zscore_norm_10] = zscoredraw(Data_10,bef,firstLicks(10));
zscore_aligned_10 = alignFirstLick(zscore_10,firstLicks(10),bef,aft);


Data_SO = [zscore_aligned_1; zscore_aligned_3; zscore_aligned_5; zscore_aligned_7; zscore_aligned_9];
Data_SA = [zscore_aligned_2; zscore_aligned_4; zscore_aligned_6; zscore_aligned_8; zscore_aligned_10];



drawHM_aligned(Data_SO,'zscore',bef,aft);
title('Dglu');

drawHM_aligned(Data_SA,'zscore',bef,aft);
title('Lipid');



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



Data_SO = [zscore_aligned_1; zscore_aligned_3; zscore_aligned_5; zscore_aligned_7; zscore_aligned_9];
Data_SA = [zscore_aligned_2; zscore_aligned_4; zscore_aligned_6; zscore_aligned_8; zscore_aligned_10];

drawHM_aligned(Data_SA,'zscore',bef,aft);
title('L-glucose');

drawHM_aligned(Data_SO,'zscore',bef,aft);
title('D-glucose');

%% divide into k means
sortKmeans_multi_eval(Data_SA,Data_SO,bef,aft);
sortKmeans_multi_eval_2(Data_SO,Data_SA,bef,aft);
sortKmeans_multi_eval_2(Data_SO,Data_SA,bef,aft);
sortKmeans_multi_eval_4(Data_SA,Data_SO,bef,aft);


%% divid according to resp
[data1_clust1,data1_clust2, data1_clust3, data1_clust4,data2_clust1,data2_clust2, data2_clust3, data2_clust4 ] = getResponsiveSort(Data_SO,Data_SA,bef);
data1_mean1 = data1_clust1(bef:bef+10*5*60);

%% tuning preference curve
tuningPreference(Data_SO,Data_SA,bef);
tuningPreference2(Data_SO,Data_SA,bef);

ylabel('Percent of cells (%)');
%%

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
title('Fasted D glucose');
drawHM_aligned(empty_2,'zscore',bef,aft);
title('Fasted Protein');

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
    if(res_mean<-1)
        SO_inh=[SO_inh;cell];
        SO_inh_match=[SO_inh_match;cell_match];
        
    elseif(res_mean>1)
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


%% draw pie chart from data 1
[ses1_act, ses1_inh, ses1_nores] = getResponsive(Data_SO,bef);
if(length(ses1_act))
    avgplot(ses1_act,act_color,bef)
end
if(length(ses1_inh))
    avgplot(ses1_inh,inh_color,bef)
end
if(length(ses1_nores))
    avgplot(ses1_nores,no_res_color,bef)
end
drawpie(ses1_act,ses1_inh,ses1_nores);





%% draw pie chart from data 2

[ses2_act, ses2_inh, ses2_nores] = getResponsive(empty_2,bef);
if(length(ses2_act))
    avgplot(ses2_act,act_color,bef)
end
if(length(ses2_inh))
    avgplot(ses2_inh,inh_color,bef)
end
if(length(ses2_nores))
    avgplot(ses2_nores,no_res_color,bef)
end

drawpie(ses2_act,ses2_inh,ses2_nores);


%% draw response type from data 1 and data 2

[ses2_act, ses2_inh, ses2_nores] = getResponsive(empty_2,bef);
if(length(ses2_act))
    avgplot(ses2_act,act_color,bef)
end
if(length(ses2_inh))
    avgplot(ses2_inh,inh_color,bef)
end
if(length(ses2_nores))
    avgplot(ses2_nores,no_res_color,bef)
end

drawpie(ses2_act,ses2_inh,ses2_nores);
%% get common cells : data1_inhibited and data2_activated
SO_inh=[]
SO_act=[]
SO_nores=[]

SO_inh_match=[]
SO_act_match=[]
SO_nores_match=[]


for c = 1:size(Data_SO,1)
    cell = Data_SO(c,:);
    cell_match = Data_SA(c,:);
    res = cell(bef:end);
    res_mean = mean(res);
    if(res_mean<-1)
        SO_inh=[SO_inh;cell];
        SO_inh_match=[SO_inh_match;cell_match];
        
    elseif(res_mean>1)
       SO_act=[SO_act;cell];
       SO_act_match=[SO_act_match;cell_match];
 
    else
        SO_nores=[SO_nores;cell];
        SO_nores_match=[SO_nores_match;cell_match];

    end
end



[data1_inh_data2_act, data1_inh_data2_inh, data1_inh_data2_nores] = getResponsive(SO_inh_match,bef);
if(length(data1_inh_data2_act))
    avgplot(data1_inh_data2_act,act_color,bef)
end
if(length(data1_inh_data2_inh))
    avgplot(data1_inh_data2_inh,inh_color,bef)
end
if(length(data1_inh_data2_nores))
    avgplot(data1_inh_data2_nores,no_res_color,bef)
end
drawpie(data1_inh_data2_act, data1_inh_data2_inh, data1_inh_data2_nores);



%% normalize
X = [Data_SO;  Data_SA];
norm_X=[];
for c = 1:size(X,1)
    cell = X(c,:);	
    maxx = max(abs(cell));
    norm = cell/maxx;
%     norm = (responsive-mu)/sig;
    norm_X = [norm_X; norm];
end

%% GLM 
SO = zeros(1,size(Data_SO,1))+1; 
SA = zeros(1,size(Data_SO,1)); 
Y = [SO  SA] ;
XX = norm_X;
% XX = [Data_SO(:,bef:end); Data_SA(:,bef:end)];
YY = Y';
[b dev] = glmfit(XX,YY,'binomial','link','logit')
% yfit = glmval(b,norm_X);
yfit = glmval(b,XX,'logit');
figure;
plot(YY,'o');
figure;
plot(yfit,'o');

plot(XX, YY,'o',norm_X,yfit,'-','LineWidth',2)

plot(XX,yfit,'-','LineWidth',2)



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

figure;
scatter3(Y_SO(:,1),Y_SO(:,2),Y_SO(:,3),'red')
hold on;
scatter3(Y_SA(:,1),Y_SA(:,2),Y_SA(:,3),'blue')
legend('Dglu','L-glu');
xlabel("1st principle axis");ylabel("2nd principle axis");zlabel("3rd principle axis");

%% T-SNE
figure;
Y_tsne = tsne(norm_X);
gscatter(Y_tsne(:,1),Y_tsne(:,2),Y)

%% linear correlation
comparison=[]
comp_1=[];
comp_2=[];

comp_1_inh=[];
comp_1_inh_2=[];
comp_2_act=[];
comp_2_act_1=[];
biphasic_1=[];
biphasic_2=[];

for x=1:size(empty_1,1)
    rowcell = empty_1(x,:);
    baseline = rowcell(1:bef);
    res = rowcell(bef:end);
%     mu = mean(baseline);
%     sig = std(baseline);
%     meanZ = mean((res-mu)/sig);
        meanZ = mean(res);

     rowcell_2 = empty_2(x,:);
    baseline_2 = rowcell_2(1:bef);
    res_2 = rowcell_2(aft-60*5:aft);
    mu_2 = mean(baseline_2);
    sig_2 = std(baseline_2);
    meanZ_2 = mean((res_2-mu_2)/sig_2);
            meanZ_2 = mean(res_2);

            
   if(meanZ<-1 & meanZ_2>1)
       biphasic_1=[biphasic_1; meanZ];
       biphasic_2=[biphasic_2; meanZ_2];
   
   elseif(meanZ<-1)
       comp_1_inh=[comp_1_inh; meanZ];
       comp_1_inh_2=[comp_1_inh_2; meanZ_2];
   
  elseif(meanZ_2>1)
       comp_2_act=[comp_2_act; meanZ_2];
       comp_2_act_1=[comp_2_act_1; meanZ];
   else
   comp_1=[comp_1; meanZ];
    comp_2=[comp_2; meanZ_2];
   end

    comp = [meanZ meanZ_2];
    comparison=[comparison; comp];
end
figure;
 scatter(comp_1,comp_2,'o','MarkerEdgeColor',[64, 64, 64]/255); hold on;
 scatter(comp_1_inh,comp_1_inh_2,'filled','MarkerFaceColor',[49, 96, 235]/255); hold on;
 scatter(comp_2_act_1,comp_2_act,'filled','MarkerFaceColor',[227, 102, 102]/255); hold on;
 scatter(biphasic_1,biphasic_2,'filled','MarkerFaceColor',[0, 173, 58]/255); hold on;
legend("other","D glu inh ","Lipid glu act ","biphasic");
 

 xlabel("fasted D glucose ");
 ylabel("fasted L glucose ");
 line([-5 5],[1 1],'Color','k','LineStyle','--')
line([-1 -1],[-10 30],'Color','k','LineStyle','--')



xlim([-5 5])
ylim([-5 15])


 line([-10 10],[0 0],'Color','k','LineStyle','-')
line([0 0],[-10 30],'Color','k','LineStyle','-')


line([-10 10],[10 -10],'Color','r','LineStyle','-')



 x = comp_1;
 y = comp_2;
  
mdl = fitlm(x,y)
mdl.Rsquared.Ordinary

%% classifier using decoder
Data_mice_1 = [zscore_aligned_1; zscore_aligned_4];
y_label_1 = [ones(1,size(zscore_aligned_1,1)) zeros(1,size(zscore_aligned_4,1))];
res_1 = Data_mice_1(:,bef:end);
Data_mice_1_label=[res_1'; y_label_1];

Data_mice_2 = [zscore_aligned_2; zscore_aligned_5];
y_label_2 = [ones(1,size(zscore_aligned_2,1)) zeros(1,size(zscore_aligned_5,1))];
res_2 = Data_mice_2(:,bef:end);
Data_mice_2_label=[res_2'; y_label_2];

Data_mice_3 = [zscore_aligned_3; zscore_aligned_6];
y_label_3 = [ones(1,size(zscore_aligned_3,1)) zeros(1,size(zscore_aligned_6,1))];
res_3 = Data_mice_3(:,bef:end);
Data_mice_3_label=[res_3'; y_label_3];

Data_mice_4 = [zscore_aligned_4; zscore_aligned_7];
y_label_4 = [ones(1,size(zscore_aligned_4,1)) zeros(1,size(zscore_aligned_7,1))];
res_4 = Data_mice_4(:,bef:end);
Data_mice_4_label=[res_4'; y_label_4];


Data_mice_5 = [zscore_aligned_5; zscore_aligned_10];
y_label_5 = [ones(1,size(zscore_aligned_5,1)) zeros(1,size(zscore_aligned_10,1))];
res_5 = Data_mice_5(:,bef:end);
Data_mice_5_label=[res_5'; y_label_5];




% shuffled data
y_label_shuffle_id = randsample(size(zscore_aligned_1,1)+size(zscore_aligned_4,1),size(zscore_aligned_1,1));
z = zeros(1,size(zscore_aligned_1,1)+size(zscore_aligned_4,1));
z(y_label_shuffle_id)=1;
Data_mice_1_shuffled =[res_1'; z];

y_label_shuffle_id = randsample(size(zscore_aligned_2,1)+size(zscore_aligned_5,1),size(zscore_aligned_2,1));
z = zeros(1,size(zscore_aligned_2,1)+size(zscore_aligned_5,1));
z(y_label_shuffle_id)=1;

Data_mice_2_shuffled =[res_2'; z];

y_label_shuffle_id = randsample(size(zscore_aligned_3,1)+size(zscore_aligned_6,1),size(zscore_aligned_3,1));
z = zeros(1,size(zscore_aligned_3,1)+size(zscore_aligned_6,1));
z(y_label_shuffle_id)=1;

Data_mice_3_shuffled =[res_3'; z];

y_label_shuffle_id = randsample(size(zscore_aligned_4,1)+size(zscore_aligned_7,1),size(zscore_aligned_4,1));
z = zeros(1,size(zscore_aligned_4,1)+size(zscore_aligned_7,1));
z(y_label_shuffle_id)=1;

Data_mice_4_shuffled =[res_4'; z];



y_label_shuffle_id = randsample(size(zscore_aligned_5,1)+size(zscore_aligned_1-,1),size(zscore_aligned_1-,1));
z = zeros(1,size(zscore_aligned_5,1)+size(zscore_aligned_1-,1));
z(y_label_shuffle_id)=1;

Data_mice_5_shuffled =[res_5'; z];


%% SVM- decoder time bin
window = 5;
accuracies=[];
acc1 = svmDecoderTimebin(zscore_aligned_1,zscore_aligned_2,window);
accuracies=[accuracies acc1];
acc2 = svmDecoderTimebin(zscore_aligned_3,zscore_aligned_4,window);
accuracies=[accuracies acc2];
acc3 = svmDecoderTimebin(zscore_aligned_5,zscore_aligned_6,window);
accuracies=[accuracies acc3];
acc4 = svmDecoderTimebin(zscore_aligned_7,zscore_aligned_8,window);
accuracies=[accuracies acc4];
acc5 = svmDecoderTimebin(zscore_aligned_9,zscore_aligned_10,window);
accuracies=[accuracies acc5];


shuffle_accuracies=[];
shuffle_acc1 = svmDecoderTimebinShuffle(zscore_aligned_1,zscore_aligned_2,window);
shuffle_accuracies=[shuffle_accuracies shuffle_acc1];
shuffle_acc2 = svmDecoderTimebinShuffle(zscore_aligned_3,zscore_aligned_4,window);
shuffle_accuracies=[shuffle_accuracies shuffle_acc2];
shuffle_acc3 = svmDecoderTimebinShuffle(zscore_aligned_5,zscore_aligned_6,window);
shuffle_accuracies=[shuffle_accuracies shuffle_acc3];
shuffle_acc4 = svmDecoderTimebinShuffle(zscore_aligned_7,zscore_aligned_8,window);
shuffle_accuracies=[shuffle_accuracies shuffle_acc4];
shuffle_acc5 = svmDecoderTimebinShuffle(zscore_aligned_9,zscore_aligned_10,window);
shuffle_accuracies=[shuffle_accuracies shuffle_acc5];


avgplot(accuracies',[14 84 165]/255,bef)
ylabel('accuracy')
title('Dglu-Lipid decoder accuracy');
hold on;
avgplot_2(shuffle_accuracies',[0.5 0.5 0.5],bef)
ylabel('accuracy')
xticks([0:12:156]);
xticklabels(num2cell([-2:1:11]));
title('Dglu-Lglu decoder shuffle accuracy');
legend('Dglu vs Lglu','shuffled');
ylim([30 100]);

%% 
window = 5;
% all
[acc_all] = svmDecoderTimebin(Data_SO(:,bef:bef+5*60*10),Data_SA(:,bef:bef+5*60*10),window);
% w.o clust1
d1 = [data1_clust2; data1_clust3; data1_clust4];
d2 = [data2_clust2; data2_clust3; data2_clust4];
[acc_wo1] = svmDecoderTimebin(d1,d2,window);

%w.o clust2
d1 = [data1_clust1; data1_clust3; data1_clust4];
d2 = [data2_clust1;  data2_clust3; data2_clust4];
[acc_wo2] = svmDecoderTimebin(d1,d2,window);

% w.o clust3
d1 = [data1_clust1; data1_clust2; data1_clust4];
d2 = [data2_clust1; data2_clust2; data2_clust4];
[acc_wo3] = svmDecoderTimebin(d1,d2,window);

% w.o clust4
d1 = [data1_clust1; data1_clust2; data1_clust3];
d2 = [data2_clust1; data2_clust2; data2_clust3];
[acc_wo4] = svmDecoderTimebin(d1,d2,window);
startof = 0;
endof = 2;
accs = [mean(acc_all(startof*60/window+1:endof*60/5));mean(acc_wo1(startof*60/window+1:endof*60/5));
    mean(acc_wo2(startof*60/window+1:endof*60/5));
    mean(acc_wo3(startof*60/window+1:endof*60/5));mean(acc_wo4(startof*60/window+1:endof*60/5));]
figure;
bar(acc_all); hold on;
bar(acc_wo1); hold on;
bar(acc_wo2); hold on;
bar(acc_wo3); hold on;
bar(acc_wo4); hold on;
legend


%%
[acc_] = svmDecoderTimebin(d1,d2,window);
[acc_wo4] = svmDecoderTimebin(d1,d2,window);
[acc_wo4] = svmDecoderTimebin(d1,d2,window);
[acc_wo4] = svmDecoderTimebin(d1,d2,window);


%%
startof = 0;
endof = 10;
accs=[];
for c=1:size(Data_SO,1)
    acc=0;
    cell1 = Data_SO(c,startof*5*60+1:endof*5*60);
    cell2 = Data_SA(c,startof*5*60+1:endof*5*60);
%    acc = svmDecoderTimebin(cell1,cell2,window);
    x = [cell1;cell2];
    Y = {'Dglu';'Lipid'};
    SVMModel = fitcecoc(x,Y);
    CVMdl =  crossval(SVMModel,'leaveout','on');
    predicted = kfoldPredict(CVMdl);
    for j=1:length(predicted)
        comp = strcmp(predicted{j},Y{j});
        acc = acc+comp;
    end
    acc = acc/length(predicted)*100;
    accs=[accs; acc];
end

%% 
acc_clust1 = svmDecoderTimebin_clust(zscore_aligned_1,zscore_aligned_2,bef,window);
acc_clust2 = svmDecoderTimebin_clust(zscore_aligned_3,zscore_aligned_4,bef,window);
acc_clust3 = svmDecoderTimebin_clust(zscore_aligned_5,zscore_aligned_6,bef,window);
acc_clust4 = svmDecoderTimebin_clust(zscore_aligned_7,zscore_aligned_8,bef,window);
acc_clust5 = svmDecoderTimebin_clust(zscore_aligned_9,zscore_aligned_10,bef,window);
acc_clusters = [acc_clust1; acc_clust2; acc_clust3; acc_clust4; acc_clust5];
% 
% acc_all1 = svmDecoderTimebin(zscore_aligned_1,zscore_aligned_2,window);
% acc_all2 = svmDecoderTimebin(zscore_aligned_3,zscore_aligned_4,window);
% acc_all3 = svmDecoderTimebin(zscore_aligned_5,zscore_aligned_6,window);
% acc_all4 = svmDecoderTimebin(zscore_aligned_7,zscore_aligned_8,window);
% acc_all5 = svmDecoderTimebin(zscore_aligned_9,zscore_aligned_10,window);

acc_all1 = svmDecoderTimebin_whole(zscore_aligned_1,zscore_aligned_2,window);
acc_all2 = svmDecoderTimebin_whole(zscore_aligned_3,zscore_aligned_4,window);
acc_all3 = svmDecoderTimebin_whole(zscore_aligned_5,zscore_aligned_6,window);
acc_all4 = svmDecoderTimebin_whole(zscore_aligned_7,zscore_aligned_8,window);
acc_all5 = svmDecoderTimebin_whole(zscore_aligned_9,zscore_aligned_10,window);
acc_all = [mean(acc_all1); mean(acc_all2); mean(acc_all3); mean(acc_all4); mean(acc_all5)];

%% without specific clusters

acc_clust1 = svmDecoderTimebin_clust_wo(zscore_aligned_1,zscore_aligned_2,bef,window);
acc_clust2 = svmDecoderTimebin_clust_wo(zscore_aligned_3,zscore_aligned_4,bef,window);
acc_clust3 = svmDecoderTimebin_clust_wo(zscore_aligned_5,zscore_aligned_6,bef,window);
acc_clust4 = svmDecoderTimebin_clust_wo(zscore_aligned_7,zscore_aligned_8,bef,window);
acc_clust5 = svmDecoderTimebin_clust_wo(zscore_aligned_9,zscore_aligned_10,bef,window);
acc_clusters = [acc_clust1; acc_clust2; acc_clust3; acc_clust4; acc_clust5];

acc_all1 = svmDecoderTimebin(zscore_aligned_1,zscore_aligned_2,window);
acc_all2 = svmDecoderTimebin(zscore_aligned_3,zscore_aligned_4,window);
acc_all3 = svmDecoderTimebin(zscore_aligned_5,zscore_aligned_6,window);
acc_all4 = svmDecoderTimebin(zscore_aligned_7,zscore_aligned_8,window);
acc_all5 = svmDecoderTimebin(zscore_aligned_9,zscore_aligned_10,window);
acc_all = [mean(acc_all1); mean(acc_all2); mean(acc_all3); mean(acc_all4); mean(acc_all5)];

%%
acc_clust1 = svmDecoderTimebin_clust(zscore_aligned_1,zscore_aligned_2,bef,window);
acc_clust2 = svmDecoderTimebin_clust(zscore_aligned_3,zscore_aligned_4,bef,window);
acc_clust3 = svmDecoderTimebin_clust(zscore_aligned_5,zscore_aligned_6,bef,window);
acc_clust4 = svmDecoderTimebin_clust(zscore_aligned_7,zscore_aligned_8,bef,window);
acc_clust5 = svmDecoderTimebin_clust(zscore_aligned_9,zscore_aligned_10,bef,window);

cluster1_accuracies = [acc_clust1(:,1) acc_clust2(:,1) acc_clust3(:,1) acc_clust4(:,1) acc_clust5(:,1)];
cluster1_accuracies_filtered = addClust(cluster1_accuracies);

cluster2_accuracies = [acc_clust1(:,2) acc_clust2(:,2) acc_clust3(:,2) acc_clust4(:,2) acc_clust5(:,2)];
cluster2_accuracies_filtered = addClust(cluster2_accuracies);

cluster3_accuracies = [acc_clust1(:,3) acc_clust2(:,3) acc_clust3(:,3) acc_clust4(:,3) acc_clust5(:,3)];
cluster3_accuracies_filtered = addClust(cluster3_accuracies);

cluster4_accuracies = [acc_clust1(:,4) acc_clust2(:,4) acc_clust3(:,4) acc_clust4(:,4) acc_clust5(:,4)];
cluster4_accuracies_filtered = addClust(cluster4_accuracies);

avgplot_2(cluster1_accuracies_filtered',[50, 168, 82]/255,bef);
hold on;
avgplot_2(cluster2_accuracies_filtered',[14 84 165]/255,bef);
hold on;
avgplot_2(cluster3_accuracies_filtered',[204, 62, 57]/255,bef);
hold on;
avgplot_2(cluster4_accuracies_filtered',[122 122 122]/255,bef);

ylabel('accuracy')
title('Dglu-Lipid decoder accuracy');

xticks([0:12:156]);
xticklabels(num2cell([-2:1:11]));
