function result = alignFirstLick(data,firstlick,bef,aft)
%     firstlick, bef, aft should be frame (Hz)
    result = data(:,firstlick-bef:firstlick+aft);
end
