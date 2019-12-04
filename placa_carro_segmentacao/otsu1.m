function [outputArg1,outputArg2] = otsu1(I)
% OTSU1 function [outputArg1,outputArg2] = otsu1(I)
% Este algoritmo calculada apenas 1 limiar
% Utilizando limiares com 0 a 255
% A utilizacao com Limiares max e min da imagem esta dando erro de indice
% de calculo para as variancias.

L = 255; %nivel de cinza máximo
minimo = 0; %nivel de cinza minimo

vetorProb = zeros(minimo+1,L+1);

[l,a] = size(I);
for u = minimo:L
    vetorProb(u+1) = length(find(I==u));
end
vetorProb = vetorProb/(l*a);
%bar(vetorProb); %%
for t = minimo:L
        i1= minimo:t;
        us1 = sum(i1.*vetorProb( (minimo+1) : (t+1) ));
        w1 = sum(vetorProb( (minimo+1): (t+1) ));
        u1 = us1/w1;

        i2= t+1:L;
        us2 = sum(i2.*vetorProb( (t+2) : (L+1) ));
        w2 = sum(vetorProb( (t+2) : (L+1) ));
        u2 = us2/w2;

        ig = minimo:L;
        ug = us1 + us2;
        var_g = sum( ((ig-ug).^2).*vetorProb);
        var_b = w1*w2*(u1-u2)^2;
        nt(t+1)=(var_b/var_g);
end

[T_val,T_i] = max(nt);
T_i=T_i-1;

[l,c] = size(I);
resultante = zeros(l,c);

for i = 1:l
    for j = 1:c
        if(I(i,j) > T_i)
            resultante(i,j) = 1;
        else
            resultante(i,j) = 0;
        end  
    end
end
outputArg1 = resultante;
outputArg2 = T_i;
end