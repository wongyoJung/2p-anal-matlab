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
    h =3
    destination = 'C:\Users\User\Desktop\Two choice\Operant licking\Results\';
 %     destination = 'C:\Users\User\Desktop\Two choice\Operant licking\Opto\Results\';
    dir = horzcat('H:\', fileNames{h},'.txt');
%     copyfile(dir,destination);
%     directory = 'E:\';
    directory = destination;
    LickCountDraw_oneBottle(directory,fileNames{h},animalID{h},'D glucose');
    [cummulLick, countB] = cummulLickDraw_oneBottle(directory,fileNames{h},animalID{h},'L-glucose');

%     [cummulLick, countB] = cummulLickDraw_oneBottle_milli(directory,fileNames{h},animalID{h},'L-glucose');
    TotalLick{h,1}=animalID{h};
    TotalLick{h,2}=countB;
    TotalLick{h,3}=cummulLick;
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
LickArray=[];
for k=1:leng
    k 
    data=TotalLick{k,4};
    time=data(:,1);
   
    LickArray = [LickArray data(:,2)];
end
 for i=1:5
     i
data = TotalLick{i,4};
z(i,:) = data(:,2);
end

%%
%Draw graph Plot with error
x=0:1:45*60;
x=x';
y=LickArray;

figure;
% shadedErrorBar(x,mean(y,2), std(y,1,2),'lineprops','-r','transparent',1);
% hold on;
% shadedErrorBar(x,mean(y,2), std(y,1,2)/sqrt(size(y,2)),'lineprops',{'Color',[0.06, 0.60, 0.69]},'transparent',1);
shadedErrorBar(x,mean(y,2), std(y,1,2)/sqrt(size(y,2)),'lineprops',{'Color',[1 0.502 0.502]},'transparent',1);

legend('Lglucose');
xlabel('Time(s)');
ylabel('Cummulative Lick');
set(gca,'TickDir','out');
ylim([0 1600]);
xlim([0 2700]);
box off;
%%
figure;
x=0:3:time(end);
x=x';
y=eYFP_SO;
z=eYFP_SA;
title('eYFP paired');
shadedErrorBar(x,mean(y,2), std(y,1,2),'lineprops','-r','transparent',1);
hold on;
shadedErrorBar(x,mean(z,2), std(z,1,2),'lineprops','-g','transparent',1);
legend('sucrose','sucralose');
xlabel('Time(s)');
ylabel('Cummulative Lick');
set(gca,'TickDir','out');
ylim([0 1000]);
box off;