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
[imagemSegmentada,limiarGlobal] = otsu1(imagemFiltrada);
%invertendo imagem segmentada
imagemSegmentada = ~imagemSegmentada;
figure;
colormap(gray);
imagesc(imagemSegmentada);
title('Segmentação Invertida por Otsu com Limiar Global= %d');

imagemErodida = ~erosao(imagemSegmentada,'disk',1);
figure;
colormap(gray);
imagesc(imagemErodida);
title('Imagem Segmentada Erodida');

imagemContorno = imagemSegmentada - imagemErodida;
figure;
colormap(gray);
imagesc(imagemContorno);
title('Imagem só Contorno');

%pegar os componentes conexos, ordenados
%manter os 7 maiores