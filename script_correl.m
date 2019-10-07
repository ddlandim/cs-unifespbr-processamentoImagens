clear all;
close all;
x = imread('gauss2D.jpg');
h = imread('gaviao_cinza.jpg');
im1 = correlacao(x,h);
imshow(x);
figure;
imshow(im1);