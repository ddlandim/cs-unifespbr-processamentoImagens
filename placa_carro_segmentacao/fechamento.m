function[imagem_fechamento] = fechamento(img_in,obj_estruturante,n)
    %function[imagem_fechamento] = fechamento(img_in,obj_estruturante,n)
    %im_in tem que ser binaria
    %objeto estruturante, ex: obj_estruturante = strel('disk',1);
    %n é quantidade de operacoes dilatacao-erosao
    imagem_fechamento = img_in;
    for i = 1:n
        imagem_fechamento = dilatacao(imagem_fechamento,obj_estruturante);
        imagem_fechamento = erosao(imagem_fechamento,obj_estruturante);
    end
end