lTotalLick={};
animalID=Data(:,1);
fileNames=Data(:,2);
leng =length(fileNames);
%%
for i=1:leng
    if(~ischar(fileNames{i}))
%     fileNames{i}=horzcat('0',num2str(fileNames{i}));
    fileNames{i} = num2str(fileNames{i});
    end
end


for h=1:leng
    h 
    destination = 'C:\Users\User\Desktop\Two choice\ABATAR\Results\';
    dir = horzcat('C:\Users\User\Desktop\Two choice\ABATAR\Results\', fileNames{h},'.txt');
%     copyfile(dir,destination);

    directory = destination;
%     LickCountDraw_oneBottle(directory,fileNames{h},animalID{h},'D glucose');
%     [cummulLick,countA,countB]= cummulLickDraw(directory,fileNames{h},animalID{h});
    LickCountDraw(directory,fileNames{h},animalID{h});
%     [cummulLick, countA]= cummulLickDraw_oneBottle(directory,fileNames{h},animalID{h},'NaCl 200mM');
    TotalLick{h,1}=animalID{h};
    TotalLick{h,2}=countA;  
    TotalLick{h,3}=countB;
    TotalLick{h,4}=cummulLick;
end

colorbar('box', 'off')
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

%% categorize

eArch_SO=[];
eArch_SA=[];
eYFP_SO=[];
eYFP_SA=[];
time=[];

for k=1:leng
    data=TotalLick{k};
    time=1:1:1800;
    animal=animalID{k};
    ID=animal(1:2);
    if(ID=='Ch')
        if(Data{k,3}=='SO')
            eArch_SO=[eArch_SO TotalLick{k,4}(:,2)];
            eArch_SA=[eArch_SA TotalLick{k,4}(:,3)];
        else
            eArch_SO=[eArch_SO TotalLick{k,4}(:,3)];
            eArch_SA=[eArch_SA TotalLick{k,4}(:,2)];         
        end
    else
        if(Data{k,3}=='SO')
            eYFP_SO=[eYFP_SO TotalLick{k,4}(:,2)];
            eYFP_SA=[eYFP_SA TotalLick{k,4}(:,3)];
        else
            eYFP_SO=[eYFP_SO TotalLick{k,4}(:,3)];
            eYFP_SA=[eYFP_SA TotalLick{k,4}(:,2)];
        end
    end
end

%%

 for i=1:5
     i
data = TotalLick{i,4};
z(i,:) = data(:,2);
end

%%
%Draw graph Plot with error
x=0:3:1800;
x=x';
y=eArch_SO;
z=eArch_SA;

figure;
title('eArch');
shadedErrorBar(x,mean(y,2), std(y,1,2)/sqrt(size(y,2)),'lineprops',{'Color',[1.0, 0.50, 0.50]},'transparent',1);
hold on;
shadedErrorBar(x,mean(z,2), std(z,1,2)/sqrt(size(z,2)),'lineprops',{'Color',[100,150,170]/255},'transparent',1);
legend('SO','SA');
xlabel('Time(s)');
ylabel('Cummulative Lick');
set(gca,'TickDir','out');
ylim([0 2000]);
box off;
%%
figure;
x=0:3:time(end);
x=x';
y=eYFP_SA;
z=eYFP_SO;
title('eYFP ');
shadedErrorBar(x,mean(y,2), std(y,1,2)/sqrt(size(y,2)),'lineprops',{'Color',[1.0, 0.50, 0.50]},'transparent',1);
hold on;
shadedErrorBar(x,mean(z,2), std(z,1,2)/sqrt(size(z,2)),'lineprops',{'Color',[100,150,170]/255},'transparent',1);
legend('sucrose','sucralose');
xlabel('Time(s)');
ylabel('Cummulative Lick');
set(gca,'TickDir','out');
ylim([0 1000]);
box off;