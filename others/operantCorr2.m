function [dFs,licks,count,dFF] = operantCorr(txtfile,directory,Lfilter,Lfilter2,FL)
% directory = "C:\Users\User\Desktop\Two choice\Operant licking\Results\";
txtfile = strcat(directory,txtfile,'.txt');

T =readtable(txtfile);
select=T{:,2};
time=T{:,3};

count=length(find(strcmp(select,"LickB")));
B_id=strcmp(select,"LickB");
Licktime=time(B_id);
Btime=time(B_id);

[pks,idx] = find(Lfilter2>2);

startTDT = idx(1);
startTXT = Btime(1)/1000*FL;

timediff = (startTDT-startTXT);

adjusted = round((Licktime/1000*FL+timediff));

LickB=zeros(1,length(adjusted))+1;

scatter(adjusted,(LickB));

boutEnds = adjusted(find(diff(adjusted)>5*FL));
boutStarts = adjusted(find(diff(adjusted)>5*FL)+1);
boutStarts = [adjusted(1); boutStarts];





dFs =[];
licks = [];
for k=1:length(boutStarts)-1;
    boutstart = boutStarts(k);
    boutend = boutEnds(k);
    
    boutstartidx= find(adjusted == boutstart);
    boutendidx = find(adjusted == boutend);
    
    baseline = Lfilter(boutstart-5*FL:boutstart-1);
    lick = boutendidx - boutstartidx;
    
    if(lick>5)
        licks(length(licks)+1) = lick;
        dF = (Lfilter(boutstart:boutend)-mean(baseline))/mean(baseline);
        dFs(length(dFs)+1)=mean(dF);
    end
    
end

LickB=zeros(1,length(boutEnds))+1;
Licsk  =zeros(1,length(boutStarts))+1;
% scatter(boutEnds,LickB);
% hold on
% scatter(boutStarts,Licsk,'r','filled');
bline = mean(Lfilter(1:boutStarts(1)));
dFF = mean(Lfilter-bline)/bline;
end
