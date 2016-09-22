%
% crossover
% Essa função seleciona um par de cromossomos randomicamente e faz 
% crossover de 1 ponto usando eles. Essa operação é repetida 
% n_new_pairs vezes.
%
% Entrada: 
% chroms - cromossomos que serão utilizados
% n_new_pairs - numero de pares de cromossomos criados
% 
% Sáida:
% new_chroms - novos cromossomos gerados
%

function [ new_chroms ] = crossover( chroms, n_new_pairs )

    n_chroms = size(chroms, 1);     % numero de cromossomos
    s = size(chroms, 2);            % tamanho do cromossomo

    new_chroms = zeros(2*n_new_pairs, s);
    
    for i = 1:n_new_pairs
        chrom1 = chroms(randi(n_chroms,1), :);
        chrom2 = chroms(randi(n_chroms,1), :);

        cut_pos = randi(s-1, 1);    % posição de corte
        chrom_aux = [chrom1(1:cut_pos),chrom2(cut_pos+1:end)];
        chrom2 = [chrom2(1:cut_pos),chrom1(cut_pos+1:end)];

        new_chroms((2*i-1):(2*i),:) = [chrom_aux;chrom2];
    end
end

