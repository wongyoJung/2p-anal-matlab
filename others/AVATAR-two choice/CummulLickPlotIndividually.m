TotalLick={};
animalID=Data(:,1);
fileNames=Data(:,2);
leng =length(fileNames);
%%
for i=1:leng
    if(~ischar(fileNames{i}))
    fileNames{i}=horzcat('0',num2str(fileNames{i}));
    end
end


for h=1:leng
%     filedir = 'C:\Users\user\Desktop\Two choice\onebottle\water';
%     dir = horzcat('E:\', fileNames{h},'.txt');
%     copyfile(dir,filedir);
    directory = 'C:\Users\user\Desktop\Two choice\Opto\Results\SOvsSA\TotalGroup\';
    [cummulLick, countA,countB]= cummulLickDraw(directory,fileNames{h},animalID{h});
    TotalLick{h,1}=animalID{h};
    TotalLick{h,2}=countA;
    TotalLick{h,3}=countB;
    TotalLick{h,4}=cummulLick;
end

%%
%  categorize 

eArch_SO=[];
eArch_SA=[];
eYFP_SO=[];
eYFP_SA=[];
time=[];
%%
for k=1:leng
    data=TotalLick{k,4};
    time=data(:,1);
    animal=animalID{k};
    ID=animal(1:2);
    if(ID=='eA')
        if(Data{k,3}=='SO')
            eArch_SO=[eArch_SO data(:,2)];
            eArch_SA=[eArch_SA data(:,3)];
        else
            eArch_SO=[eArch_SO data(:,3)];
            eArch_SA=[eArch_SA data(:,2)];         
        end
    else
        if(Data{k,3}=='SO')
            eYFP_SO=[eYFP_SO data(:,2)];
            eYFP_SA=[eYFP_SA data(:,3)];
        else
            eYFP_SO=[eYFP_SO data(:,3)];
            eYFP_SA=[eYFP_SA data(:,2)];
        end
    end
end


%%
%Draw graph Plot with error
x=0:3:time(end);
x=x';
y=eYFP_SO;
z=eYFP_SA;

figure;
title('eYFP');

plot(x,y,'Color',[1,0.8,0.8],'LineWidth',1.2,'HandleVisibility','off')
hold on;
plot(x,z,'Color',[0.76,0.85,0.74],'LineWidth',1.2,'HandleVisibility','off')

hold on;
p1 = plot(x,mean(y,2),'Color',[0.88,0.01,0.01],'LineWidth',2)
hold on;
p2 = plot(x,mean(z,2),'Color',[1,0.50,0.50],'LineWidth',2)
legend([p1,p2], 'sucrose','sucralose');



xlabel('Time(s)');
ylabel('Cummulative Lick');
set(gca,'TickDir','out');

box off;
%%
x=0:3:time(end);
x=x';
y=eArch_SO;
z=eArch_SA;

figure;
title('eArch');

plot(x,y,'Color',[1,0.8,0.8],'LineWidth',1.2,'HandleVisibility','off')
hold on;
plot(x,z,'Color',[0.76,0.85,0.74],'LineWidth',1.2,'HandleVisibility','off')

hold on;
p1 = plot(x,mean(y,2),'Color',[0.88,0.01,0.01],'LineWidth',2)
hold on;
p2 = plot(x,mean(z,2),'Color',[0,0.60,0.50],'LineWidth',2)
legend([p1,p2], 'sucrose','sucralose');



xlabel('Time(s)');
ylabel('Cummulative Lick');
set(gca,'TickDir','out');

box off;
