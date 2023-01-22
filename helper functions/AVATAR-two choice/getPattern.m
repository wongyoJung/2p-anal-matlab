file=horzcat(directory,filename,'.txt');
T =readtable(file);
Time=T{:,3};

pattern = horzcat(directory,filename,'2Pattern.txt');
fileID = fopen(pattern,'w');
for i=1:length(Time)
    if(i==1)
        formatSpec = '{%d,';
        fprintf(fileID,formatSpec,Time(i));    
    else
        formatSpec = '%d,';
        fprintf(fileID,formatSpec,Time(i));
    end
end

fclose(fileID);
