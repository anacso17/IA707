function [ u ] = EDfix( u )    
    s = size(u,2);
    
    for i = 1:s
        if u(i) < 0
            u(i) = -1*u(i);
        end
        
        if u(i)> 0.5
            u(i) = u(i)/10;
        end
    end
end

