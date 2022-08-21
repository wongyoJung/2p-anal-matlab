v = VideoReader('F:\videofile\190225_two choice_avi\0225_174626_bi8_Hab2.avi');
nFrames = v.Duration*v.FrameRate;
H=100;
Name='test';
% b = VideoWriter(strcat(Name,'.avi'));
% open(b);
for i = 5800:5:6540
    img = read(v,i);
    image(img);
    s=floor(i/30)+3;
    LickA=strcat('LEFT : ' , sprintf('%d',y(s)));
    x(s)
    LickB=strcat('RIGHT : ' , sprintf('%d',z(s)));
    text1 = text(50,H,LickA,'Color','w','FontSize',10);
    text2 = text(50,H-35,LickB,'Color','w','FontSize',10);
    if (y(s)~=y(s-1))
        delete(text1);
        text1 = text(50,H,LickA,'Color','y','FontSize',15,'FontWeight','bold'); 
       
    elseif (z(s)~=z(s-1))
         delete(text2);
         text2 = text(50,H-35,LickB,'Color','y','FontSize',15,'FontWeight','bold');   
    
    end
        
    box off;
    axis off;
    frame=getframe(gcf);
%     writeVideo(b,frame);
end
% close(b);