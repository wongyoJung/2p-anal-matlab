TotalLick={};
animalID=Data(:,1);
fileNames=Data(:,2);
leng =length(fileNames);
%%
for i=1:leng
    if(~ischar(fileNames{i}))
    fileNames{i}=horzcat('0',num2str(fileNames{i}));
    fileNames{i} = num2str(fileNames{i});
    end
end


for h=1:leng
    h
    destination = 'C:\Users\User\Desktop\Two choice\Operant licking\Results\';
 %     destination = 'C:\Users\User\Desktop\Two choice\Operant licking\Opto\Results\';
    dir = horzcat('H:\', fileNames{h},'.txt');
%     copyfile(dir,destination);
%     directory = 'E:\';
    directory = destination;
%     LickCountDraw_oneBottle(directory,fileNames{h},animalID{h},'Lipid');

    [cummulLick, countB] = cummulLickDraw_oneBottle(directory,fileNames{h},animalID{h},'D-glucose');
    TotalLick{h,1} = cummulLick;
    TotalLick{h,2} = countB;
%     [cummulLick, countA,countB]= cummulLickDraw(directory,fileNames{h},animalID{h});
%     TotalLick{h,1}=animalID{h};
% %     TotalLick{h,2}=countA;  
%     TotalLick{h,3}=countB;
%     TotalLick{h,4}=cummulLick;
end

%%
%For abatar
for h=10:leng
   h 
    destination = 'D:\Two choice\ABATAR\Results';
    dir = horzcat('E:\', fileNames{h},'.txt');
    copyfile(dir,destination);
    directory = 'E:\';
    LickTimePickforABATAR(directory,fileNames{h},animalID{h});
    
end

%%
%  categorize 

eArch_SO=[];
eArch_SA=[];
eYFP_SO=[];
eYFP_SA=[];
time=[];
%%
LickArrayON=[];
LickArrayOFF=[];
for k=1:leng
    lastchar = Data{k,1}(end);
    if(strcmp(lastchar,'N'))
        data=TotalLick{k,1};
        time=data(:,1);
        LickArrayON = [LickArrayON data(:,2)];
    else
        data=TotalLick{k,1};
        time=data(:,1);
        LickArrayOFF = [LickArrayOFF data(:,2)];   
    end
end


%%
%Draw graph Plot with error
x=0:1:45*60;
x=x';
y=LickArrayON;

figure;
% shadedErrorBar(x,mean(y,2), std(y,1,2),'lineprops','-r','transparent',1);
% hold on;
% shadedErrorBar(x,mean(y,2), std(y,1,2)/sqrt(size(y,2)),'lineprops',{'Color',[0.06, 0.60, 0.69]},'transparent',1);
shadedErrorBar(x,mean(y,2), std(y,1,2)/sqrt(size(y,2)),'lineprops',{'Color',[1 0.502 0.502]},'transparent',1);

xlabel('Time(s)');
ylabel('Cummulative Lick');
set(gca,'TickDir','out');
ylim([0 800]);
xlim([0 30*60]);
box off;

%Draw graph Plot with error
% x=0:1:30*60;
% x=x';
y=LickArrayOFF;


% shadedErrorBar(x,mean(y,2), std(y,1,2),'lineprops','-r','transparent',1);
% hold on;
% shadedErrorBar(x,mean(y,2), std(y,1,2)/sqrt(size(y,2)),'lineprops',{'Color',[0.06, 0.60, 0.69]},'transparent',1);
hold on
shadedErrorBar(x,mean(y,2), std(y,1,2)/sqrt(size(y,2)),'lineprops',{'Color',[0.5 0.5 0.5]},'transparent',1);
legend('Light ON','Light OFF');

xlabel('Time(s)');
ylabel('Cummulative Lick');
set(gca,'TickDir','out');
ylim([0 800]);
xlim([0 30*60]);
box off;


%%
cummulLick=[];
for k=1:leng
        data=TotalLick{k,1};
        time=data(:,1);
        cummulLick = [cummulLick data(:,2)];   
end
figure;
x=0:1:60*45;
x=x';
y=cummulLick;
% Dglu
% shadedErrorBar(x,mean(y,2), std(y,1,2),'lineprops',{'Color',[56/255 95/255 150/255]},'transparent',1,'transparent',1);
% Lipid
shadedErrorBar(x,mean(y,2), std(y,1,2),'lineprops',{'Color',[200/255 142/255 51/255]},'transparent',1,'transparent',1);
% Lglu
% shadedErrorBar(x,mean(y,2), std(y,1,2),'lineprops',{'Color',[200/255 40/255 51/255]},'transparent',1,'transparent',1);

legend('lipid');
xlabel('Time(min)');
ylabel('Cummulative Lick');
set(gca,'TickDir','out');
xlim([0 2700]);
ylim([0 1600]);
box off;
xticks([0:300:2700]);
xticklabels({'0','5','10','15','20','25','30','35','40','45'});