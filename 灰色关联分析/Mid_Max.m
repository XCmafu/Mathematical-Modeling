function [result] = Mid_Max( x, best)
    M = max(abs(x-best));
    result = 1 - abs(x-best) / M;
end