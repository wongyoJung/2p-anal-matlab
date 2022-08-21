directory = "C:\Users\User\Desktop\Two choice\Operant licking\Results\";
matdirectory= "D:\»õ Æú´õ\Operant\";
animalID=Data(:,1);
fileNames=Data(:,2);


dFs = [];
Licks = [];
LickCount = [];
dFFs = [];


for x = 1:2;
    matname = Data(x,3);
    matfile = load(strcat(matdirectory,matname,'.mat'));
    Lfilter = matfile.Lfilter;
    Lfilter2= matfile.Lfilter2;
    txtfile = fileNames{x};
    FL = matfile.FL;
    [dF,lick,count,dFF] = operantCorr(txtfile,directory,Lfilter,Lfilter2,FL);
    dFs = [dFs dF];
    Licks = [Licks lick];
    LickCount = [LickCount count];
    dFFs = [dFFs dFF];
end
scatter(dFs,Licks)
corrcoef(dFs,Licks)


%% plot raw graph
for x = 1:3;
    matname = Data(x,3);
    matfile = load(strcat(matdirectory,matname,'.mat'));
    Lfilter = matfile.Lfilter;
    Lfilter2= matfile.Lfilter2;
   figure; plot(Lfilter2); hold on; plot(Lfilter, 'k');
   ylim([0.5 1.5]);
end