function []= avgplot(array,color,start)
    mu = mean(array,1);
    sig = std(array,1,1);
     
    x=[1:size(array,2)];
    figure;
shadedErrorBar(x,mu, sig,'lineprops',{'Color',color},'transparent',1);
    hold on;
    line([start*5 start*5], [floor(min(mu)-min(sig)-1) ceil(max(mu)+max(sig)+1)],'LineStyle','--','LineWidth',1,'Color','k'); 
    ylabel('avg zscore');
    xlabel('time(s)')
    xticks(1:start*5:size(array,2))
    xticklabels(num2cell([-start:start:(size(array,2)-start*5)/5]))
    ylim([floor(min(mu)-min(sig)-1) ceil(max(mu)+max(sig)+1)])
    xlim([0 size(array,2)])
end