auROCs=[];

for k=1:size(Data,1)
    k
    cell = Data(k,:);
    base = cell(1:5*60*5);
%     food = cell(1500:end);
%     auROCs=[];
    for s = 0:10:size(cell,2)-11
% video : 5Hz, 10 frame window => 2s of window
        window = cell(s+1:s+11);
        result = roc_curve(base,window,-1,0);
        roc_data = result.param.AROC;
        auROCs(k,s/10+1)=roc_data;
    end
    close all

end
auROCs = 2*auROCs-1;

%% k-means
% firstLick=476.496;
firstLick = 303.36556666666667;
firstLick = floor(firstLick/2)
response_auROC=auROCs(:,firstLick:size(auROCs,2));

 idx = kmeans(response_auROC,3,'Replicates',100);
clust1 = [];
clust2 = [];
clust3 = [];

for k=1:size(auROCs,1)
    if(idx(k)==1)
        clust1=[clust1; auROCs(k,:)];
    elseif(idx(k)==2)
        clust2=[clust2; auROCs(k,:)];
    elseif(idx(k)==3)
        clust3=[clust3; auROCs(k,:)];
    end
    
end

sorted = [clust2;clust3;clust1];
  figure
    imagesc(sorted);
    colorbar

 m = size(get(gcf,'colormap'),1);    
     m1 = m*0.5;
    r = (0:m1-1)'/max(m1-1,1);
    g = r;
    r = [r; ones(m1,1)];
    g = [g; flipud(g)];
    b = flipud(r);   
    c = [r g b]; 
    colormap(c);
xticks([1:59:size(sorted,2)])

xticklabels(num2cell([0:120:10*60]))
% xticks([1:49:size(sorted,2)])
% xticklabels(num2cell([0:50:449]))

% firstLick = 1500/10
x = firstLick;
y1 = 0; y2=50;
line([x x], [y1 y2],'LineStyle','--','LineWidth',2,'Color','k'); 
set(gca,'Tickdir','out')
set(gca, 'box','off')
xlabel('time (s)');
ylabel('individual cells');


%% z-score
zscores=[];
zscores_nonormed=[];


for k=1:size(Data,1)
    k
    cell = Data(k,:);
    base = cell(1:2.5*60*5);
    mu = mean(base);
    sig = std(base);
    zscore = (cell-mu)/sig;
    zscore_norm = zscore/max(abs(zscore));
    zscores=[zscores; zscore_norm];
    zscores_nonormed=[zscores_nonormed; zscore];
end



 %% zscore/k-means
 firstLick =floor(144.96483333333333*5);
 responseZscore= zscores(:,floor(firstLick):4500)
 idx = kmeans(responseZscore,3,'Replicates',100);
clust1 = [];
clust2 = [];
clust3 = [];

for k=1:size(responseZscore,1)
    if(idx(k)==1)
        clust1=[clust1; zscores(k,:)];
    elseif(idx(k)==2)
        clust2=[clust2; zscores(k,:)];
    elseif(idx(k)==3)
        clust3=[clust3; zscores(k,:)];
    end
    
end

sorted = [clust3;clust1;clust2];
  figure
    imagesc(sorted);
    colorbar

 m = size(get(gcf,'colormap'),1);    
     m1 = m*0.5;
    r = (0:m1-1)'/max(m1-1,1);
    g = r;
    r = [r; ones(m1,1)];
    g = [g; flipud(g)];
    b = flipud(r);   
    c = [r g b]; 
    colormap(c);
    caxis([-1 1])
xticks([1:600:size(sorted,2)+1])
xticklabels(num2cell([0:600:6000]))
% xticks([1:49:size(sorted,2)])
% xticklabels(num2cell([0:50:449]))

% firstLick=floor(476.496*5);
% firstLick = floor(firstLick*5);
% firstLick = floor(firstLick/2)
% firstLick = 1500/10
x = firstLick;
y1 = 0; y2=50;
line([x x], [y1 y2],'LineStyle','--','LineWidth',2,'Color','k'); 
set(gca,'Tickdir','out')
set(gca, 'box','off')
xlabel('time (s)');
ylabel('individual cells(s)');



%% align to firstLick and integrate

integrated = alignFirstLick(Data,firstLick/5,5);

firstLick1=476.496;
firstLick2 = 324.46593333333334;
bef = 5*60*5;
aft = 10*60*5;
mice1 = alignFirstLick(Data1,firstLick1,5);
mice2 = alignFirstLick(Data2,firstLick2,5);

integrated = [mice1;mice2];

zscores_integrated=[];
zscores_integrated_norm=[];
for k=1:size(integrated,1)
    k
    cell = integrated(k,:);
    base = cell(1:2.5*60*5);
    mu = mean(base);
    sig = std(base);
    zscore = (cell-mu)/sig;
    zscore_norm = zscore/max(abs(zscore));
    zscores_integrated=[zscores_integrated; zscore];
    zscores_integrated_norm=[zscores_integrated_norm; zscore_norm];
end
figure; imagesc(zscores_integrated); colorbar; caxis([-4 4]);
figure; imagesc(zscores_integrated_norm); colorbar; caxis([-1 1]);

responseZscore= zscores_integrated_norm(:,bef+1:end);
 idx = kmeans(responseZscore,3,'Replicates',100);
clust1 = [];
clust2 = [];
clust3 = [];

for k=1:size(responseZscore,1)
    if(idx(k)==1)
%         clust1=[clust1; zscores_integrated(k,:)];
        clust1=[clust1; zscores_integrated(k,:)];

    elseif(idx(k)==2)
%         clust2=[clust2; zscores_integrated(k,:)];
        clust2=[clust2; zscores_integrated(k,:)];

    elseif(idx(k)==3)
%         clust3=[clust3; zscores_integrated(k,:)];
        clust3=[clust3; zscores_integrated(k,:)];
    end
    
end

integrated_sorted = [clust2;clust3;clust1];
  figure
    imagesc(integrated_sorted);
    colorbar;caxis([-4 4]);

 m = size(get(gcf,'colormap'),1);    
     m1 = m*0.5;
    r = (0:m1-1)'/max(m1-1,1);
    g = r;
    r = [r; ones(m1,1)];
    g = [g; flipud(g)];
    b = flipud(r);   
    c = [r g b]; 
    colormap(c);
xticks([1:300*5:size(integrated_sorted,2)+1])
xticklabels(num2cell([-300:300:600]))
% xticks([1:49:size(sorted,2)])
% xticklabels(num2cell([0:50:449]))
a = colorbar;
a.Label.String = 'zscore';


xx = bef;
y1 = 0; y2=100;
line([xx xx], [y1 y2],'LineStyle','--','LineWidth',0.5,'Color','k'); 
set(gca,'Tickdir','out')
set(gca, 'box','off')
xlabel('Time from the first lick (s)');
ylabel('z-score')
ylim([-5 7])
ylabel('individual cells');


%% average drawing
    mu = mean(clust1,1);
    sig = std(clust1,1,1);
    
% %     mu = mean(Data,1);
% %     sig = std(Data,1,1);
    
    x=[1:4501];
%     x=[1:450];
    figure;
shadedErrorBar(x,mu, sig,'lineprops',{'Color',[0.50, 0.50, 0.50]},'transparent',1);
hold on;
line([xx xx], [-5 5],'LineStyle','--','LineWidth',2,'Color','k'); 
ylabel('individual cell');
xlabel('time(s)')
xticks([1:300*5:size(clust3,2)])
xticklabels(num2cell([-300:300:600]))
% ylim([-1 1])
xlim([0 (bef+aft)])


    %% average
    
    mu = mean(integrated_sorted,1);
    sig = std(integrated_sorted,1,1);
    
% %     mu = mean(Data,1);
% %     sig = std(Data,1,1);
    
%     x=[1:4501];
    x=[1:450];
    figure;
shadedErrorBar(x,mu, sig,'lineprops',{'Color',[0.50, 0.50, 0.50]},'transparent',1);
hold on;
line([xx xx], [-1.5 1.5],'LineStyle','--','LineWidth',2,'Color','k'); 
ylabel('individual cell');
xlabel('time(s)')
xticks([1:30*5:size(integrated_sorted,2)])
xticklabels(num2cell([-300:300:600]))
ylim([-1 1])
xlim([0 (bef+aft)/10])

%% 
figure;
for k=13:18
    tmp = Data2(k,:);
    subplot(6,1,k-12);
    plot(tmp);
    ylim([-50, max(tmp)]);
end
figure;
for k=1:12
    tmp = Data2(k,:);
    subplot(12,1,k);
    plot(tmp);
     ylim([-50, max(tmp)]);
end
figure;
for k=1:12
    tmp = auROCs(k,:);
    subplot(12,1,k);
    plot(tmp);
     ylim([-1.2, 1.2]);
     set(gca,'TickDir', 'out')
     set(gca, 'box', 'off')
end


figure;
for k=13:24
    tmp = auROCs(k,:);
    subplot(12,1,k-12);
    plot(tmp);
     ylim([-1.2, 1.2]);
     set(gca,'TickDir', 'out')
     set(gca, 'box', 'off')
end

%%
mean_ROC=[];
for i = 1:size(auROCs)
    mean_ROC(i,1)=mean(auROCs(i,1:x));
    mean_ROC(i,2)=mean(auROCs(i,1+x:end));
end
ttest(mean_ROC(:,1),mean_ROC(:,2))
