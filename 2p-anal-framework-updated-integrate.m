Data_1_active=[]
Data_2_active=[]


firstLick_1 = floor(180*5)+1;
firstLick_2 = floor(204*5)+1;

bef = 2*5*60;
aft = 5*60*10;


%% 
[zscore_1,zscore_norm_1] = zscoredraw(Data_1_active,bef,firstLick_1);
zscore_aligned_1 = alignFirstLick(zscore_1,firstLick_1,bef,aft);

drawHM_aligned(zscore_aligned_1,'zscore',bef,aft);
title('Data1');

[zscore_2,zscore_norm_2] = zscoredraw(Data_2_active,bef,firstLick_2);
zscore_aligned_2 = alignFirstLick(zscore_2,firstLick_2,bef,aft);

drawHM_aligned(zscore_aligned_2,'zscore',bef,aft);
title('Data2');

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
title('fasted Dfructose');
drawHM_aligned(empty_2,'zscore',bef,aft);
title('fasted Lglu');
%% 
inh_color = [0/255 86/255 191/255];
act_color = [255/255, 73/255, 56/255];
no_res_color = [0.5 0.5 0.5];

%% draw pie chart from data 1
[ses1_act, ses1_inh, ses1_nores] = getResponsive(empty_1,bef);
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
%%

%%


clust_2_act_match=[];
clust_2_inh_match=[];
clust_2_nores_match=[];
for k=1:size(empty_1,1)
    cell = empty_1(k,:);
    cell2 = empty_2(k,:);

    res = cell(:,bef:end);
    m = mean(res);
    if(m>1)
%         clust_1_act=[clust_1_act; cell];
        clust_2_act_match=[clust_2_act_match;cell2 ];
        
    elseif(m<-1)
%         clust_1_inh=[clust_1_inh; cell];
        clust_2_inh_match=[ clust_2_inh_match; cell2];

    else
%         clust_1_nores=[clust_1_nores; cell];
        clust_2_nores_match=[clust_2_nores_match; cell2];
    end
end

%     avgplot(clust_2_act_match,no_res_color,bef)
%     avgplot(clust_2_inh_match,no_res_color,bef)
    avgplot(clust_2_inh_match,no_res_color,bef)
ses1Inh_ses2_act=[];
ses1Inh_ses2_inh=[];
ses1Inh_ses2_nores=[];
            
[ses1Inh_ses2_act, ses1Inh_ses2_inh, ses1Inh_ses2_nores] = getResponsive(clust_2_inh_match,bef);
drawpie(ses1Inh_ses2_act,ses1Inh_ses2_inh,ses1Inh_ses2_nores);


%% linear regression
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
    res_2 = rowcell_2(bef:aft);
%     mu_2 = mean(baseline_2);
%     sig_2 = std(baseline_2);
%     meanZ_2 = mean((res_2-mu_2)/sig_2);
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
 ylabel("fasted lipid ");
 line([-6 6],[-1 -1],'Color','k','LineStyle','--')
line([-1 -1],[-10 30],'Color','k','LineStyle','--')



xlim([-6 8])
ylim([-5 15])


 line([-10 10],[0 0],'Color','k','LineStyle','-')
line([0 0],[-10 30],'Color','k','LineStyle','-')


line([-10 10],[10 -10],'Color','r','LineStyle','-')



 x = comp_1;
 y = comp_2;
  
 mdl = fitlm(x,y)
mdl.Rsquared.Ordinary

  b1 = x\y;
 yCalc1 = b1*x;
scatter(x,y)
hold on
plot(x,yCalc1)
xlabel('fasted Lglucose ')
ylabel('fased Dglucose')
title('Linear Regression')
grid on;

%% representative image
for i=1:size(empty_1,1)
    formatSpec = 'The cell # %d.';
    str = sprintf(formatSpec,i)
    cell = empty_1(i,:);
    cell2 = empty_2(i,:);
    m = mean(cell(bef:end));
    m2 = mean(cell2(bef:end));
    if(m<-1 && m2>1)
        figure;
        subplot(2,1,1);
         line([bef bef],[-10 10],'Color','k','LineStyle','--')
         line([bef+aft-60*5 bef+aft-60*5],[-10 10],'Color','k','LineStyle','--')
        hold on;
    plot(cell);
    ylim([-5 5])
    title(str);
    subplot(2,1,2);
            line([bef bef],[-10 10],'Color','k','LineStyle','--')
         line([bef+aft-60*5 bef+aft-60*5],[-10 10],'Color','k','LineStyle','--')
         hold on;
    plot(cell2);
        ylim([-5 5])

    
    end
    



end

