function[imagem_erodida] = erosao(img_in,elemento_estruturante)
%im_in tem que ser binaria
%elemento_estruturante, ex: strel('disk',1);
    estrutura = getnhood(elemento_estruturante);
    %getnhood - pega os n-vizinhos do elemento estruturante

    m = floor(size(estrutura,1)/2);
    n = floor(size(estrutura,2)/2);

    img_in_pad = padarray(img_in,[m n],1);

    imagem_erodida = false(size(img_in));

    for i = 1:size(img_in_pad,1) - (2*m)

        for j = 1:size(img_in_pad,2) - (2*n)

            aux = img_in_pad( i:i+(2*m), j:j+(2*n) );

            imagem_erodida(i,j) = min(min(aux-estrutura));
        end

    end
end