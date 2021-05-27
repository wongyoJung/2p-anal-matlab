function [Results]=LickAnal(filename)
    Results=[];

    filename='E:\03211709';
    T =readtable(filename);
    select=T{:,2};

    countA=length(find(strcmp(select,'LickA')));
    countB=length(find(strcmp(select,'LickB')));

    time=T{:,3};
    A_id=strcmp(select,'LickA');
    B_id=strcmp(select,'LickB');

    LickA=zeros(1,time(end));
    LickB=zeros(1,time(end));

    Atime=time(A_id);
    Btime=time(B_id);

    diffAtime=diff(Atime);
    endA=find(diffAtime>1000);
    Aduration=[];
    ALickperBout=[];

    Aduration(1,1)=Atime(endA(1))-Atime(1);
    for i=2:1:length(endA)
        if endA(i)>endA(i-1)+1
            Aduration(i,1)=Atime(endA(i))-Atime(endA(i-1)+1);
            ALickperBout(i,1)=(endA(i)-endA(i-1))/Aduration(i,1)*1000;
        end

    end


    meanA=mean(Aduration(find(Aduration~=0)));
    Afreq2=length(find(endA>1000));
    Afreq=length(Aduration(find(Aduration~=0)));
    ASpeed=mean(ALickperBout(find(ALickperBout~=0)));

    diffBtime=diff(Btime);
    endB=find(diffBtime>1000);
    Bduration=[];
    BLickperBout=[];

    Bduration(1,1)=Btime(endB(1))-Btime(1);
    for i=2:1:length(endB)
        if endB(i)>endB(i-1)+1
            Bduration(i,1)=Btime(endB(i))-Btime(endB(i-1)+1);  
            BLickperBout(i,1)=(endB(i)-endB(i-1))/Bduration(i,1)*1000;
        end

    end
    meanB=mean(Bduration(find(Bduration~=0)));
    Bfreq=length(Bduration(find(Bduration~=0)));
    BSpeed=mean(BLickperBout(find(BLickperBout~=0)));

    h=1;
    Results(h,1) = meanA/1000;
    Results(h,2) = meanB/1000;
    Results(h,3) = Afreq;
    Results(h,4) = Bfreq;
    Results(h,5) = ASpeed;
    Results(h,6) = BSpeed;
end
    %%
    startTimeA=[Atime(1)];
    startTimeA=[startTimeA; Atime(endA+1)];
    endTimeA=Atime(endA);
    endTimeA=[endTimeA; Atime(end)];
    length(startTimeA)
    length(endTimeA)
    
    AnnoTime=num2cell([round(startTimeA/1000*12.5+sync) round(endTimeA/1000*12.5+sync) ]);
    for i=1:length(AnnoTime)
    AnnoTime{i,3}=char('LickA');
    end
%     
% fid = fopen( 'results.txt', 'wt' );
% for i = 1:length(AnnoTime)
%   [a1, a2, a3] = AnnoTime{i, 1:3};
%   fprintf( fid, '    %d    %d    %s\n', a1, a2, a3);
% end
% fclose(fid);
%     


    startTimeB=[Btime(1)];
    startTimeB=[startTimeB; Btime(endB+1)];
    endTimeB=Btime(endB);
    endTimeB=[endTimeB; Btime(end)];
    length(startTimeB)
    length(endTimeB)
    
    BnnoTime=num2cell([round(startTimeB/1000*12.5+sync) round(endTimeB/1000*12.5+sync) ]);
    for i=1:length(BnnoTime)
    BnnoTime{i,3}=char('LickB');
    end
    
Changes=[];
   diffLfilter=diff(Lfilter);
   for k=1:length(AnnoTime)
       strt=AnnoTime{k,1};
       endd=AnnoTime{k,2};
       if strt~=endd
        change=mean(diffLfilter(strt:endd));
       end
    Changes(k)=change;
   end
AChange=mean(Changes);

    
BChanges=[];
   diffLfilter=diff(Lfilter);
   for k=1:length(BnnoTime)
       strt=BnnoTime{k,1};
       endd=BnnoTime{k,2};
       if strt~=endd
        change=mean(diffLfilter(strt:endd));
       end
    BChanges(k)=change;
   end
BChange=mean(BChanges);


Matrix=AnnoTime;
Drops=[];
for k=1:length(Matrix)
       strt=Matrix{k,1};
       endd=Matrix{k,2};
       if strt~=endd
           base=mean(Lfilter(strt-38:strt-1));
           value=mean(Lfilter(strt:endd));
           drop=(base-value)*base*100;
       end
   Drops(k)=drop;
end
ADrop=mean(Drops);
AMaxDrop=max(Drops);
plot(Lfilter);
ylim([0.95 1.15]);