%Autor : Douglas Diniz Landim, ra 76681
%email : ddlandim@unifesp.br

clear all
close all

img = imread('palhaco.jpg');
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

fpa = ones(l,a);
raio = 5;

%circulo a
centrox = 118;
centroy = 111;
for i = -raio : raio
    for j= -raio : raio
        if((i*i+j*j)<= raio*raio)
            fpa(i+centrox,j+centroy)=0;
        end
    end
end

%circulo b
centrox = 151;
centroy = 92;
for i = -raio : raio
    for j= -raio : raio
        if((i*i+j*j)<= raio*raio)
            fpa(i+centrox,j+centroy)=0;
        end
    end
end

%circulo c
centrox = 139;
centroy = 148;
for i = -raio : raio
    for j= -raio : raio
        if((i*i+j*j)<= raio*raio)
            fpa(i+centrox,j+centroy)=0;
        end
    end
end

%circulo d
centrox = 106;
centroy = 166;
for i = -raio : raio
    for j= -raio : raio
        if((i*i+j*j)<= raio*raio)
            fpa(i+centrox,j+centroy)=0;
        end
    end
end

figure, 
    imshow(fpa), 
title('Filtro');

m1a = F.*fftshift(fpa);
m2a = log(1+m1a);
figure
    imagesc(fftshift(abs(m2a))), colormap(gray),
title('Multiplicacao');

m2a_inversa = ifft2(m1a);
figure
imagesc(real(m2a_inversa)), colormap(gray), title('Inversa pa');