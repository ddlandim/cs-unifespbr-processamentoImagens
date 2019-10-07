%Autor : Douglas Diniz Landim, ra 76681
%email : ddlandim@unifesp.br

clear all
close all

img = imread('e9gla_noise.png');
[l,a] = size(img);

figure
    imagesc(img),
    colormap(gray), 
title('original');

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

passa_alta = ones(l,a);
passa_baixa = zeros(l,a);

% SELECAO DE FILTRO, INSERIR passa_alta ou passa_baixa
filtro = passa_alta;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(filtro==passa_alta)
    varf=0;
end

if (filtro==passa_baixa)
    varf=1;
end

% SELECAO DO RAIO DO PONTO
raio = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%

% INSERCAO DE PONTOS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ponto a
centro_y = 16;
centro_x = 121;
for i = -raio : raio
    for j= -raio : raio
        if((i*i+j*j)<= raio*raio)
            filtro(i+centro_y,j+centro_x) = varf;
        end
    end
end

%ponto b
centro_y = 43;
centro_x = 121;
for i = -raio : raio
    for j= -raio : raio
        if((i*i+j*j)<= raio*raio)
            filtro(i+centro_y,j+centro_x) = varf;
        end
    end
end

%ponto c
centro_y = 101;
centro_x = 121;
for i = -raio : raio
    for j= -raio : raio
        if((i*i+j*j)<= raio*raio)
            filtro(i+centro_y,j+centro_x) = varf;
        end
    end
end

%ponto d central
%raio = 3
%centro_y = 163;
%centro_x = 121;
%for i = -raio : raio
%    for j= -raio : raio
%        if((i*i+j*j)<= raio*raio)
%            filtro(i+centro_y,j+centro_x) = varf;
%        end
%    end
%end

%ponto e
raio = 5;
centro_y = 219;
centro_x = 121;
for i = -raio : raio
    for j= -raio : raio
        if((i*i+j*j)<= raio*raio)
            filtro(i+centro_y,j+centro_x) = varf;
        end
    end
end

%ponto f
centro_y = 278;
centro_x = 121;
for i = -raio : raio
    for j= -raio : raio
        if((i*i+j*j)<= raio*raio)
            filtro(i+centro_y,j+centro_x) = varf;
        end
    end
end

%ponto g
centro_y = 303;
centro_x = 121;
for i = -raio : raio
    for j= -raio : raio
        if((i*i+j*j)<= raio*raio)
            filtro(i+centro_y,j+centro_x) = varf;
        end
    end
end

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