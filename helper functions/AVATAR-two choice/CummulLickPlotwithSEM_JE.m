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
    h =8;
    destination = 'C:\Users\User\Desktop\Two choice\ABATAR\Results\20200521\';
    dir = horzcat('H:\', fileNames{h},'.txt');
%     copyfile(dir,destination);
    directory = 'H:\';
    directory = destination;
      LickCountDraw(directory,fileNames{h},animalID{h});
      cummulLickDraw(directory,fileNames{h},animalID{h});
%     LickCountDraw_oneBottle(directory,fileNames{h},animalID{h},'D glucose');
%     cummulLickDraw_oneBottle(directory,fileNames{h},animalID{h},'D glucose');

    [cummulLick, countA,countB]= cummulLickDraw(directory,fileNames{h},animalID{h});
    TotalLick{h,1}=animalID{h};
    TotalLick{h,2}=countA;  
    TotalLick{h,3}=countB;
    TotalLick{h,4}=cummulLick;
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

 for i=1:5
     i
data = TotalLick{i,4};
z(i,:) = data(:,2);
end

%%
%Draw graph Plot with error
x=0:3:time(end);
x=x';
y=eArch_SO;
z=eArch_SA;

figure;
title('ChR2');
shadedErrorBar(x,mean(y,2), std(y,1,2),'lineprops','-r','transparent',1);
hold on;
shadedErrorBar(x,mean(z,2), std(z,1,2),'lineprops',{'Color',[1.0, 0.50, 0.50]},'transparent',1);
legend('L glucose');
xlabel('Time(s)');
ylabel('Cummulative Lick');
set(gca,'TickDir','out');
ylim([0 1000]);
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