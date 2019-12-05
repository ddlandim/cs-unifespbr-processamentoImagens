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
imagens{11} = 'frd4486.jpg';

debug = true;
debug_hist = false;

start = 1;
n = 11;
img_seg_out = cell(n, 5);

for i = start:n
 %imagem original
 img = rgb2gray(imread(imagens{i}));
 %img = imresize(img,[300 900]);
 %figure;
 %colormap(gray);
 %imagesc(img);
 %title(['Imagem ', num2str(i), '.jpg original em escala de cinza']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1A ETAPA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FILTRAGEM DE RU�DO NA IMAGEM N�O BINARIZADA
%FILTRO DA MEDIANA
 in1 = img;
 janela = 5;
 img_med = mediana(in1,janela);
 if(debug)
     figure;
     colormap(gray);
     imagesc(img_med);
     title(['Filtro da Mediana com janela ',num2str(janela),' na imagem original']);
 end
 if(debug_hist)
     [img_med_hist,pmax,pmin] = histograma(img_med);
     stem(0:255, img_med_hist);
     grid on; 
     ylabel('Frequencia do pixel --->'); 
     xlabel('Intensidade --->'); 
     title('HISTOGRAMA');
 end
 img_seg_out{i}{1} = img_med;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2A ETAPA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
in2 = img_seg_out{i}{1};
%BINARIZA��O DA IMAGEM FILTRADA COM OTSU UTILIZANDO 1 LIMIAR
 [img_bin,limiarGlobal] = otsu1(in2);

%INVERTENDO A IMAGEM BINARIZADA
 img_bin = ~img_bin;
 if(debug)
    figure;
    colormap(gray);
    imagesc(img_bin);
    title(['Binariza��o por Otsu com Limiar Global = ',num2str(limiarGlobal), 'imagem invertida']);
 end
img_seg_out{i}{2} = img_bin;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3A ETAPA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FILTRAGEM DE BURACOS E ELEMENTOS N�O INTERESSANTES NA IMAGEM BINARIZADA
in3 = img_seg_out{i}{2};
%ESCOLHA DE UM ELEMENTO ESTRUTURAMENTE
 nome_elemento = 'square';
 tam_elem = 5;
 elemento_estruturante_filtro = strel(nome_elemento,tam_elem);
 %figure;
 %colormap(gray);
 %imagesc(getnhood(elemento_estruturante));
 %title('Elemento Estruturante');

%OPERA��O MORFOL�GICA COM O ELEMENTO ESCOLHIDO
 n_op = 3;
 img_bin_filtrada = abertura(in3,elemento_estruturante_filtro,n_op);
 figure;
 colormap(gray);
 imagesc(img_bin_filtrada);
 title(['Imagem ', imagens{i} ,'  com ', num2str(n_op), ' operacoes(s) e elemento estruturante = ', nome_elemento, ' tamanho ', num2str(tam_elem)]);

img_seg_out{i}{3} = img_bin_filtrada;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 4A ETAPA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MANTENDO APENAS 0S 7 MAIORES COMPONENTES CONEXOS:
%
%AQUI INFERE-SE QUE OS 7 MAIORES COMPONENTES CONEXOS, OU SEJA OS
%OBJETOS DA IMAGEM QUE APRESENTAM OS MAIORES AGRUPAMENTOS DE PIXELS S�O AS 3
%LETRAS E 4 NUMEROS DAS PLACAS

%ESTE PROCESSO PODE FALHAR SE A IMAGEM BINARIZADA DA PLACA TIVER GRANDES BORDAS OU
%CONTORNOS DA PROPRIA PLACA
in4 = img_seg_out{i}{3};
 
 n_maiores = 7;
 img_seg_cc = bwareafilt(in4,n_maiores);
 if(debug)
     figure
     colormap(gray);
     imagesc(img_seg_cc);
     title(['Imagem  ', imagens{i} ,' com os ', num2str(n_maiores), ' maiores componentes conexos']);
 end

 img_seg_out{i}{4} = img_seg_cc;
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
in5 = img_seg_out{i}{4};
 elemento_estruturante_grad = strel('disk',1);
 %figure;
 %colormap(gray);
 %imagesc(getnhood(elemento_estruturante));
 %title('Elemento Estruturante');

 grad_interno = in5 - erosao(in5,elemento_estruturante_grad);
 %figure;
 %colormap(gray);
 %imagesc(grad_interno);
 %title(['Gradiente interno']);

 grad_externo = dilatacao(in5,elemento_estruturante_grad) - in5;
 %figure;
 %colormap(gray);
 %imagesc(grad_externo);
 %title(['Gradiente externo']);

 
 grad_morfologico = grad_externo - grad_interno;
 if(debug)
     figure;
     colormap(gray);
     imagesc(grad_morfologico);
     title(['Gradiente morfologico ', imagens{i} ,' ']);
 end
 [Dice,Jaccard,x,y] = dice_jaccard_plot(img,in5,grad_morfologico);

 figure
     imshow(img);
 hold on
     plot(y,x,'.g','LineWidth',2);
 title( ['Imagem ', imagens{i} ,' final segmentada, m�tricas: Dice = ',num2str(Dice),' Jaccard = ',num2str(Jaccard)] );
 img_seg_out{i}{5} = grad_morfologico;
end
