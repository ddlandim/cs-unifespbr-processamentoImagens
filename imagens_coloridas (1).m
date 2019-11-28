close all
clear all
img = double(imread('lenna.tiff'))/255;
[l,c,d] = size(img);

%RGB 2 HSI
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

%I = 1/3*(R+G+B)
I = (R+G+B)/3;
for x = 1:l 
    for y = 1:c
        r = R(x,y);
        g = G(x,y);
        b = B(x,y);

        %--S = 1-(min(R,G,B)/I)
        if (I(x,y)==0) S(x,y) = 1;
            else  S(x,y) = 1 - ( min( min(r,g),b) ) / I(x,y) ;
        end
        
        %--H
        %---indefinido se S=0
        if (S(x,y) == 0) H(x,y) = 0;
        
        %--theta
        else
                aux1 = (0.5*((r-g)+(r-b)))
                aux2 = sqrt( (r-g)^2 + ((r-g)*(g-b)) );
                
                if(aux2~=0)
                    aux3 = aux1/aux2;
                    theta = acosd(aux3);
                end
                
                %theta calculado

                %Calculando H
                if(b<=g) H(x,y) = theta;
                    else H(x,y) = 360-theta;
                end
        end
    end
end

%H/360, convertendo H para o dominio de 0 a 1
H = H/360;

% H, S, I finalizados.

figure;
imagesc(H);
colormap(gray);
title('H');

figure;
imagesc(S);
colormap(gray); 
title('S');

figure;
imagesc(I); 
colormap(gray);
title('I');

%INVERSA HSI PARA RGB
%Convertendo H para o domínio de 0 a 360.
H_rgb = H*180;

%Setor RG: se 0 <= H <= 120