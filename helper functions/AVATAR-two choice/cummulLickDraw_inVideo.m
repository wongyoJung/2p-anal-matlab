
filename='E:\03072033.TXT';
T =readtable(filename);
select=T{:,2};

countA=length(find(strcmp(select,'LickA')));
countB=length(find(strcmp(select,'LickB')));

time=T{:,3}/1000;

cummulLick=[];
for t=0:3:time(end)
    t 
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
legend('Sucrose','Sucralose','Location','southeast');
xlabel('Time(s)');
ylabel('Cummulative Lick');
set(gca,'TickDir','out');
box off;

x=cummulLick(:,1);
y=cummulLick(:,2);
z=cummulLick(:,3);


v = VideoReader('F:\videofile\190225_two choice_avi\0225_140742_bi4_Hab2.avi');
nFrames = v.Duration*v.FrameRate;
for i = 7200:1:8200
    img = read(v,i);
    image(img);
    box off;
    axis off;
    LickA=strcat('Sucrose: ' , sprintf('%d',y(i/30)));
    LickB=strcat('Sucralose: ' , sprintf('%d',z(i/30)));
    text1 = text(100,ymax/3,LickA);
    text2 = text(100,ymax/3-40,LickB);
end

