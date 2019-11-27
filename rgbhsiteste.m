close all
clear all
img = imread('lenna.tiff');

figure;
imagesc(img);
title('ORIGINAL');

img1 = double(img)/255;

[l,c,d] = size(img1);

%RGB 2 HSI
R = img1(:,:,1);
G = img1(:,:,2);
B = img1(:,:,3);

%I = 1/3*(R+G+B)
I = (R+G+B)/3;
H = I;
S = I;
for x = 1:l 
    for y = 1:c
        r = R(x,y);
        g = G(x,y);
        b = B(x,y);

        %--S = 1-(min(R,G,B)/I)
        if (I(x,y)==0) S(x,y) = 1;
            else  S(x,y) = 1 - ( min( min(r,g),b) ) / I(x,y) ;
        end
        
        %--H
        %---indefinido se S=0
        if (S(x,y) == 0) 
            H(x,y) = 0;
        
        %--theta
        else
                num = (0.5*((r-g)+(r-b)));
                den = ( (r-g)^2 + ((r-b)*(g-b)) )^0.5;
                if(den~=0)
                    frac = num/den;
                    theta = acosd(frac);
                else
                    theta = 0;
                end
                %theta calculado

                %Calculando H já normalizado
                if(b<=g) 
                    H(x,y) = theta/360;
                else
                    H(x,y) = (360-theta)/360;
                end
        end
    end
end

 H1=H;  
 S1=S;  
 I1=I;
 
%Multiply Hue by 360 to represent in the range [0 360]  
 H1=H1*360;                                               
    


 %Preallocate the R,G and B components  
 R1=zeros(size(H1));  
 G1=zeros(size(H1));  
 B1=zeros(size(H1));  
 RGB1=zeros([size(H1),3]);  
    


 %RG Sector(0<=H<120)  
 %When H is in the above sector, the RGB components equations are  


    
 B1(H1<120)=I1(H1<120).*(1-S1(H1<120));  
 R1(H1<120)=I1(H1<120).*(1+((S1(H1<120).*cosd(H1(H1<120)))./cosd(60-H1(H1<120))));  
 G1(H1<120)=3.*I1(H1<120)-(R1(H1<120)+B1(H1<120));  


    
 %GB Sector(120<=H<240)  
 %When H is in the above sector, the RGB components equations are  


    
 %Subtract 120 from Hue  
 H2=H1-120;  


  
 R1(H1>=120&H1<240)=I1(H1>=120&H1<240).*(1-S1(H1>=120&H1<240));  
 G1(H1>=120&H1<240)=I1(H1>=120&H1<240).*(1+((S1(H1>=120&H1<240).*cosd(H2(H1>=120&H1<240)))./cosd(60-H2(H1>=120&H1<240))));  
 B1(H1>=120&H1<240)=3.*I1(H1>=120&H1<240)-(R1(H1>=120&H1<240)+G1(H1>=120&H1<240));  

 %BR Sector(240<=H<=360)  
 %When H is in the above sector, the RGB components equations are      
 %Subtract 240 from Hue  
 H2=H1-240;  

 G1(H1>=240&H1<=360)=I1(H1>=240&H1<=360).*(1-S1(H1>=240&H1<=360));  
 B1(H1>=240&H1<=360)=I1(H1>=240&H1<=360).*(1+((S1(H1>=240&H1<=360).*cosd(H2(H1>=240&H1<=360)))./cosd(60-H2(H1>=240&H1<=360))));  
 R1(H1>=240&H1<=360)=3.*I1(H1>=240&H1<=360)-(G1(H1>=240&H1<=360)+B1(H1>=240&H1<=360));  

 %Form RGB Image  
 RGB1(:,:,1)=R1;  
 RGB1(:,:,2)=G1;  
 RGB1(:,:,3)=B1;  

 RGB1=RGB1*255;
 RGB1=uint8(RGB1);
 
 %Represent the image in the range [0 255]
 figure,imshow(RGB1);title('RECUPERADA');