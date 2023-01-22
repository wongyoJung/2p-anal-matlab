x = Data(:,1);
y= Data(:,2);
f=fit(x,y,'poly1')
plot(f,x,y,'o')