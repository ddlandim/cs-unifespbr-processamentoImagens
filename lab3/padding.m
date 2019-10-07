%Autor : Douglas Diniz Landim, ra 76681
%email : ddlandim@unifesp.br

clear all
close all

img = rgb2gray(imread('arvore.jpg'));
[a,l] = size(img);

figure
    imagesc(img),
    colormap(gray), 
title('original');

img2 = [img,zeros(a,l)];
img2 = [img2;zeros(a,2*l)];

figure
    imagesc(img2),
    colormap(gray), 
title('original padding');

[a2,l2] = size(img2);

bloco_filtro = 7;
filtro = ones(bloco_filtro,bloco_filtro);
filtro = (1/bloco_filtro) * filtro;

m1 = zeros(bloco_filtro,l2-bloco_filtro);
m2 = zeros(a2-bloco_filtro,l2);
filtro2  = [[filtro,m1];m2]

figure
    imagesc(filtro2),
    colormap(gray), 
title('filtro');

