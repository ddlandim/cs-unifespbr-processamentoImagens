close all
clear all
I = rgb2gray(imread('placa.png'));

L = max(max(I)); %nivel de cinza máximo
minimo = min(min(I)); %nivel de cinza minimo

vetorProb = zeros(1,L+1);
[l,a] = size(I);

figure;
imshow(I);
title('Imagem Original');

for u = minimo:L
    vetorProb(u+1) = length(find(I==u));
end
vetorProb = vetorProb/(l*a);

i = double(minimo);
j = double(L);
for t = i:j
        i1= i:t;  
        us1 = sum(i1.*vetorProb( (i+1) : (t+1) ));
        w1 = sum(vetorProb( (i+1): (t+1) ));
        u1 = us1/w1;

        i2= t+1:j;
        us2 = sum(i2.*vetorProb( (t+2) : (j+1) ));
        w2 = sum(vetorProb( (t+2) : (j+1) ));
        u2 = us2/w2;

        ig = i:j;
        ug = us1 + us2;
        var_g = sum( ((ig-ug).^2).*vetorProb);
        var_b = w1*w2*(u1-u2)^2;
        nt(t+1)=(var_b/var_g);
end

nL = 3;%calculo de 3 limiares
[T_val,T_i]= maxk(nt,nL); 
T_i=T_i-1;

[l,c] = size(I);
resultante = zeros(l,c);

for i = 1:l
    for j = 1:c
        if(I(i,j) > T_i(1))
            resultante(i,j) = 1;
        else
            resultante(i,j) = 0;
        end  
    end
end

colormap(gray);
figure;
imagesc(resultante);
title('Imagem Resultante 1');

for i = 1:l
    for j = 1:c
        if(I(i,j) > T_i(2))
            resultante(i,j) = 1;
        else
            resultante(i,j) = 0;
        end  
    end
end

colormap(gray);
figure;
imagesc(resultante);
title('Imagem Resultante 2');

message1 = sprintf('Limiar(es) %d. \n', T_i);
message2 = sprintf('Nível de Cinza Máximo %d e Mínimo %d. \n', L, minimo);
uiwait(helpdlg(message1));
uiwait(helpdlg(message2));