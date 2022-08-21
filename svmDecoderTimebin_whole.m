function [acc] = svmDecoderTimebin_whole(data1,data2)
X = [data1; data2];
Y1={};
Y2={};
acc = 0;
for i=1:size(data1,1)
    Y1=[Y1; 'Dglu'];
    Y2=[Y2; 'Lipid'];
end
Y = [Y1; Y2];
% Y=  [ ones(size(Data_SO,1),1); zeros(size(Data_SO,1),1)];
accuracies = [];
% window = window*5;
    SVMModel = fitcecoc(X,Y);
    CVMdl =  crossval(SVMModel,'leaveout','on');
    predicted = kfoldPredict(CVMdl);
    for j=1:length(predicted)
        comp = strcmp(predicted{j},Y{j});
        acc = acc+comp;
    end
    acc = acc/length(predicted)*100;
%     accuracies=[accuracies; acc];
% for t=1:window:size(data1,2)-window
%     t
%      acc=0;
%     x = X(:,t:t+window);
%     SVMModel = fitcecoc(x,Y);
%     CVMdl =  crossval(SVMModel,'leaveout','on');
%     predicted = kfoldPredict(CVMdl);
%     for j=1:length(predicted)
%         comp = strcmp(predicted{j},Y{j});
%         acc = acc+comp;
%     end
%     acc = acc/length(predicted)*100;
%     accuracies=[accuracies; acc];
% end

end

