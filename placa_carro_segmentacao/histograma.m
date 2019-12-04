function[frequencia,max_i,min_i] = histograma(img)
   
%get the dimension of the image  
[x, y] = size(img); 

max_i = max(max(img))+1;
min_i = min(min(img));

frequencia = 1 : max_i; 
  
count = 0; 
    
for i = 1 : max_i
    for j = 1 : x 
        for k = 1 : y 
            if img(j, k) == i-1 
                    count = count + 1; 
            end
        end
    end
    frequencia(i) = count; 
    count = 0;   
end

end