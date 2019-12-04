clc
close all
clear all

imagens{1} = '0.jpg';
imagens{2} = '1.jpg';
imagens{3} = '2.jpg';
imagens{4} = '3.jpg';
imagens{5} = '4.jpg';
imagens{6} = '5.jpg';
imagens{7} = '6.jpg';
imagens{8} = '7.jpg';
imagens{9} = '8.jpg';
imagens{10} = '9.jpg';

debug = false;
for i = 2:2
 %imagem original
 img = rgb2gray(imread(imagens{i}));
 %img = imresize(img,[300 900]);
 figure;
 colormap(gray);
 imagesc(img);
 title(['Imagem ', num2str(i), '.jpg original em escala de cinza']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1A ETAPA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FILTRAGEM DE RU�DO NA IMAGEM N�O BINARIZADA
%FILTRO DA MEDIANA
 janela = 5;
 img_med = mediana(img,janela);
 if(debug)
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
 end
 img_etapa1 = img_med;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2A ETAPA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%BINARIZA��O DA IMAGEM FILTRADA COM OTSU UTILIZANDO 1 LIMIAR
 [img_bin,limiarGlobal] = otsu1(img_etapa1);

%INVERTENDO A IMAGEM BINARIZADA
 img_bin = ~img_bin;
 if(debug)
    figure;
    colormap(gray);
    imagesc(img_bin);
    title(['Binariza��o por Otsu com Limiar Global = ',num2str(limiarGlobal), 'imagem invertida']);
 end
 img_etapa2 = img_bin;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3A ETAPA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FILTRAGEM DE BURACOS E ELEMENTOS N�O INTERESSANTES NA IMAGEM BINARIZADA

%ESCOLHA DE UM ELEMENTO ESTRUTURAMENTE
 nome_elemento = 'square';
 tam_elem = 15;
 elemento_estruturante_filtro = strel(nome_elemento,tam_elem);
 %figure;
 %colormap(gray);
 %imagesc(getnhood(elemento_estruturante));
 %title('Elemento Estruturante');

%OPERA��O MORFOL�GICA COM O ELEMENTO ESCOLHIDO
 n_op = 3;
 img_bin_filtrada = abertura(img_etapa2,elemento_estruturante_filtro,n_op);
 figure;
 colormap(gray);
 imagesc(img_bin_filtrada);
 title(['Imagem com ', num2str(n_op), ' operacoes(s) e elemento estruturante = ', nome_elemento, ' tamanho ', num2str(tam_elem)]);

 img_etapa3 = img_bin_filtrada;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 4A ETAPA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MANTENDO APENAS 0S 7 MAIORES COMPONENTES CONEXOS:
%
%AQUI INFERE-SE QUE OS 7 MAIORES COMPONENTES CONEXOS, OU SEJA OS
%OBJETOS DA IMAGEM QUE APRESENTAM OS MAIORES AGRUPAMENTOS DE PIXELS S�O AS 3
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
% NESTA ETAPA A SEGMENTA��O DEVE ESTAR CONCLU�DA CONSTANDO APENAS OS OBJETOS DE INTERESSE DO PROCESSO DE
% SEGMENTA��O. 
%
% � ESCOLHIDO 1 ELEMENTO ESTRUTURANTE PARA EXTRA��O DA BORDA DOS OBJETOS SEGMENTADOS,
% COM A BORDA EXTRA�DA S�O OBTIDAS AS M�TRICAS DE DICE E JACCARD DO PROCESSO
% DE SEGMENTA��O.
% 
% A PARTIR DAS BORDAS, � POSS�VEL OBTER DESCRITORES DOS OBJETOS.
% COM OS DESCRITORES � POSS�VEL INICIAR O PROCESSO DE VIS�O COMPUTACIONAL
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
 if(debug)
     figure;
     colormap(gray);
     imagesc(grad_morfologico);
     title(['Gradiente morfologico']);
 end
 [Dice,Jaccard,x,y] = dice_jaccard_plot(img,img_etapa4,grad_morfologico);

 figure
     imshow(img);
 hold on
     plot(y,x,'.g','LineWidth',2);
 title( ['Imagem final segmentada, m�tricas: Dice = ',num2str(Dice),' Jaccard = ',num2str(Jaccard)] );
end