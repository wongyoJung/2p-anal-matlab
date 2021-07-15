function [clust_act, clust_inh, clust_nores] = getResponsive(data,bef)
clust_act=[];
clust_inh=[];
clust_nores=[];

for k=1:size(data,1)
    cell = data(k,:);
 
    res = cell(:,bef:end);
    m = mean(res);
    if(m>1)
        clust_act=[clust_act; cell];        
    elseif(m<-1)
        clust_inh=[clust_inh; cell];
    else
        clust_nores=[clust_nores; cell];
        
    end
end
end
