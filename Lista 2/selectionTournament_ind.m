%
% selectionTournament
% Realiza a sele��o do tipo torneio com os cromossomos, retornando 
% o indice de n_winners ganhadores.
%
% Entrada: 
% chroms - cromossomos que ser�o utilizados
% fitness - vetor de fitness calculado para os cromossomos
% n_winners - n�mero de cromossomos ganhadores (tamanho da sa�da)
% inds_per_tour - n�mero de cromossomos que participam de um torneio
% 
% S�ida:
% winners_ind - vetor com os indices dos cromossomos ganhadores
%

function [ winners_ind ] = selectionTournament_ind( chroms, fitness, n_winners, inds_per_tour )
   
    n_chroms = size(chroms, 1);     % numero de cromossomos
    winners_ind = zeros(n_winners, 1);

    for i = 1:n_winners
        rand_pos = randi(n_chroms,inds_per_tour,1);  % pega inds_per_tour posi��es rand�micas          
        
        % seleciona o melhor individuo
        [~, pos_max] = max(fitness(rand_pos));  
        winners_ind(i,:) = rand_pos(pos_max);
    end
end

