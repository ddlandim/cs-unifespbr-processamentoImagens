I = imread('hand.png');
M = rgb2gray(imread('hand_mask.png'));

S = rgb2gray(I);

S = S>50;

M = M>100;

C = S - imerode(S,strel('disk',1));
[x,y] = find(C==1);

CM = M - imerode(M,strel('disk',1));
[xm,ym] = find(CM==1);

intersection = sum(M & S);

union = sum(M | S);

soma = sum(sum(M)) + sum(sum(S));

Dice = (2*sum(intersection)) / soma;

Jaccard = sum(intersection) / sum(union);

figure
    imshow(I);
hold on
    plot(y,x,'.g','LineWidth',2);
    plot(ym,xm,'.r','LineWidth',2);
    Dice,Jaccard