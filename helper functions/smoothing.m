close all
% figure; plot(Lfilter);
pks = find(Lfilter2>1);
startInfusion = pks(1);

stemY = zeros(1,length(pks))+1;
stemYY = zeros(1,length(pks))-1;

figure; 
 
 
Bends = pks(find(diff(pks)>3*FL));
Bstarts = pks(find(diff(pks)>3*FL)+1);
 
 
adjust = startInfusion-5*60*FL;
for s=1:length(Bstarts)+1
    bstart = Bstarts(s)-adjust;
    bend = Bends(s+1)-adjust;
    hold on;
    h=area([bstart,bend],[1,1],'LineStyle','none');
%     h.FaceColor=[235/255 189/255 70/255];
    h.FaceColor=[21/255 144/255 166/255];

end


xlim([0*60*FL 50*60*FL]);
xticks([0*60*FL:5*60*FL:50*60*FL]);
xticklabels([-5:5:45]);


 % stem(pks,stemYY,'b','Marker','none');
% figure; plot(Lfilter2);
% hold on;
% scatter(startInfusion,[1]);
target = Lfilter(startInfusion-5*60*FL:startInfusion+45*60*FL);
baseline = target(1:5*60*FL);
norm = (target-mean(baseline))/mean(baseline);
% figure; plot(norm);
smoothenNorm = smoothdata(norm,'movmean',10*FL);

% xlim([0*60*FL 50*60*FL]);
figure; plot(smoothenNorm,'k');

xticks([0*60*FL:5*60*FL:50*60*FL]);
xticklabels([-5:5:45]);
box off;
 
ylim([-0.1 0.1]);