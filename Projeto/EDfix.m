function [ u ] = EDfix( u ) 

s = size(u,2)-1; 

for i = 1:s 
    if u(i) < 0 
        u(i) = -1*u(i); 
    end
    
    if u(i) > 0.5
        u(i) = mod(u(i), 0.5); 
        if u(i) == 0 
            u(i) = 0.1; 
        end
    end
end

if u(end) < 0 
    u(end) = -1*u(end); 
end
end