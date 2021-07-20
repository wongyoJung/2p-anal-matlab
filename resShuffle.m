function[x,y]= resShuffle(x,y)

if(length(y)>length(x))
    x_id = randsample(length(x),round(length(x)/2));
    y_id = randsample(length(y),round(length(x)/2));
    tmp =  x(x_id);
    x(x_id) = y(y_id);
    y(y_id) = tmp;

else
    x_id = randsample(length(x),round(length(y)/2));
    y_id = randsample(length(y),round(length(y)/2));
    tmp =  x(x_id);
    x(x_id) = y(y_id);
    y(y_id) = tmp;
end
