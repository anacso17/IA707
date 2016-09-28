function [ chroms ] = geraPopInicialUniforme( n_chroms, tam_chrom )

    no1 = randi([(tam_chrom/2)-20,(tam_chrom/2)+20], n_chroms, 1);
    no0 = tam_chrom-no1;
    
    for i = 1:n_chroms
        aux(1:tam_chrom) = [ zeros(1,no0(i)) ones(1,no1(i)) ];   
        chroms(i,1:tam_chrom) = aux(randperm(tam_chrom));
    end
end