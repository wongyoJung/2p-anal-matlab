
function[accArray] = addClust(check)
    accArray=[];
for i=1:size(check,2)
    c = check(:,i);
    if(mean(c)>1)
        accArray=[accArray c]
    end
end
end
