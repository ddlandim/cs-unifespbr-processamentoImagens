clc
close all
clear all

 %imagem original
 img0 = imread('0.jpg');
 img1 = imread('1.jpg'); 
 img2 = imread('2.jpg'); 
 img3 = imread('3.jpg'); 
 img4 = imread('4.jpg');
 img5 = imread('5.jpg');
 img6 = imread('6.jpg');
 img7 = imread('7.jpg');
 img8 = imread('8.jpg');
 img9 = imread('9.jpg');

 img = rgb2gray(img0);
 %img = imresize(img,[300 900]);
 figure;
 colormap(gray);
 imagesc(img);
 title('Imagem Original em escala de cinza');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1A ETAPA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FILTRAGEM DE RUÍDO NA IMAGEM NÃO BINARIZADA
%FILTRO DA MEDIANA
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

 img_etapa1 = img_med;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2A ETAPA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%BINARIZAÇÃO DA IMAGEM FILTRADA COM OTSU UTILIZANDO 1 LIMIAR
 [img_bin,limiarGlobal] = otsu1(img_etapa1);

%INVERTENDO A IMAGEM BINARIZADA
 img_bin = ~img_bin;
 figure;
 colormap(gray);
 imagesc(img_bin);
 title(['Binarização por Otsu com Limiar Global = ',num2str(limiarGlobal), 'imagem invertida']);

 img_etapa2 = img_bin;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3A ETAPA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FILTRAGEM DE BURACOS E ELEMENTOS NÃO INTERESSANTES NA IMAGEM BINARIZADA

%ESCOLHA DE UM ELEMENTO ESTRUTURAMENTE
 elemento_estruturante_filtro = strel('square',5);
 %figure;
 %colormap(gray);
 %imagesc(getnhood(elemento_estruturante));
 %title('Elemento Estruturante');

%OPERAÇÃO MORFOLÓGICA DE FECHAMENTO COM O ELEMENTO ESCOLHIDO
 n_fil_fec = 3;
 img_bin_filtrada = fechamento(img_etapa2,elemento_estruturante_filtro,n_fil_fec);
 figure;
 colormap(gray);
 imagesc(img_bin_filtrada);
 title(['Imagem com ', num2str(n_fil_fec), ' fechamento(s)']);

 img_etapa3 = img_bin_filtrada;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 4A ETAPA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MANTENDO APENAS 0S 7 MAIORES COMPONENTES CONEXOS:
%
%AQUI INFERE-SE QUE OS 7 MAIORES COMPONENTES CONEXOS, OU SEJA OS
%OBJETOS DA IMAGEM QUE APRESENTAM OS MAIORES AGRUPAMENTOS DE PIXELS SÃO AS 3
%LETRAS E 4 NUMEROS DAS PLACAS

%ESTE PROCESSO PODE FALHAR SE A IMAGEM BINARIZADA DA PLACA TIVER GRANDES BORDAS OU
%CONTORNOS DA PROPRIA PLACA

 n_maiores = 7;
 img_seg_cc = bwareafilt(img_etapa3,n_maiores);
 figure
 colormap(gray);
 imagesc(img_seg_cc);
 title(['Imagem com os ', num2str(n_maiores), ' maiores componentes conexos']);

 img_etapa4 = img_seg_cc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 5A E ULTIMA ETAPA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NESTA ETAPA A SEGMENTAÇÃO DEVE ESTAR CONCLUÍDA CONSTANDO APENAS OS OBJETOS DE INTERESSE DO PROCESSO DE
% SEGMENTAÇÃO. 
%
% É ESCOLHIDO 1 ELEMENTO ESTRUTURANTE PARA EXTRAÇÃO DA BORDA DOS OBJETOS SEGMENTADOS,
% COM A BORDA EXTRAÍDA SÃO OBTIDAS AS MÉTRICAS DE DICE E JACCARD DO PROCESSO
% DE SEGMENTAÇÃO.
% 
% A PARTIR DAS BORDAS, É POSSÍVEL OBTER DESCRITORES DOS OBJETOS.
% COM OS DESCRITORES É POSSÍVEL INICIAR O PROCESSO DE VISÃO COMPUTACIONAL
% PARA RECONHECIMENTO E TRATAMENTO DO OBJETO.

 elemento_estruturante_grad = strel('disk',1);
 %figure;
 %colormap(gray);
 %imagesc(getnhood(elemento_estruturante));
 %title('Elemento Estruturante');

 grad_interno = img_etapa4 - erosao(img_etapa4,elemento_estruturante_grad);
 %figure;
 %colormap(gray);
 %imagesc(grad_interno);
 %title(['Gradiente interno']);

 grad_externo = dilatacao(img_etapa4,elemento_estruturante_grad) - img_etapa4;
 %figure;
 %colormap(gray);
 %imagesc(grad_externo);
 %title(['Gradiente externo']);

 grad_morfologico = grad_externo - grad_interno;
 figure;
 colormap(gray);
 imagesc(grad_morfologico);
 title(['Gradiente morfologico']);

 [Dice,Jaccard,x,y] = dice_jaccard_plot(img,img_etapa4,grad_morfologico);

 figure
     imshow(img);
 hold on
     plot(y,x,'.g','LineWidth',2);
 title( ['Imagem final segmentada, métricas: Dice = ',num2str(Dice),' Jaccard = ',num2str(Jaccard)] );