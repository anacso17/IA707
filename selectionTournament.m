function [ winners ] = selectionTournament( chroms, fitness, n_winners, inds_per_tour )
%SELECTIONTOURNAMENT Summary of this function goes here
%   Detailed explanation goes here
    
    n_chroms = size(chroms, 1);
    s = size(chroms, 2);
    winners = zeros(n_winners, s);

    for i = 1:n_winners
        rand_pos = randi(n_chroms,inds_per_tour,1);          
        
        [~, pos_max] = max(fitness(rand_pos));
        winners(i,:) = chroms(rand_pos(pos_max),:);
    end
end

