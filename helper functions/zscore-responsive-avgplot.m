zscores=[];
clust_act=[];
clust_inh=[];
clust_no_res=[];

for k=1:size(integrated,1)
    k
    cell = integrated(k,:);
    base = cell(1:2*60*5);
    mu = mean(base);
    sig = std(base);
    zscore = (cell-mu)/sig;
%     zscore_norm = zscore/max(abs(zscore));
    zscores=[zscores; zscore];
    res_zscore = mean(zscore(601:3600));
    m = res_zscore;
%     if(max(res_zscore)>abs(min(res_zscore)))
%         m = max(res_zscore);
%     else
%         m = min(res_zscore);
%     end
%     
    if m>1
        clust_act = [clust_act; zscore];
    elseif m<-1
        clust_inh = [clust_inh; zscore];
    else
        clust_no_res=[clust_no_res; zscore];
    end

end
%% pie chart
act_color = [0/255 86/255 191/255];
inh_color = [255/255, 73/255, 56/255];
no_res_color = [0.5 0.5 0.5];

population = [size(clust_act,1); size(clust_inh,1); size(clust_no_res,1)];
total = sum(population);
act = sprintf('activated (%d%%)',floor(population(1)/total*100));
inh = sprintf('inhibited (%d%%)',floor(population(2)/total*100));
nores = sprintf('no responsive (%d%%)',floor(population(3)/total*100));

figure;
labels={act,inh,nores};
p = pie(population,labels);


newColors = [inh_color;no_res_color; act_color];
patchHand = findobj(p, 'Type', 'Patch'); 
% Set the color of all patches using the nx3 newColors matrix
set(patchHand, {'FaceColor'}, mat2cell(newColors, ones(size(newColors,1),1), 3))
% Or set the color of a single wedge
 

%% avg plot
avgplot(clust_inh,[0/255 86/255 191/255],120);
avgplot(clust_act,[255/255, 73/255, 56/255],120);
avgplot(clust_no_res,[0.5 0.5 0.5],120);
avgplot(zscores,[0.5 0.5 0.5],120);

%% 
