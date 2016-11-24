function [ chroms ] = PEmutation( chroms, t, A, B, T, p)
    
    n_chroms = size(chroms, 1);
    s = size(chroms, 2);
    
    for i = 1:n_chroms
        for j = 1:s     % cada gene

            r = rand();
            if r > 0.5      % escolhe se vai aumentar ou diminuir o valor
                % faz a mutação
                chroms(i,j) = chroms(i,j) + PEmutate(t, B - chroms(i,j), T, p);
            else
                chroms(i,j) = chroms(i,j) - PEmutate(t, chroms(i,j) - A, T, p);
            end
        end
    end
end

