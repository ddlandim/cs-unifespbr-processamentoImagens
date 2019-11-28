close all
clear all

img_rgb_o = imread('lenna.tiff');
R = img_rgb_o(:,:,1);
G = img_rgb_o(:,:,2);
B = img_rgb_o(:,:,3);

figure;
imagesc(img_rgb_o);
title('IMAGEM ORIGINAL');

% CONVERSAO RGB PARA HSI
img_hsi_o = rgb_hsi(img_rgb_o);
H = img_hsi_o(:,:,1);
S = img_hsi_o(:,:,2);
I = img_hsi_o(:,:,3);

figure;
imagesc(H);
colormap(gray);
title('H ORIGINAL');

figure;
imagesc(S);
colormap(gray); 
title('S ORIGINAL');

figure;
imagesc(I); 
colormap(gray);
title('I ORIGINAL');

% CONFERINDO A INVERSA HSI - RGB
figure;
imagesc(hsi_rgb(img_hsi_o)); 
title('RGB RECUPERADA DO HSI');

% CONVERSAO PARA CMY
img_cmy_o = rgb_cmy(img_rgb_o);
C = img_cmy_o(:,:,1);
M = img_cmy_o(:,:,2);
Y = img_cmy_o(:,:,3);

figure;
imagesc(C);
colormap(gray);
title('C');

figure;
imagesc(M);
colormap(gray); 
title('M');

figure;
imagesc(Y); 
colormap(gray);
title('Y');

% EQUALIZAÇÃO DE HISTOGRAMA NO ESPAÇO DE CORES HSI
I_eq = uint8(I*255);
I_eq = histograma_eq(I_eq);
I_eq = double(I_eq)/255;

figure;
imagesc(I_eq);
colormap(gray);
title('CAMADA I EQUALIZADA');

img_hsi_eq = cat(3,H,S,I_eq);
img_hsi_eq_rgb = hsi_rgb(img_hsi_eq);

figure;
imagesc(img_hsi_eq_rgb);
title('INVERSA DE HSI EQUALIZADA EM I PARA RGB');

% DEFINIÇÕES DAS JANELAS DE REALCE

janela = 3;

% REALCE PELA MEDIANA NO ESPAÇO DE CORES RGB

R_med = mediana(R,janela);
G_med = mediana(G,janela);
B_med = mediana(B,janela);
img_rgb_med = cat(3,R_med,G_med,B_med);
figure;
imagesc(img_rgb_med);
title('RGB COM REALCE DE MEDIANA EM R,G,B COM JANELA 3');

% REALCE PELA MEDIANA NO ESPAÇO DE CORES cmy
C_med = mediana(C,janela);
M_med = mediana(M,janela);
Y_med = mediana(Y,janela);

figure;
imagesc(C_med);
colormap(gray);
title('C COM REALCE DE MEDIANA');

figure;
imagesc(M_med);
colormap(gray); 
title('M COM REALCE DE MEDIANA');

figure;
imagesc(Y_med); 
colormap(gray);
title('Y COM REALCE DE MEDIANA');
img_cmy_med = cat(3,C_med,M_med,Y_med);

img_cmy_med_rgb = cmy_rgb(img_cmy_med);

figure;
imagesc(img_cmy_med_rgb); 
title('RGB COM REALCE DE MEDIANA EM C,M,Y COM JANELA 3');

% REALCE PELA MEDIANA NO ESPAÇO DE CORES HSI

I_med = mediana(I,janela);
figure;
imagesc(I_med);
colormap(gray);
title('CAMADA I COM REALCE DE MEDIANA COM JANELA 3');

img_hsi_med = cat(3,H,S,I_med);
img_hsi_med_rgb = hsi_rgb(img_hsi_med);

figure;
imagesc(img_hsi_med_rgb); 
title('INVERSA DE HSI COM REALCE DE MEDIANA COM JANELA 3 NA CAMADA I PARA RGB');



