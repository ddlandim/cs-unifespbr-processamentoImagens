function[imagem_abertura] = abertura(img_in,obj_estruturante,n)
    %im_in tem que ser binaria
    %objeto estruturante, ex: obj_estruturante = strel('disk',1);
    %n é quantidade de operacoes erosao-dilatacao
    imagem_abertura = img_in;
    for i = 1:n
        imagem_abertura = erosao(imagem_abertura,obj_estruturante);
        imagem_abertura = dilatacao(imagem_abertura,obj_estruturante);
    end
end