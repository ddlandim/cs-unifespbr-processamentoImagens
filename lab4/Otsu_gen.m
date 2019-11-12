function [T] = Otsu_gen(I, nL)
    L = max(max(I)); %nivel de cinza máximo
    minimo = min(min(I)); %nivel de cinza minimo
    vetorProb = zeros(minimo+1,L+1);
    [l,a] = size(I);
    for u = minimo:L
        vetorProb(u+1) = length(find(I==u));
    end
    vetorProb = vetorProb/(l*a);
    bar(vetorProb);
    
    i = double(minimo);
    j = double(L);
    j = j-1;
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
    title('Imagem Resultante');
    message = sprintf('Limiar %d.', T_i);
    uiwait(helpdlg(message));
end