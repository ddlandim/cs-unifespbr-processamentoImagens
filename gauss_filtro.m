function arr_out = gauss_filtro(arr, sigma)
arr = double(arr);
% Default value of alpha in gausswin is 2.5.
alpha = 2.5;
% The number of points included in the window. 
% To be honest I dont understand this completely, but I changed around
% an equation in the documentation for gausswin and it seems to fit. 
% Bottom line is that we create a window that has enough points to
% include the shape of gaussian. 
N = round(2*alpha*sigma);
% Create the window. 
filter_arr = gausswin(N, alpha);
% Normalize to ensure output is correct after convolution.
filter_arr = filter_arr/sum(filter_arr);
% Padd the array with the start end end of the array, 
% this is important to get the same results as
% imgaussfilt. Looks good for pictures.
pad_length = ceil(N/2);
% Support both ways of having 1d arrays because matlab is annoying.
if size(arr,1) == 1
    padding = ones(1,pad_length);
    arr = [padding*arr(1), arr, padding*arr(end)];
else
    padding = ones(pad_length,1);
    arr = [padding*arr(1); arr; padding*arr(end)];
end
% Do the filtering.
arr_out = conv(arr, filter_arr, 'same');
% Remove the padding we introduced.
arr_out = arr_out(pad_length+1:end-pad_length);
end