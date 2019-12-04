clc
close all
clear all

%imagem original
img = imread('placa.png');
img = rgb2gray(img);
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


porcentagem_x = 50;
janela_bwop = round(porcentagem_x/100*sizex);
img_seg_cc = bwareaopen(img_seg, janela_bwop);
figure
colormap(gray);
imagesc(img_seg_cc);
title(['Imagem com remocao de componentes conexos inferiores a', num2str(porcentagem_x), ' % da largura']);

elemento_estruturante = strel('disk',1);
figure;
colormap(gray);
imagesc(getnhood(elemento_estruturante));
title('Elemento Estruturante');

img_ero = erosao(img_seg,elemento_estruturante);
figure;
colormap(gray);
imagesc(img_ero);
title('Erosao');

img_dil = dilatacao(img_seg,elemento_estruturante);
figure;
colormap(gray);
imagesc(img_dil);
title('Dilatacao');

n_abe = 5;
img_abe = abertura(img_seg,elemento_estruturante,n_abe);
figure;
colormap(gray);
imagesc(img_abe);
title(['Imagem com ', num2str(n_abe), ' abertura(s)']);

n_fec = 1;
img_fec = fechamento(img_seg,elemento_estruturante,n_fec);
figure;
colormap(gray);
imagesc(img_fec);
title(['Imagem com ', num2str(n_fec), ' fechamento(s)']);