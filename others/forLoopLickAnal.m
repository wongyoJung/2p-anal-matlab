for i=1:size(Data,1)
    directory= 'C:\Users\User\Desktop\Two choice\Operant licking\Opto\result-real\';
% result=LickAnal(directory,fileNames{i});    
 result=LickAnal_oneBottle(directory,fileNames{i});   
for k=1:length(result)
    Results{i,k}=result(k);
end

end
