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


img = imagemSegmentada;

elemento_estruturante =  getnhood(strel('disk',1));	 
[P, Q] = size(elemento_estruturante); 
img_erodida=zeros(size(img, 1), size(img, 2)); 

for i=ceil(P/2):size(img, 1)-floor(P/2) 
	for j=ceil(Q/2):size(img, 2)-floor(Q/2) 
		on=img(i-floor(P/2):i+floor(P/2), j-floor(Q/2):j+floor(Q/2)); 
		n_vizinhos=on(logical(elemento_estruturante)); 	
		img_erodida(i, j)=min(n_vizinhos(:));	 
	end
end

figure;
colormap(gray);
imagesc(img_erodida);
title('img_erodida');
