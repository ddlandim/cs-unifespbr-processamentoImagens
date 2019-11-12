%Douglas Diniz Landim
%RA: 76681
%% 1.1 - Lendo imagem original
I_original = imread('lena.tif');
%% 1.2 - Geracao de ruido gaussiano, 5 imagens, passo 0.01 - 0.05
I_gauss1 = double(imnoise(I_original,'gaussian',media(I_original),0.01));
I_gauss2 = double(imnoise(I_original,'gaussian',media(I_original),0.02));
I_gauss3 = double(imnoise(I_original,'gaussian',media(I_original),0.03));
I_gauss4 = double(imnoise(I_original,'gaussian',media(I_original),0.04));
I_gauss5 = double(imnoise(I_original,'gaussian',media(I_original),0.05));
%% 1.3 Acrescente o ruído Salt e Pepper, passo de 0.02, 5 imagens, 0.02-0.10.
I_salt1 = double(imnoise(I,'salt & pepper',0.02));
I_salt2 = double(imnoise(I,'salt & pepper',0.04));
I_salt3 = double(imnoise(I,'salt & pepper',0.06));
I_salt4 = double(imnoise(I,'salt & pepper',0.08));
I_salt5 = double(imnoise(I,'salt & pepper',0.10));
%% 2 - Restauracao e Filtragem - 2.a Filtro Média Simples e 2.b Mediana 
% arquivos media.m e mediana.m anexados, chamar as funcoes media e mediana
% (img, n) com os parametros 'img.extesao' e n para calculo NxN.
%% 2.c Implemente sua propria funcao
%
%
%%  2.d Filtro em Frequência Gaussiano: fc = 3%, 6% e 10% da frequência máxima 
fc = 3; %3%
gauss_freq(img,fc);