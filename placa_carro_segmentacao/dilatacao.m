function[img_dilatada] = dilatacao(img_in,elemento_estruturante)
%im_in tem que ser binaria
%elemento_estruturante, ex: strel('disk',1);

    estrutura = getnhood(elemento_estruturante);

    % store number of rows in linha_janela and number of columns in coluna_janela.            
    [linha_janela, coluna_janela]=size(estrutura);  

    % create a zero matrix of size Image.         
    img_dilatada = false(size(img_in, 1), size(img_in, 2));
    
    for i=ceil(linha_janela/2):size(img_in, 1)-floor(linha_janela/2) 
        for j=ceil(coluna_janela/2):size(img_in, 2)-floor(coluna_janela/2) 

            janela = img_in(i-floor(linha_janela/2):i+floor(linha_janela/2), j-floor(coluna_janela/2):j+floor(coluna_janela/2));   

            comparacao = janela(logical(estrutura));         

            img_dilatada(i, j) = logical(max(comparacao(:)));       
        end
    end
    
end