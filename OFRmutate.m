function [ chroms ] = OFRmutate( chroms, mut_prob, t, A, B, T, p)
    
    n_chroms = size(chroms, 1);
    s = size(chroms, 2);
    
    for i = 1:n_chroms
        r = rand();
        if r >= mut_prob    % escolhe se vai mutar
            
            for j = 1:s     % cada gene
                
                r = rand();
                if r > 0.5      % escolhe se vai aumentar ou diminuir o valor
                    % faz a mutação
                    chroms(i,j) = chroms(i,j) + OFRmutNUniforme(t, B - chroms(i,j), T, p);
                else
                    chroms(i,j) = chroms(i,j) - OFRmutNUniforme(t, chroms(i,j) - A, T, p);
                end
            end
        end
    end
end

