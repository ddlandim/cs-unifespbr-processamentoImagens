I = imread('hand.png');
M = rgb2gray(imread('hand_mask.png'));

img = rgb2gray(I);

img = img>50;

M = M>100;

C = img - imerode(img,strel('disk',1));
[x,y] = find(C==1);

marcara_borda = M - imerode(M,strel('disk',1));
[xm,ym] = find(marcara_borda==1);

intersection = sum(M & img);

union = sum(M | img);

soma = sum(sum(M)) + sum(sum(img));

Dice = (2*sum(intersection)) / soma;

Jaccard = sum(intersection) / sum(union);

figure
    imshow(I);
hold on
    plot(y,x,'.g','LineWidth',2);
    plot(ym,xm,'.r','LineWidth',2);
title( ['Dice = ',num2str(Dice),' Jaccard = ',num2str(Jaccard)] );