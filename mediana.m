function[x] = mediana(img, n)

[linha,coluna] = size(img);
x = zeros(linha,coluna);
vetor = zeros(1,(n^2));

for i = 1:linha
    for j = 1:coluna
        if(i-n > 0 && j-n >0 && j+n <= coluna && i+n <= linha)
           indice = 1;
           for a = i-n:i+n
               for b=j-n:j+n
                   vetor(indice) = img(a,b);
                   indice = indice+1;
               end
           end
           vetor = sort(vetor);
           x(i,j) = vetor(round((n^2),2));
        else
            x(i,j) = img(i,j);
        end
    end
end

return;