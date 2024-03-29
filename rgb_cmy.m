function[img_out] = rgb_cmy(img)

img1 = double(img)/255;

R = img1(:,:,1);
G = img1(:,:,2);
B = img1(:,:,3);

% CONVERSAO PARA CMI
C = 1-R;
M = 1-G;
Y = 1-B;
CMY = cat(3,C,M,Y);

img_out = CMY;