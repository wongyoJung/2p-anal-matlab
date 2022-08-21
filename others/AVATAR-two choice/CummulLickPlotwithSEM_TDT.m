TotalLick={};
animalID=Data(:,1);
fileNames=Data(:,2);
leng =length(fileNames);
%%
for i=1:leng
    if(~ischar(fileNames{i}))
    fileNames{i}=horzcat('0',num2str(fileNames{i}));
    end
end


for h=1:length(Lick_time)
    h 
    
        licktime = Lick_time{h};
%         animalID = 
%     destination = 'D:\Two choice\Opto\ChR2\pre\txt\';
%     dir = horzcat('E:\', fileNames{h},'.txt');
%     copyfile(dir,destination);
    
    [cummulLick, countA,countB]= cummulLickDraw_TDT(licktime);
%     TotalLick{h,1}=animalID{h};
    TotalLick{h,2}=countA;
    TotalLick{h,3}=countB;
    TotalLick{h,4}=cummulLick;
end

%%
%  categorize 

eArch_SO=[];
eArch_SA=[];
eYFP_SO=[];
eYFP_SA=[];
time=[];
%%
for k=1:leng
    k 
    data=TotalLick{k,4};
    time=data(:,1);
    animal=animalID{k};
    ID=animal(1:2);
    if(ID=='Ch')
        if(Data{k,3}=='SO')
            eArch_SO=[eArch_SO data(:,2)];
            eArch_SA=[eArch_SA data(:,3)];
        else
            eArch_SO=[eArch_SO data(:,3)];
            eArch_SA=[eArch_SA data(:,2)];         
        end
    else
        if(Data{k,3}=='SO')
            eYFP_SO=[eYFP_SO data(:,2)];
            eYFP_SA=[eYFP_SA data(:,3)];
        else
            eYFP_SO=[eYFP_SO data(:,3)];
            eYFP_SA=[eYFP_SA data(:,2)];
        end
    end
end

%%
%Draw graph Plot with error
x=0:3:time(end);
x=x';
y=eArch_SO;
z=eArch_SA;

figure;
title('ChR2');
shadedErrorBar(x,mean(y,2), std(y,1,2),'lineprops','-r','transparent',1);
hold on;
shadedErrorBar(x,mean(z,2), std(z,1,2),'lineprops','-g','transparent',1);
legend('sucrose','sucralose');
xlabel('Time(s)');
ylabel('Cummulative Lick');
set(gca,'TickDir','out');
ylim([0 1000]);
box off;
%%
figure;
x=0:3:time(end);
x=x';
y=eYFP_SO;
z=eYFP_SA;
title('Vagotomized');
shadedErrorBar(x,mean(y,2), std(y,1,2),'lineprops','-r','transparent',1);
hold on;
shadedErrorBar(x,mean(z,2), std(z,1,2),'lineprops','-g','transparent',1);
legend('sucrose','sucralose');
xlabel('Time(s)');
ylabel('Cummulative Lick');
set(gca,'TickDir','out');
ylim([0 1000]);
box off;