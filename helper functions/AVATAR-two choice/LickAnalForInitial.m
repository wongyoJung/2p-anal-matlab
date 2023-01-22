function [Results]=LickAnalForInitial(filename)
    Results=[];
    filename=horzcat('C:\Users\user\Desktop\Two choice\Opto\Results\SOvsSA\TotalGroup\',filename,'.txt');
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
    A_IBI=[];
    ALickperBout=[];

    
        if endA(1)>1
            Aduration=Atime(endA(1))-Atime(1);
            ALickperBout=(endA(1))/Aduration*1000;
            AILI = mean(diff(Atime(1:endA(1))));            
        
        else id=2
             Aduration=Atime(endA(id))-Atime(id);
            ALickperBout=(endA(id))/Aduration*1000;
            AILI = mean(diff(Atime(1:endA(id))));
            if Aduration == 0
                id = 3;
            Aduration=Atime(endA(id))-Atime(id);
            ALickperBout=(endA(id))/Aduration*1000;
            AILI = mean(diff(Atime(1:endA(id))));
            end
        end
        
        
     
    
    diffBtime=diff(Btime);
    endB=find(diffBtime>1000);
    Bduration=[];
    B_IBI=[];
    BLickperBout=[];

    
        if endB(1)>1
            Bduration=Btime(endB(1))-Btime(1);
            BLickperBout=(endB(1))/Bduration*1000;
            BILI = mean(diff(Btime(1:endB(1))));
        else
            id=2;
            Bduration=Btime(endB(id))-Btime(id);
            BLickperBout=(endB(id))/Bduration*1000;
            BILI = mean(diff(Btime(1:endB(id))));
            if Bduration == 0
                id=3;
             Bduration=Btime(endB(id))-Btime(id);
            BLickperBout=(endB(id))/Bduration*1000;
            BILI = mean(diff(Btime(1:endB(id))));   
                if Bduration == 0
                    id = 4;
                    Bduration=Btime(endB(id))-Btime(id);
                    BLickperBout=(endB(id))/Bduration*1000;
                    BILI = mean(diff(Btime(1:endB(id))));  
            if Bduration == 0
                        id = 5;
                        Bduration=Btime(endB(id))-Btime(id);
                        BLickperBout=(endB(id))/Bduration*1000;
                        BILI = mean(diff(Btime(1:endB(id)))); 
           
                if Bduration == 0
                        id = 6;
                        Bduration=Btime(endB(id))-Btime(id);
                        BLickperBout=(endB(id))/Bduration*1000;
                        BILI = mean(diff(Btime(1:endB(id)))); 
                end
            end
                end
            end
            end
       
    
    h=1;
    Results(h,1) = Aduration/1000;
    Results(h,2) = Bduration/1000;
    Results(h,3) = ALickperBout;
    Results(h,4) = BLickperBout;
    Results(h,5) = AILI;
    Results(h,6) = BILI;
end