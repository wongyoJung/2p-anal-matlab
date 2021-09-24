function [accuracies] = svmDecoderTimebinShuffle(data1,data2,window)
X = [data1; data2];
Y={};
for i=1:size(data1,1)*2
    Y=[Y; 'Dglu'];
end

idx = [1:size(data1,1)*2];
idxShuffle = idx(randperm(length(idx)));
idxShuffle = idxShuffle(1:size(data1,1));

for j=1:length(idxShuffle)
    id = idxShuffle(j);
    Y{id}='Lipid';
end


accuracies = [];
window = window*5;
for t=1:window:size(data1,2)-window
    t
     acc=0;
    x = X(:,t:t+window);
    SVMModel = fitcecoc(x,Y);
    CVMdl =  crossval(SVMModel,'leaveout','on');
    predicted = kfoldPredict(CVMdl);
    for j=1:length(predicted)
        comp = strcmp(predicted{j},Y{j});
        acc = acc+comp;
    end
    acc = acc/length(predicted)*100;
    accuracies=[accuracies; acc];
end

end

