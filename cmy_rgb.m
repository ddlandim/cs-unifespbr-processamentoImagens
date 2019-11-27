function[img_out] = cmy_rgb(img)

img1 = double(img)/255;

C = img1(:,:,1);
M = img1(:,:,2);
Y = img1(:,:,3);

% CONVERSAO PARA CMI
R = 1-C;
G = 1-M;
B = 1-Y;
RGB = cat(3,R,G,B);

img_out = RGB;