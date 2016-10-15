function [ mut_C ] = ex1_mutate( C )

    dim = size(C,2);

    mut_C = C;
    
    % posições de corte
    p1 = randi(dim);
    p2 = randi(dim);
    
    % da um flip na posição de corte
    if p1 > p2
        mut_C(p2:p1) = fliplr(C(p2:p1));
    else
        mut_C(p1:p2) = fliplr(C(p1:p2));
    end
        
end

