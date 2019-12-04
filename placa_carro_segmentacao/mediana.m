function[x] = mediana(img, n)
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

return;