%Algoritmo de transformacoes geometricas
%Autor : Douglas Diniz Landim, ra 76681
%email : ddlandim@unifesp.br

im_in = imread('in.jpg');
im_out = zeros(l,a);

[l,a] = size(im_in);

dx = 5;
dy = 5;

Matriz_Translacao = [1 0 -dx;
                     0 1 -dy;
                     0 0   1 ];

Matriz_Transformacao = Matriz_Translacao;

for i = 1 : l
    for j = 1 : a
        Matriz_Resultante = round(Matriz_Transformacao*[i;j;1]);
        x = Matriz_Resultante(1,1);
        y = Matriz_Resultante(2,1);
        if (1 <= x && x <= l && 1 <= y && y <= a)
            im_out(i,j) = im_in(x,y);
        end
    end
end

imshow(uint8(im_out));



