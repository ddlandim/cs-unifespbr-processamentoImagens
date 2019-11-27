%arquivo para teste de funções.

close all
clear all

img = imread('lenna.tiff');

img2 = rgb2gray(img);

figure;
imagesc(img2);
colormap(gray); 
title('ORIGINAL EM rgb2gray');

figure;
imagesc(histograma_eq(img2));
colormap(gray);
title('EQUALIZADA');

figure;
imagesc(mediana(img2,2));
colormap(gray);
title('MEDIANA');