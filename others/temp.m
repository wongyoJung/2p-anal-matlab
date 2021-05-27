function [] = mergeCummulLickPlot(directory,Lists)
    directory = 'E:\';
    filename = Lists{1};
    filename=horzcat('E:\',filename,'.txt');
    T =readtable(filename);
    select=T{:,2};
    time = T{:,3}/1000;
    endOn = time(end);
    for i=2:size(Lists,1)
         directory = 'E:\';
        filename = Lists{i};
        filename=horzcat('E:\',filename,'.txt');
        T2 =readtable(filename);
        select2=T2{:,2};
        time2 = T2{:,3}/1000;
        time2 = time2+time(end);
        time = [time; time2];
        select = [select; select2];
        if(i==2)
            endOff = time2(end);
        end
    end
    

cummulLick=[];
for t=0:3:time(end)
      id=find(time<t);
    if isempty(id)
        TimeId=0;
    else
        TimeId=id(end);
    end
    LickA=length(find(strcmp(select(1:TimeId,1),'LickA')));
    LickB=length(find(strcmp(select(1:TimeId,1),'LickB')));
    cummulLick(t/3+1,1)=t;
    cummulLick(t/3+1,2)=LickA;
    cummulLick(t/3+1,3)=LickB;
end

figure;
title('eArch3-1');
ylim([0 3000]);
xlim([0 4000]);
line([endOn endOn],[0 3000],'Color',[0.06 0.06 0.06]);
hold on;
line([endOff endOff],[0 3000],'Color',[0.06 0.06 0.06]);
hold on;
plot(cummulLick(:,1),cummulLick(:,3),'Color',[1,0.2,0],'LineWidth',2)
hold on;
plot(cummulLick(:,1),cummulLick(:,2),'Color',[0.2,0.5,1],'LineWidth',2)

legend('D glucose','L glucose');

Name = 'eArch3-1';

x=cummulLick(:,1);
y=cummulLick(:,2);
z=cummulLick(:,3);
v = VideoWriter(strcat(Name,'.avi'));
open(v);
% subplot(1,2,1);
h = animatedline('Color',[0,0.60,0.50],'LineWidth',1.5);
h2 = animatedline('Color',[0.88,0.01,0.01],'LineWidth',1.5);
x=cummulLick(:,1); y=cummulLick(:,2);
z=cummulLick(:,3);


title(Name);
line([endOn endOn],[0 3000],'Color',[0.06 0.06 0.06]);
hold on;
line([endOff endOff],[0 3000],'Color',[0.06 0.06 0.06]);
hold on;

v = VideoWriter(strcat(Name,'.avi'));
open(v);
for k = 1:6:length(time)
    ylim([0 3000]);
    xlim([0 4000]);
    addpoints(h,x(k),y(k));
    addpoints(h2,x(k),z(k));
    LickA=strcat('L glucose: ' , sprintf('%d',y(k)));
    LickB=strcat('D glucose: ' , sprintf('%d',z(k)));
    text1 = text(100,ymax/3,LickA);
    text2 = text(100,ymax/4,LickB);
    legend('D glucose','L glucose','Location','southeast');
    drawnow
    frame=getframe(gcf);
    writeVideo(v,frame);
    ylabel('cummulative lick');
    xlabel('Time(s)');
    if (k < length(x)-10)
        delete(text1);
        delete(text2);
    end

end
close(v);


end
