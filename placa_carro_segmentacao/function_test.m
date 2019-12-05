clc
close all
clear all

imagem = [ 0, 0, 0, 0, 0, 0, 0, 0;
        0, 0, 0, 0, 0, 0, 0, 0;
        0, 0, 0, 0, 0, 0, 0, 0;
        0, 0, 1, 1, 1, 0, 0, 1;
        0, 0, 1, 0, 1, 0, 0, 1;
        0, 0, 1, 1, 1, 0, 0, 1;
        0, 1, 1, 0, 1, 1, 0, 1;
        0, 0, 0, 0, 0, 0, 0, 0;]

figure;
colormap(gray);
imagesc(imagem);
title('img');
n_objetos = 2;
vetor_cadeia = {};

[idx,idy] = find(imagem>0,1);
contourCW = bwtraceboundary(imagem,[idx idy],'W',8,50,'clockwise');