close all
clear all
img = double(imread('lenna.tiff'))/255;
[l,c,d] = size(img);

%RGB 2 HSI
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

img_hsi = img;

%I = 1/3*(R+G+B)
img_hsi(:,:,3) = (R+G+B)/3;
I = img_hsi(:,:,3);

for x = 1:l 
    for y = 1:c
        r = R(x,y);
        g = G(x,y);
        b = B(x,y);
        %S = 1-(min(R,G,B)/I)
        if (I(x,y)==0) img_hsi(x,y,2) = 1;
            else  img_hsi(x,y,2) = 1 - ( min( min(r,g),b) ) / I(x,y) ;
        end
        
        %H
        if (img_hsi(x,y,2) == 0) img_hsi(x,y,1) = 0;
        else
                aux = ( (r-g)^2 + ( (r-g)*(g-b) ))^0.5;
                if(aux~=0)
                    theta = acos( (0.5*( (r-g)+(r-b))) / aux);
                end
                theta = pi/2;
                if(b<=g) img_hsi(x,y,1) = theta;
                    else img_hsi(x,y,1) = (2*pi)-theta;
                end
        end
    end
end

%H/360
img_hsi(:,:,1) = img_hsi(:,:,1)/(2*pi);

figure;
imagesc(img_hsi(:,:,1));

colormap(gray);title('H');

figure;
imagesc(img_hsi(:,:,2));

colormap(gray); title('S');

figure;
imagesc(img_hsi(:,:,3)); 
colormap(gray);
title('I');

%INVERSA HSI PARA RGB
img_rgb = img_hsi;
%Convertendo H de Rad para Graus
img_rgb(:,:,3) = img_rgb(:,:,3)*180;

H = img_hsi(:,:,1);
S = img_hsi(:,:,2);
I = img_hsi(:,:,3);

%Setor RG: se 0 <= H <= 120
for x = 1:l 
    for y = 1:c
        
        h = H(x,y);
        s = S(x,y);
        i = I(x,y);
        
        r = 
        %S = 1-(min(R,G,B)/I)
        if (I(x,y)==0) img_hsi(x,y,2) = 1;
            else  img_hsi(x,y,2) = 1 - ( min( min(r,g),b) ) / I(x,y) ;
        end
        
        %H
        if (img_hsi(x,y,2) == 0) img_hsi(x,y,1) = 0;
        else
                aux = ( (r-g)^2 + ( (r-g)*(g-b) ))^0.5;
                if(aux~=0)
                    theta = acos( (0.5*( (r-g)+(r-b))) / aux);
                end
                theta = pi/2;
                if(b<=g) img_hsi(x,y,1) = theta;
                    else img_hsi(x,y,1) = (2*pi)-theta;
                end
        end
    end
end





