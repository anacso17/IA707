function [ i ] = genToMax( fit_max, max )
    i = 0;
    for i = 1:size(fit_max,1)
        if (max - fit_max(i)) < 0.0001
            return
        end
    end
    
end

