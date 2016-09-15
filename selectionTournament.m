function [ winners ] = selectionTournament( chroms, fitness, n_winners )
%SELECTIONTOURNAMENT Summary of this function goes here
%   Detailed explanation goes here
    
    n_chroms = size(chroms, 1);
    s = size(chroms, 2);
    winners = zeros(n_winners, s);

    for i = 1:n_winners
        p_chrom1 = randi(n_chroms,1);
        p_chrom2 = randi(n_chroms,1);
        
        if fitness(p_chrom1) >= fitness(p_chrom1)
            winners(i,:) = chroms(p_chrom1,:);
        else
            winners(i,:) = chroms(p_chrom2,:);
        end
    end
end

