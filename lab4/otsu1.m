close all
clear all
I = imread('gaviao_cinza.jpg');
L = 255;%max(max(I)); %nivel de cinza máximo
minimo = 0;%min(min(I)); %nivel de cinza minimo

vetorProb = zeros(minimo+1,L+1);

figure;
imshow(I);
title('Imagem Original');

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

[T_val,T_i]=max(nt);
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


colormap(gray);
figure;
imagesc(resultante);
colormap(gray);
title('Imagem Resultante');
message = sprintf('Limiar %d.', T_i);
uiwait(helpdlg(message));
