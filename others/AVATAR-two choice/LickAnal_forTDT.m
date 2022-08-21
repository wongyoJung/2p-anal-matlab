function [Results]=LickAnal_forTDT(LickA,LickB)
    Results=[];
%     filename=horzcat('E:\',filename,'.txt');
    
  
    countA=length(LickA);
    countB=length(LickB);
% 
%     time=T{:,3};
%     A_id=strcmp(select,'LickA');
%     B_id=strcmp(select,'LickB');
% 
%     LickA=zeros(1,time(end));
%     LickB=zeros(1,time(end));

%     Atime=time(A_id);
%     Btime=time(B_id);
    Atime = LickA; Btime = LickB;
    diffAtime=diff(Atime);
    endA=find(diffAtime>1000);
    Aduration=[];
    A_IBI=[];
    ALickperBout=[];
    if(isempty(endA))
        Aduration(1,1) = Atime(end)-Atime(1);
    else
    Aduration(1,1)=Atime(endA(1))-Atime(1);
    end
    
    for i=2:1:length(endA)
        if endA(i)>endA(i-1)+1
            Aduration(i,1)=Atime(endA(i))-Atime(endA(i-1)+1);
            ALickperBout(i,1)=(endA(i)-endA(i-1))/Aduration(i,1)*1000;
        end

    end
    
    A_IBI=mean(diffAtime(find(diffAtime>1000)))/1000;
    A_ILI=mean(diffAtime(find(diffAtime<1000)))/1000;
    


    meanA=mean(Aduration(find(Aduration~=0)));
    Afreq2=length(find(endA>1000));
    Afreq=length(Aduration(find(Aduration~=0)));
    ASpeed=mean(ALickperBout(find(ALickperBout~=0)));

    diffBtime=diff(Btime);
    endB=find(diffBtime>1000);
    Bduration=[];
    B_IBI=[];
    BLickperBout=[];
    if(isempty(endB))
        Bduration(1,1) = Btime(end)-Btime(1);
    else
         Bduration(1,1)=Btime(endB(1))-Btime(1);
    end
    
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
    
    B_IBI=mean(diffBtime(find(diffBtime>1000)))/1000;
    B_ILI=mean(diffBtime(find(diffBtime<1000)))/1000;
    
    h=1;
    Results(h,1) = meanA/1000;
    Results(h,2) = meanB/1000;
    Results(h,3) = Afreq;
    Results(h,4) = Bfreq;
    Results(h,5) = ASpeed;
    Results(h,6) = BSpeed;
    Results(h,7) = A_IBI;
    Results(h,8) = B_IBI;
    Results(h,9) = A_ILI;
    Results(h,10)= B_ILI;
end