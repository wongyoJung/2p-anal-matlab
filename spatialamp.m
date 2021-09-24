figure;
% bq = interp2(b,8);

r_e = 2; % Radius for blur
r_d = 6
se = strel('disk', r_e, 0);
sd = strel('disk', r_d, 0);

smallMask = imerode(b, se);
% smallMask = imdilate(smallMask,sd);

image(smallMask,'CDataMapping','scaled');
cb=colorbar;
caxis([-2 2]);

% colap=[0 173 58; 145 25 26; 255 225 255;49 96 235; 173 173 173]/255;
colap=[173 173 173; 49 96 235; 30 30 30; 173 25 26; 0 173 58;]/255;

colormap(colap);
    
box off
    