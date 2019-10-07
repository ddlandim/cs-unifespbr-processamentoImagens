%Autor : Douglas Diniz Landim, ra 76681
%email : ddlandim@unifesp.br

clear all
close all

img = imread('arvore.jpg');
[l,a] = size(img);

figure
    imagesc(img),
    colormap(gray), 
title('original');

m1_zeros = zeros(l,a);
m2_zeros = zeros(l,2*a);

img2 = [[img;m1_zeros],m2_zeros];

img3 = img + img2;

F = fft2(img);

figure
    imagesc(fftshift(abs(F))),
    colormap(gray), 
title('FFT');

F2 = log (1+F);

figure
    imagesc(fftshift(abs(F2))),
    colormap(gray), 
title('log');

inversa = ifft2(F);

figure
    imagesc(real(inversa)), colormap(gray), 
title('inversa');


filtro = zeros(l,a);
bloco = 7;

        

% SELECAO DE FILTRO, INSERIR passa_alta ou passa_baixa
%filtro = passa_baixa;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%if(filtro==passa_alta)
%    varf=0;
%end

%if (filtro==passa_baixa)
%    varf=1;
%end

% SELECAO DO RAIO DO PONTO
%raio = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%

% INSERCAO DE PONTOS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ponto a
%centro_y = 16;
%centro_x = 121;
%for i = -raio : raio
%    for j= -raio : raio
%        if((i*i+j*j)<= raio*raio)
%            filtro(i+centro_y,j+centro_x) = varf;
%        end
%    end
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



figure, 
    imshow(filtro), 
title('Filtro');

m1a = F.*fftshift(filtro);
m2a = log(1+m1a);
figure
    imagesc(fftshift(abs(m2a))), colormap(gray),
title('Multiplicacao');

m2a_inversa = ifft2(m1a);
figure
imagesc(real(m2a_inversa)), colormap(gray), title('Inversa pa');