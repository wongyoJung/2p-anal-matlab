function [cummulLick,countA,countB] = LickTimePickforABATAR(directory,filename,animalID)
fname=horzcat(directory,filename,'.txt');
T =readtable(fname);
select=T{:,2};
time=T{:,3};

A_index = find(strcmp(select,'LickA'));
B_index = find(strcmp(select,'LickB'));

A_time = time(A_index);
B_time = time(B_index);
saveDirectory = 'D:\Two choice\ABATAR\mats\';
Savefile = horzcat(saveDirectory,animalID,'_',filename,'.mat');
save(Savefile,'A_time','B_time');

end

