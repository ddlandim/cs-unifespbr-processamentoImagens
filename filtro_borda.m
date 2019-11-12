function b = filtro_borda(img,N)
I = double(img);
I = imresize(I, [1024,1024]); 
[l,c] = size(I);

linha = zeros(l,c);
coluna = zeros(l,c);

%seleciona o quadro 
quadro = N;

%calcula media e detalhes
for index = 1:quadro
    
    j = 1;
    for i = 1:l
        for n = 1:2:c 
            linha(i, j) =  ( I(i,n) + I(i,n+1) ) / sqrt(2);
            linha(i,j+(c/2)) = ( I(i,n) - I(i,n+1) ) / sqrt(2);
            j = j + 1;
        end 
        j = 1;
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    j = 1;
    for i = 1:c
        for n = 1:2:c 
            coluna(j, i) =  ( linha(n,i) + linha(n+1,i) ) / sqrt(2);
            coluna(j+(l/2),i) = ( linha(n,i) - linha(n+1,i) ) / sqrt(2);
            j = j + 1;
        end 
        j = 1;
    end
end
b = coluna; 