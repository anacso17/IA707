%
% selectionTournament
% Realiza a sele��o do tipo torneio com os cromossomos, retornando 
% n_winners ganhadores.
%
% Entrada: 
% chroms - cromossomos que ser�o utilizados
% fitness - vetor de fitness calculado para os cromossomos
% n_winners - n�mero de cromossomos ganhadores (tamanho da sa�da)
% inds_per_tour - n�mero de cromossomos que participam de um torneio
% 
% S�ida:
% winners - vetor com os cromossomos ganhadores
%

function [ winners, fit ] = selectionTournament( chroms, fitness, n_winners, inds_per_tour )
   
    n_chroms = size(chroms, 1);     % numero de cromossomos
    s = size(chroms, 2);            % tamanho do cromossomo
    winners = zeros(n_winners, s);
    fit = zeros(n_winners, s);

    for i = 1:n_winners
        rand_pos = randi(n_chroms,inds_per_tour,1);  % pega inds_per_tour posi��es rand�micas          
        
        % seleciona o melhor individuo
        [~, pos_max] = max(fitness(rand_pos));  
        winners(i,:) = chroms(rand_pos(pos_max),:);
        fit(i,:) = fitness(rand_pos(pox_max));
    end
end

