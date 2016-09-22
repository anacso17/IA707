%
% evaluateFitness
% Avalia o fitness do vetor de cromossomos pegando o inverso da diferença
% da soma dos valores do grupo A (bit 1 no cromossomo) da soma do grupo B
% (bit 0 no cromossomo) somado a 1 (1/(1+abs(sumA-sumB)).
%
% Entrada: 
% chroms - cromossomos que terão o fitness avaliado 
% data - dados com os valores para calcular o fitness
% 
% Sáida:
% fitness_vec - vetor com o fitness para cada cromossomo
%

function [ mutated_chroms ] = mutate( chroms, mut_rate )

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

