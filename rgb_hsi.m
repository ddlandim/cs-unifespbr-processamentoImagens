function[img_out] = rgb_hsi(img)

img1 = double(img)/255;

[linha,coluna,dim] = size(img1);

%RGB 2 HSI
R = img1(:,:,1);
G = img1(:,:,2);
B = img1(:,:,3);

%I = 1/3*(R+G+B)
I = (R+G+B)/3;
H = I;
S = I;
for x = 1:linha 
    for y = 1:coluna
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
                den = sqrt( (r-g)^2 + ((r-b)*(g-b)) );
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

% H, S, I finalizados.
% montando saída

img_out = cat(3, H,S,I);