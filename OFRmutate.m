function [  ] = OFRmutate( chroms, mut_prob, t, A, B, T, p)

    if isempty(p)
      p = 5;
    end
    
    n_chroms = size(chroms, 1);
    s = size(chroms, 2);
    
    for i = 1:n_chroms
        r = rand();
        if r >= mut_prob    % escolhe se vai mutar
            
            for j = 1:s
                
                r = rand();
                if r > 0.5      % escolhe se vai aumentar ou diminuir o valor
                    % faz a mutação
                    chroms(i,j) = chroms(i,j) + mutNUniforme(t, B - chroms(i,j));
                else
                    chroms(i,j) = chroms(i,j) + mutNUniforme(t, chroms(i,j) - A);
                end
            end
        end
    end
end

