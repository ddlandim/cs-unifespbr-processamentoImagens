function[img_out] = hsi_rgb(img)

H = img(:,:,1);
S = img(:,:,2);
I = img(:,:,3);

%INVERSA HSI PARA RGB
%Convertendo H para o dominio de 0 a 360.
H1 = H*360;

%Instanciando R,G,B de saída para otimizar o laço
R_out = zeros(size(H1));
G_out = zeros(size(H1));
B_out = zeros(size(H1));

%%%% 0 h 120
B_out(H1<120) = I(H1<120).*(1-S(H1<120));  
R_out(H1<120) = I(H1<120).*(1+((S(H1<120).*cosd(H1(H1<120)))./cosd(60-H1(H1<120))));  
G_out(H1<120) = 3.*I(H1<120)-(R_out(H1<120)+B_out(H1<120));

%%%% 120 h 240
H2=H1-120;
R_out(H1>=120&H1<240)=I(H1>=120&H1<240).*(1-S(H1>=120&H1<240));  
G_out(H1>=120&H1<240)=I(H1>=120&H1<240).*(1+((S(H1>=120&H1<240).*cosd(H2(H1>=120&H1<240)))./cosd(60-H2(H1>=120&H1<240))));  
B_out(H1>=120&H1<240)=3.*I(H1>=120&H1<240)-(R_out(H1>=120&H1<240)+G_out(H1>=120&H1<240));

%%%% 240 h 360
H2=H1-240;
G_out(H1>=240&H1<=360)=I(H1>=240&H1<=360).*(1-S(H1>=240&H1<=360));  
B_out(H1>=240&H1<=360)=I(H1>=240&H1<=360).*(1+((S(H1>=240&H1<=360).*cosd(H2(H1>=240&H1<=360)))./cosd(60-H2(H1>=240&H1<=360))));  
R_out(H1>=240&H1<=360)=3.*I(H1>=240&H1<=360)-(G_out(H1>=240&H1<=360)+B_out(H1>=240&H1<=360));  

RGB_out = cat(3, R_out, G_out, B_out);
RGB_out = RGB_out*255;
RGB_out = uint8(RGB_out);

img_out = RGB_out;