function [cummulLick,poke] = cummulPokeDraw(directory,filename,animalID)
filename=horzcat(directory,filename,'.txt');
T =readtable(filename);
select=T{:,2};

poke=length(find(strcmp(select,'Poke')));


time=T{:,3}/1000;

cummulLick=[];
for t=0:1:45*60
      id=find(time<t);
    if isempty(id)
        TimeId=0;
    else
        TimeId=id(end);
    end
    Poke=length(find(strcmp(select(1:TimeId,1),'Poke')));

    cummulLick(t+1,1)=t;
    cummulLick(t+1,2)=Poke;

end

figure;
plot(cummulLick(:,1),cummulLick(:,2),'Color',[0,0.60,0.50],'LineWidth',1.5)
hold on;

legend('nose poke');

poke=cummulLick(end,2);
title(animalID);
end
% v = VideoReader('F:\videofile\190225_two choice_avi\0225_140742_bi4_Hab2.avi');
% nFrames = v.Duration*v.FrameRate;
% for i = 7200:10:8200
%     img = read(v,i);
%     image(img);
%     LickA=strcat('Sucrose: ' , sprintf('%d',y(i+90)));
%     LickB=strcat('Sucralose: ' , sprintf('%d',z(i+90)));
%     text1 = text(100,100,LickA);
%     text2 = text(100,100,LickB);
%     box off;
%     axis off;
% end
