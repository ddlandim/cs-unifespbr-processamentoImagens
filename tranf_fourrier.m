%Autor : Douglas Diniz Landim, ra 76681
%email : ddlandim@unifesp.br

im_in = rgb2gray(imread('paisagem.jpg'));
F = fft2(im_in);

imagesc(F)
colormap(gray);

F2 = log (1+F);
imagesc(F2)
colormap(gray);

inversa = ifft2(F);
imagesc(inversa)
colormap(gray);