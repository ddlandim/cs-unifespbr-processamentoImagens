clc
close all
clear all

%imresize
%imnoise
load imgfildata;
[arquivo,caminho] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
path_file = [caminho,arquivo];
img = imread(path_file);
img = imresize(imagem,[300 900]);
img = rgb2gray(imagem);

figure;
colormap(gray);
imagesc(img);
title('Imagem Original em escala de cinza');

[sizey,sizex] = size(img);

%aplicando filtro da mediana na imagem original
janela = 5;
img_med = mediana(img,janela);
figure;
colormap(gray);
imagesc(img_med);
title(['Filtro da Mediana com janela ',num2str(janela),' na imagem original']);

[img_med_hist,pmax,pmin] = histograma(img_med);
stem(0:255, img_med_hist);
grid on; 
ylabel('Frequencia do pixel --->'); 
xlabel('Intensidade --->'); 
title('HISTOGRAMA');

%binarizando com otsu em 1 limiar
[img_seg,limiarGlobal] = otsu1(img_med);
%invertendo imagem segmentada
img_seg = ~img_seg;
figure;
colormap(gray);
imagesc(img_seg);
title(['Segmentação Invertida por Otsu com Limiar Global = ',num2str(limiarGlobal)]);

n_maiores = 7;
img_seg_cc = bwareafilt(img_seg,n_maiores);
figure
colormap(gray);
imagesc(img_seg_cc);
title(['Imagem com os ', num2str(n_maiores), ' maiores componentes conexos']);

elemento_estruturante = strel('disk',1);
figure;
colormap(gray);
imagesc(getnhood(elemento_estruturante));
title('Elemento Estruturante');

n_fec = 1;
img_fec = fechamento(img_seg_cc,elemento_estruturante,n_fec);
figure;
colormap(gray);
imagesc(img_fec);
title(['Imagem com ', num2str(n_fec), ' fechamento(s)']);

img_2 = img_fec;

grad_interno = img_2 - erosao(img_2,elemento_estruturante);
figure;
colormap(gray);
imagesc(grad_interno);
title(['Gradiente interno']);

grad_externo = dilatacao(img_2,elemento_estruturante) - img_2;
figure;
colormap(gray);
imagesc(grad_externo);
title(['Gradiente externo']);

grad_morfologico = grad_externo - grad_interno;
figure;
colormap(gray);
imagesc(grad_morfologico);
title(['Gradiente morfologico']);