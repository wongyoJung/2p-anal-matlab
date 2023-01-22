filename='E:\02272003.TXT';
T =readtable(filename);
select=T{:,2};
Name='CF39';


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
    
    startTimeA=[Atime(1)];
    startTimeA=[startTimeA; Atime(endA+1)];
    endTimeA=Atime(endA);
    endTimeA=[endTimeA; Atime(end)];
    length(startTimeA)
    length(endTimeA)
    
  startTimeB=[Btime(1)];
    startTimeB=[startTimeB; Btime(endB+1)];
    endTimeB=Btime(endB);
    endTimeB=[endTimeB; Btime(end)];
    length(startTimeB)
    length(endTimeB)
    
FirstLick = min(min(startTimeA), min(startTimeB))/1000*12.5;
firstLickFP = 9473;
sync = (firstLickFP - round(FirstLick))/12.5*1000;
if sync>0
    syncM = zeros(1,sync);
    LickA=[syncM LickA];
    LickB=[syncM LickB];
    x = [1:1:time(end)+sync]/1000;


else
   LickA(1:abs(sync))=[];
   LickB(1:abs(sync))=[];
   x = [1:1:time(end)]/1000;
   x(1:abs(sync))=[];
end

    stem(x,LickA*2,'Marker','none','Color',[0,0.60,0.50])
    set(gca,'YTickLabel',[]);
    hold on;
    g2=stem(x,LickB*2,'Marker','none','Color',[0.8,0.30,0.10]);
    set(gca,'TickDir','out');
    set(gca,'ytick',[]);
    set(gca,'Fontsize',15);
    % legend('Sucrose','Sucralose','Location','northwest','Fontsize',15);
    title(Name,'fontsize',15);
    xlabel('Time(s)','Fontsize',15);
