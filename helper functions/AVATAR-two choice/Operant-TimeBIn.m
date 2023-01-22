TotalLick={};
animalID=Data(:,1);
fileNames=Data(:,2);
leng =length(fileNames);
%%
for i=1:leng
    if(~ischar(fileNames{i}))
    fileNames{i}=horzcat('0',num2str(fileNames{i}));
    fileNames{i} = num2str(fileNames{i});
    end
end


for h=1:leng
    h
    destination = 'C:\Users\User\Desktop\Two choice\Operant licking\Results\';
 %     destination = 'C:\Users\User\Desktop\Two choice\Operant licking\Opto\Results\';
    dir = horzcat('H:\', fileNames{h},'.txt');
%     copyfile(dir,destination);
%     directory = 'E:\';
    directory = destination;
%     LickCountDraw_oneBottle(directory,fileNames{h},anaimalID{h},'Lipid');
    [cummulLick, countB] = cummulLickDraw_oneBottle(directory,fileNames{h},animalID{h},'D-glucose');
    TotalLick{h,1} = cummulLick;
    TotalLick{h,2} = countB;

end

%% Time bin analysis : licks per 5 min
TimeBins=[];
for k=1:leng
    TimeBin=[];
    cummulLick = TotalLick{k,1};
    totaltime = length(cummulLick);
    for j=1:floor(totaltime/60/5)
        TimeBin(j) = cummulLick(j*60*5,2)-cummulLick((j-1)*60*5+1,2);
    end
    TimeBins=[TimeBins; TimeBin];
end
