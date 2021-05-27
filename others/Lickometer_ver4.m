filename='E:\04100039.TXT';
T =readtable(filename);
select=T{:,2};
fid = fopen(filename);
S = fscanf(fid,'%s');

startTime=S(1:8);

Name = 'bi4';

countA=length(find(strcmp(select,'LickA')));
countB=length(find(strcmp(select,'LickB')));

time=T{:,5}-duration(startTime);
time = seconds(time);
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
plot(cummulLick(:,1),cummulLick(:,2),'Color',[0,0.60,0.50],'LineWidth',1.5)
hold on;
plot(cummulLick(:,1),cummulLick(:,3),'Color',[0.88,0.01,0.01],'LineWidth',1.5)
legend('LickA','LickB','Location','southeast');
xlabel('Time(s)');
ylabel('Cummulative Lick');
set(gca,'TickDir','out');
box off;



% text(100,1000,LickA);
% figure;
%     legend('LickA','LickB','Location','southeast');
%     xlabel('Time(s)');
%     ylabel('Cummulative Lick');
%     set(gca,'TickDir','out');
%     box off;
%    


% v = VideoReader('F:\videofile\190225_two choice_avi\0225_174626_bi8_Hab2.avi');
% nFrames = v.Duration*v.FrameRate;
% for i = 1:100:nFrames
%     img = read(v,i);
%     image(img);
%     box off;
%     axis off;
%     
% end
% v = VideoWriter(strcat(Name,'.avi'));
% open(v);
% % subplot(1,2,1);
% h = animatedline('Color',[0,0.60,0.50],'LineWidth',1.5);
% h2 = animatedline('Color',[0.88,0.01,0.01],'LineWidth',1.5);
% x=cummulLick(:,1); y=cummulLick(:,2);
% z=cummulLick(:,3);
% ymax =  max(max(y),max(z));
% xmax = max(x);
% title(Name);
% 
% for k = 1:3:length(x)
%     ylim([0,ymax]);
%     xlim([0,xmax]);
%     addpoints(h,x(k),y(k));
%     addpoints(h2,x(k),z(k));
%     LickA=strcat('Sucrose: ' , sprintf('%d',y(k)));
%     LickB=strcat('Sucralose: ' , sprintf('%d',z(k)));
%     text1 = text(100,ymax/3,LickA);
%     text2 = text(100,ymax/3-40,LickB);
%     legend('Sucrose','Sucralose','Location','southeast');
%     drawnow
%     frame=getframe(gcf);
%     writeVideo(v,frame);
%     ylabel('cummulative lick');
%     xlabel('Time(s)');
%     if (k < length(x)-5)
%         delete(text1);
%         delete(text2);
%     end
% 
% end
% close(v);
% close figure;
% % 
% % subplot(1,2,2);   
% % v = VideoReader('F:\videofile\190225_two choice_avi\0225_174626_bi8_Hab2.avi');
% % nFrames = v.Duration*v.FrameRate;
% % for i = 1:100:nFrames
% %     img = read(v,i);
% %     image(img);
% %     box off;
% %     axis off;
% %     
% % end