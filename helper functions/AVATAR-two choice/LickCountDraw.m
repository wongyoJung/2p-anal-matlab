function[] = LickCountDraw(directory,filename,animalID)
% filename=b;
% animalID=a;
% % A=c;
% directory='D:\Two choice\Operant licking\Results\';
filename=horzcat(directory,filename,'.txt');
T =readtable(filename);
select=T{:,2};
Name=animalID;
A='SO';

countA=length(find(strcmp(select,"LickA")));
countB=length(find(strcmp(select,"LickB")));

time=T{:,3};
A_id=strcmp(select,"LickA");
B_id=strcmp(select,"LickB");

LickA=zeros(1,time(end));
LickB=zeros(1,time(end));

Atime=time(A_id);
Btime=time(B_id);

for k=1:length(Atime)
    LickA(Atime(k))=1;
end


for k=1:length(Btime)
    LickB(Btime(k))=1;
end
x=1:time(end);
    figure('Position', [10 10 800 300]);
%    stem(x,LickA*2,'Marker','none','Color',[0,0.60,0.50]) green
     stem(x,LickA*2,'Marker','none','Color',[0.8,0.30,0.10])
    set(gca,'YTickLabel',[]);
    hold on;
%     g2=stem(x,-LickB*2,'Marker','none','Color',[0.8,0.30,0.10]);red 
    g2=stem(x,-LickB*2,'Marker','none','Color',[0,0.60,0.50]);
    set(gca,'TickDir','out');
    set(gca,'ytick',[]);
    set(gca,'Fontsize',15);
    legend('Sucrose','Sucralose');

%     if(STRCMP(A'SO')
%     legend('Sucrose','Sucralose','Location','northwest','Fontsize',12,'Orientation','horizontal');
%         else
%         legend('Sucralose','Sucrose','Location','northwest','Fontsize',12,'Orientation','horizontal');
%     end
    
   
%     set(lgnd,'position',[0 0 0.5 0.1]);
    title(Name,'fontsize',15);
    xlabel('Time(s)','Fontsize',15);
    
end