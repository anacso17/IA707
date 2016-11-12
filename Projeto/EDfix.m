function [ u ] = EDfix( u )    
    s = size(u,2);
    
    for i = 1:s
        if u(i) < 0
            u(i) = -1*u(i);
        end
    end
end

