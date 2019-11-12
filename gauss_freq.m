function g = gauss_freq(img,perc)
IMG = fft2( img );
sz = size( img );
h = gauss2d(sz/(perc/100), sigma );
H = fft2( h ); 
F = IMG.*H;
g = ifft2( F );