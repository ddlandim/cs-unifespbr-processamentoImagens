clc
close all
clear all

%imagem original
imagem = rgb2gray(imread('triangulo.jpg'));
imagem = imagem < 200;
figure;
colormap(gray);
imagesc(imagem);
title('Imagem Original em escala de cinza');

[linha,coluna] = size(imagem);
[idx,idy] = find(imagem>0,1);

%ponto encontrado
figure;
colormap(gray);
imagesc(imagem);
hold on
    plot(idy,idx,'or');
hold off
title('Ponto encontrado');


%imagemContorno = erosao(image,'disk',1);
imagemContorno = imagem - imerode(imagem,strel('disk',1));
figure;
colormap(gray);
imagesc(imagemContorno);
title('Imagem somente borda');

codigo_cadeia = [-1,idx,idy];
x = idx;
y = idy;

%1a vareddura abaixo, val_cadeia = 3
y = y-1;

while(x ~= idx || y~= idy)
        if( imagemContorno(x+1,y) == 1)
            val_cadeia = 0;
            x = x+1;
            codigo_cadeia = [codigo_cadeia; val_cadeia, x, y];
        end
        
        if(
end

    
