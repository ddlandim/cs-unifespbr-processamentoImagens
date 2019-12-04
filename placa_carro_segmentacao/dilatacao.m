function[img_dilatada] = dilatacao(img_in,elemento_estruturante)

    estrutura = getnhood(elemento_estruturante);

    % store number of rows in P and number of columns in Q.            
    [linha_janela, coluna_janela]=size(estrutura);  

    % create a zero matrix of size I.         
    img_dilatada = zeros(size(img_in, 1), size(img_in, 2));  

    for i=ceil(linha_janela/2):size(img_in, 1)-floor(linha_janela/2) 
        for j=ceil(coluna_janela/2):size(img_in, 2)-floor(coluna_janela/2) 

            janela = img_in(i-floor(linha_janela/2):i+floor(linha_janela/2), j-floor(coluna_janela/2):j+floor(coluna_janela/2));   

            comparacao = janela(logical(estrutura));         

            img_dilatada(i, j)=max(comparacao(:));       
        end
    end
    
end