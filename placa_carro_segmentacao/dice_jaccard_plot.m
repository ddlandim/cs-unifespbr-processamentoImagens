function[Dice,Jaccard,x,y]= dice_jaccard_plot(img,img_segmentada,img_contorno)
%function[Dice,Jaccard,x,y]= dice_jaccard_plot(img,img_segmentada,img_contorno)
%figure
%    imshow(img);
%hold on
%    plot(y,x,'.g','LineWidth',2);
%    Dice,Jaccard
    [x,y] = find(img_contorno==1);
    intersection = sum(img_segmentada & img);
    union = sum(img_segmentada | img);
    soma = sum(sum(img_segmentada)) + sum(sum(img));
    Dice = (2*sum(intersection)) / soma;
    Jaccard = sum(intersection) / sum(union);
end