function[img_erodida] = erosao(img,obj_estrutura)
%im_in tem que ser binaria
%elemento_estruturante, ex: strel('disk',1);
    elemento_estruturante = getnhood(obj_estrutura);
    
    [linha_janela, coluna_janela] = size(elemento_estruturante); 
    
    img_erodida = false(size(img, 1), size(img, 2));
    
    for i = ceil(linha_janela/2) : size(img, 1) - floor(linha_janela/2) 
        for j = ceil(coluna_janela/2) : size(img, 2) - floor(coluna_janela/2) 
            
            janela = img(i-floor(linha_janela/2):i+floor(linha_janela/2), j-floor(coluna_janela/2):j+floor(coluna_janela/2)); 
            
            comparacao = janela(logical(elemento_estruturante)); 	
            
            img_erodida(i, j) = logical(min(comparacao(:)));
            
        end
    end
end