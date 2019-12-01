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

img = imagem;
n = janela;

[linha,coluna] = size(img);
x = zeros(linha,coluna);
vector_n = n*n;
vetor = zeros(1,vector_n);

for i = 1:linha
    for j = 1:coluna
        if(i-n > 0 && j-n >0 && j+n <= coluna && i+n <= linha)
           indice = 1;
           for a = i-n:i+n
               for b = j-n:j+n
                   vetor(1,indice) = img(a,b);
                   if(indice < vector_n) 
                       indice = indice+1;
                   end
               end
           end
           vetor = sort(vetor);
           x(i,j) = vetor( 1 , round((n^2)/2) );
        else
            x(i,j) = img(i,j);
        end
    end
end

figure;
colormap(gray);
imagesc(x);
title('Filtro da Mediana com janela %d na imagem original');