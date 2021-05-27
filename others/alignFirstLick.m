function result = alignFirstLick(data,firstlick,fr)
    bef = fr*60*5;
    aft = fr*60*10;
    result = data(:,firstlick*fr-bef:firstlick*fr+aft);
    
end
