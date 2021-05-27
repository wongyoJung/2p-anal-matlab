function[] = LickCountDraw_pneBottle(directory,filename,animalID,liquid)
% filename=b;
% animalID=a;
% A=c;
% directory='E:\';
filename=horzcat(directory,filename,'.txt');
T =readtable(filename);
select=T{:,2};
Name=animalID;


% countA=length(find(strcmp(select,"LickA")));
countB=length(find(strcmp(select,"LickB")));

time=T{:,3};
% A_id=strcmp(select,"LickA");
B_id=strcmp(select,"LickB");

% LickA=zeros(1,time(end));
LickB=zeros(1,45*60*1000);

% Atime=time(A_id);
Btime=time(B_id);

% for k=1:length(Atime)
%     LickA(Atime(k))=1;
% end

for k=1:length(Btime)
    LickB(Btime(k))=1;
end
x=1:45*60*1000;
    figure('Position', [10 10 800 300]);
%     stem(x,LickA*2,'Marker','none','Color',[0,0.60,0.50])
    set(gca,'YTickLabel',[]);
    hold on;
    g2=stem(x,LickB*2,'Marker','none','Color',[0.8,0.30,0.10]);
    set(gca,'TickDir','out');
    set(gca,'ytick',[]);
    set(gca,'Fontsize',15);
%     if(A=='SO')
%         legend('Sucrose','Sucralose','Location','northwest','Fontsize',12,'Orientation','horizontal');
%     else
%         legend('Sucralose','Sucrose','Location','northwest','Fontsize',12,'Orientation','horizontal');
%     end
     legend(liquid,'Location','northwest','Fontsize',12,'Orientation','horizontal');
     xlim([0, 45*60*1000])
     xticks(0:5*60*1000:45*60*1000)
     xticklabels([0:5:45])

    
   
%     set(lgnd,'position',[0 0 0.5 0.1]);
    title(Name,'fontsize',15);
    xlabel('Time(min)','Fontsize',15);
    
end