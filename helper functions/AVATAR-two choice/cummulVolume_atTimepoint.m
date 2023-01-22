function infused =cummulVolume_atTimepoint(directory,filename,animalID,timePoint,firstLick);
file=horzcat(directory,filename,'.txt');
T =readtable(file);
select=T{:,2};
millitime=T{:,3};
time=floor(millitime/1000);
num=1;
count=[];
firstLickIntxt = millitime(1);
start=millitime(1);
count(1,1)=time(1);
count(2,1)=5;
for i=1:length(time)
    if((millitime(i)-start)>=3000)
        num=num+1;
        count(1,end+1)=time(i);
        count(2,end)=5*num;
        start=millitime(i);
    end
end
count=count';
 value=0;
cummulVolume = zeros(1,70*60);
for i=1:length(cummulVolume)
    if(find(count(:,1)==i))
        value=value+5;
    end
    cummulVolume(1,i)=i;
    cummulVolume(2,i)=value;
    
end
cummulVolume=cummulVolume';
maxTime = (timePoint-firstLick)*60;
infused = cummulVolume(floor(maxTime+firstLickIntxt/1000),2);
% figure;
% plot(cummulVolume(:,1),cummulVolume(:,2),'Color',[0.88,0.01,0.01],'LineWidth',1.5)
% legend('D glucose','Location','southeast');
% xlabel('Time(s)');
% ylabel('Cummulative volume(uL)');
% xlim([0, 45*60])
% xticks(0:5*60:45*60)
% xticklabels([0:5:45])
% set(gca,'TickDir','out');
% box off;
% title(animalID);
end
