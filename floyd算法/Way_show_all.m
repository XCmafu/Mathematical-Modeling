function [] = Way_show_all( distances, way, n)

for i = 1:n
    for j = 1:n
        if i ~= j  
            Way_show( distances, way, i, j);   % µ÷ÓÃWay_showº¯Êý
            disp('-------------------------------------------')
        end
    end
end

end

