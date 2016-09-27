function [ chroms ] = geraPopInicialDes( n_chroms, tam_chrom )

    prob_1 = randi(100, n_chroms, 1);
    
    chroms = randi(100, n_chroms, tam_chrom);
    
    for i = 1:n_chroms
        for j = 1:tam_chrom
            
            % recebe 1 de chroms(i,j) menor que prob_1
            chroms(i,j) = (prob_1(i) > chroms(i,j));    
        end
    end
end

