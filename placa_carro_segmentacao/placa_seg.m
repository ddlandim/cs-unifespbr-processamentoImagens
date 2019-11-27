clc
close all
clear all

%imagem original
imagem = imread('placa.png');
imagem = rgb2gray(imagem);
figure;
colormap(gray);
imagesc(imagem);
title('Imagem Original em escala de cinza');

%aplicando filtro da mediana na imagem original
janela = 5;
imagemFiltrada = mediana(imagem,janela);
figure;
colormap(gray);
imagesc(imagemFiltrada); 
title('Filtro da Mediana com janela %d na imagem original');

%binarizando com otsu em 1 limiar
[imagemBinaria,limiarGlobal] = otsu1(imagemFiltrada);
%invertendo imagem binaria
imagemBinaria = ~imagemBinaria;
figure;
colormap(gray);
imagesc(imagemBinaria);
title('Limiarização Invertida por Otsu com Limiar Global= %d');

%filtrando imagem binária
janela = 5;
imagemBinariaMediana = mediana(imagemBinaria,janela);
figure;
colormap(gray);
imagesc(imagemBinariaMediana);
title('Filtro da Mediana com janela %d na imagem binária');

imagemErodida = ~erosao(imagemBinariaMediana,'disk',10);
figure;
colormap(gray);
imagesc(imagemErodida);
title('Imagem Erodida');

imagemBorda = imagem - uint8(imagemErodida);
figure;
colormap(gray);
imagesc(imagemBorda);
title('Imagem só Borda');

%aplicando filtro da mediana na imagem de borda
janela = 5;
imagemFiltradaBorda = mediana(imagemBorda,janela);
figure;
colormap(gray);
imagesc(imagemFiltradaBorda); 
title('Filtro da Mediana com janela %d na imagem borda');


%pegar os componentes conexos, ordenados
%manter os 7 maiores