function [result] = Interval_Max( m, up, low)
    row_x = size( m, 1);   
    M = max([ up-min(m), max(m)-low]);
    result = zeros( row_x, 1);   
    for i = 1:row_x
        if m(i) < up
           result(i) = 1-(up-m(i))/M;
        elseif m(i) > low
           result(i) = 1-(m(i)-low)/M;
        else
           result(i) = 1;
        end
    end
end