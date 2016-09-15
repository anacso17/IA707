function [ mutated_chroms ] = mutate( chroms, mut_rate )
%MUTATE Summary of this function goes here
%   Detailed explanation goes here

    n_chroms = size(chroms, 1);
    s = size(chroms, 2);

    mutated_chroms = chroms;
    mut_chance = rand(n_chroms, 1);
    
    for i = 1:n_chroms
        if mut_chance(i) <= mut_rate
            mut_pos = randi(s,1);
            % muda bit 0 para 1 ou 1 para 0
            mutated_chroms(i, mut_pos) = 1 - mutated_chroms(i, mut_pos);
        end
    end
end

