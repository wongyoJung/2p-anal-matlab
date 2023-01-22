function result = alignFirstLick(data,firstlick,bef,aft)
%     bef = fr*60*5;
%     aft = fr*60*10;
    result = data(:,firstlick-bef:firstlick+aft);
    
end
