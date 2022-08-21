function [clust_act,clust_inh,clust_no_res] = responsiveCell(data,bef,aft)
% variable data should be zscore_aligned to the firstlick
clust_act=[];
clust_inh=[];
clust_no_res=[];

for k=1:size(data,1)
    k
    cell = data(k,:);
    m = mean(cell(bef+1:aft));
    mm = min(cell(bef+1:aft));
    mmm = max(cell(bef+1:aft));
%     if m<-1
%         clust_inh = [clust_inh; cell];
%     elseif mmm>1
%         clust_act = [clust_act; cell];
%     else
%         clust_no_res = [clust_no_res; cell];
%     end
    if m>1
        clust_act = [clust_act; cell];
    elseif m<-1
        clust_inh = [clust_inh; cell];
    else
        clust_no_res=[clust_no_res; cell];
    end

end
end
