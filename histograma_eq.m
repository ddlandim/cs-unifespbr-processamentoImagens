function[img_out] = histograma_eq(img)

[linha,coluna] = size(img);

n_pixels = linha*coluna;

img_out = uint8(zeros(linha,coluna));

freq = zeros(256,1);

probf = zeros(256,1);

probc = zeros(256,1);

cum = zeros(256,1);

output = zeros(256,1);

for x = 1:linha

    for y = 1:coluna

        pixel = img(x,y);

        freq(pixel+1) = freq(pixel+1)+1;

        probf(pixel+1) = freq(pixel+1)/n_pixels;

    end

end

sum=0;

val_max=255;

for i=1:size(probf)

   sum = sum+freq(i);

   cum(i) = sum;

   probc(i) = cum(i)/n_pixels;

   output(i) = round(probc(i)*val_max);

end

for i=1:linha

    for j=1:coluna

            img_out(i,j) = output(img(i,j)+1);

    end

end

return;