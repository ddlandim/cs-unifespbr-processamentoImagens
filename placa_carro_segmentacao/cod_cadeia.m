function[vetor_cadeia] = cod_cadeia(img_in,n_objetos)
%essa funcao recebe uma imagem binarizada e retorna um vetor de vetores do codigo da cadeia de freeman para 8 angulos.
    img_aux = padarray(img_in,[1 1],0,'both');
    [a,l] = size(img_in);
    vetor_cadeia = zeros(1,n_objetos);
    for i = 1:n_objetos
        [idx,idy] = find(img_aux>0,1);

        %ponto encontrado
        %figure;
        %colormap(gray);
        %imagesc(imagem);
        %hold on
        %    plot(idy,idx,'or');
        %hold off
        %title('Ponto encontrado');

        codigo_cadeia = [-1,idx,idy];
        x = idx;
        y = idy;

        %1a vareddura abaixo, val_cadeia = 3
        y = y-1;
        i_look = 0;
        while((x ~= idx || y~= idy) && i< (a*l))
                if( img_aux(x+1,y) == 1)
                    if(i_look~=0) 
                        img_aux(x,y) = 0;
                    end
                    val_cadeia = 0;
                    x = x+1;
                    codigo_cadeia = [codigo_cadeia; val_cadeia, x, y];
                end

                if( img_aux(x+1,y+1) == 1)
                    if(i_look~=0) 
                        img_aux(x,y) = 0;
                    end
                    val_cadeia = 1;
                    x = x+1;
                    y = y+1;
                    codigo_cadeia = [codigo_cadeia; val_cadeia, x, y];
                end

                if( img_aux(x,y+1) == 1)
                    if(i_look~=0) 
                        img_aux(x,y) = 0;
                    end
                    val_cadeia = 2;
                    x = x;
                    y = y+1;
                    codigo_cadeia = [codigo_cadeia; val_cadeia, x, y];
                end

                if( img_aux(x-1,y+1) == 1)
                    if(i_look~=0) 
                        img_aux(x,y) = 0;
                    end
                    val_cadeia = 3;
                    x = x-1;
                    y = y+1;
                    codigo_cadeia = [codigo_cadeia; val_cadeia, x, y];
                end

                if( img_aux(x-1,y) == 1)
                    if(i_look~=0) 
                        img_aux(x,y) = 0;
                    end
                    val_cadeia = 4;
                    x = x-1;
                    y = y;
                    codigo_cadeia = [codigo_cadeia; val_cadeia, x, y];
                end

                if( img_aux(x-1,y-1) == 1)
                    if(i_look~=0) 
                        img_aux(x,y) = 0;
                    end
                    val_cadeia = 5;
                    x = x-1;
                    y = y-1;
                    codigo_cadeia = [codigo_cadeia; val_cadeia, x, y];
                end

                if( img_aux(x,y-1) == 1)
                    if(i_look~=0) 
                        img_aux(x,y) = 0;
                    end
                    x = x;
                    y = y-1;
                    codigo_cadeia = [codigo_cadeia; val_cadeia, x, y];
                    img_aux(x,y) = 0;
                end

                if( img_aux(x+1,y-1) == 1)
                    if(i_look~=0) 
                        img_aux(x,y) = 0;
                    end;
                    val_cadeia = 7;
                    x = x+1;
                    y = y-1;
                    codigo_cadeia = [codigo_cadeia; val_cadeia, x, y];
                end
           i_look = i_look+1;
        end
        vetor_cadeia = [i;codigo_cadeia];
    end
end