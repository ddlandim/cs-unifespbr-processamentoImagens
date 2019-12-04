clc
close all
clear all

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
        
        if( imagemContorno(x+1,y+1) == 1)
            val_cadeia = 1;
            x = x+1;
            y = y+1;
            codigo_cadeia = [codigo_cadeia; val_cadeia, x, y];
        end
        
        if( imagemContorno(x,y+1) == 1)
            val_cadeia = 2;
            x = x;
            y = y+1;
            codigo_cadeia = [codigo_cadeia; val_cadeia, x, y];
        end
        
        if( imagemContorno(x-1,y+1) == 1)
            val_cadeia = 3;
            x = x-1;
            y = y+1;
            codigo_cadeia = [codigo_cadeia; val_cadeia, x, y];
        end
end