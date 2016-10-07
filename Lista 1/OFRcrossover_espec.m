function [ new_chroms ] = OFRcrossover_espec( chroms, n_new, sigma )

    n_chroms = size(chroms, 1);
    s = size(chroms, 2);
    
    new_chroms = zeros(n_new, s);
    
    for i = 1:n_new
        Xa = chroms(randi(n_chroms,1), :);
        
        for k = 1:300
            Xb = chroms(randi(n_chroms,1), :);
            
            if norm(Xa-Xb) < sigma    
                break
            end
        end
        
        for j = 1:s
            r = rand();
            new_chroms(i,j) = r*Xa(j) + (1-r)*Xb(j);
        end

    end
end
