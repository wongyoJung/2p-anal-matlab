function [preference] = tuningPreference(data1,data2,bef);
meanRes1 = mean(data1(:,bef:bef+10*5*60),2);
meanRes2 = mean(data2(:,bef:bef+10*5*60),2);

preference = (abs(meanRes1)-abs(meanRes2))./(abs(meanRes1)+abs(meanRes2));
histogram(preference,10);
end
