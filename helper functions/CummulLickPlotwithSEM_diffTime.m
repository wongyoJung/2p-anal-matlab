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


for h=1:leng
%     filedir = 'C:\Users\user\Desktop\Two choice\Opto\Results\SOvsSA\Group2';
%     dir = horzcat('E:\', fileNames{h},'.txt');
%     copyfile(dir,filedir);
    directory = 'C:\Users\User\Desktop\Two choice\Operant licking\Results\';
    [cummulLick, countA, countB]=cummulLickDraw_diff(directory,fileNames{h},animalID{h});
    TotalLick{h,1}=animalID{h};
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
    data=TotalLick{k};
    time=1:1:1800;
    animal=animalID{k};
    ID=animal(1:2);
    if(ID=='Sh')
        if(Data{k,3}=='SO')
            eArch_SO=[eArch_SO TotalLick{k,2}];
            eArch_SA=[eArch_SA TotalLick{k,3}];
        else
            eArch_SO=[eArch_SO TotalLick{k,3}];
            eArch_SA=[eArch_SA TotalLick{k,2}];         
        end
    else
        if(Data{k,3}=='D')
            eYFP_SO=[eYFP_SO TotalLick{k,2}];
            eYFP_SA=[eYFP_SA TotalLick{k,3}];
        else
            eYFP_SO=[eYFP_SO TotalLick{k,3}];
            eYFP_SA=[eYFP_SA TotalLick{k,2}];
        end
    end
end

%%
%Draw graph Plot with error
figure;
set(gcf,'Position',[0 0 1200 400]);
x=0:1:time(end);
x=x';
y=eArch_SO;
z=eArch_SA;

title('eArch');
shadedErrorBar(x,mean(y,2), std(y,1,2),'lineprops','-r','transparent',1);
% hold on;
% shadedErrorBar(x,mean(z,2), std(z,1,2),'lineprops','-g','transparent',1);
% legend('sucrose','sucralose');
legend('sucrose');

xlabel('Time(s)');
ylabel('Licks/s');
set(gca,'TickDir','out');
ylim([0 10]);
box off;
%%
figure;
set(gcf,'Position',[0 0 1200 400]);
x=0:1:time(end);
x=x';
y=eYFP_SO;
z=eYFP_SA;
title('eYFP');
% shadedErrorBar(x,mean(y,2), std(y,1,2),'lineprops','-r','transparent',1);
% % hold on;
shadedErrorBar(x,mean(z,2), std(z,1,2),'lineprops','-g','transparent',1);
% legend('sucrose','sucralose');
legend('sucralose');
xlabel('Time(s)');
ylabel('Licks/s');
set(gca,'TickDir','out');
ylim([0 10]);
box off;

%%
%time window with 5min bin
eArch_timebin_SO={};
eArch_timebin_SA={};
eYFP_timebin_SO={};
eYFP_timebin_SA={};


for t=5:5:30
eArch_timebin_SO=[eArch_timebin_SO; num2cell(mean(eArch_SO((t-5)*60+1:t*60,:)))];
eArch_timebin_SA = [eArch_timebin_SA; num2cell(mean(eArch_SA((t-5)*60+1:t*60,:)))];
end

for t=5:5:30
eYFP_timebin_SO=[eYFP_timebin_SO; num2cell(mean(eYFP_SO((t-5)*60+1:t*60,:)))];
eYFP_timebin_SA = [eYFP_timebin_SA; num2cell(mean(eYFP_SA((t-5)*60+1:t*60,:)))];
end