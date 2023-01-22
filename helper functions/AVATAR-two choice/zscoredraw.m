function [zscores,zscores_norm] = zscoredraw(Data, baseline,firstLick)
%  baseline should be in frame (Hz)
zscores=[];
zscores_norm=[];

    for k=1:size(Data,1)
        cell = Data(k,:);
        base = cell(firstLick-baseline:firstLick-1);    
        mu = mean(base);
        sig = std(base);
        zscore = (cell-mu)/sig;
%         zscore = (cell-mu)/mu;
        zscore_norm = zscore/max(abs(zscore));
        zscores=[zscores; zscore];
        zscores_norm=[zscores_norm; zscore_norm];
    end
end