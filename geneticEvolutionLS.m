%
% geneticEvolutionLS: Algoritmo gen�tico com busca local
%
% Entrada:
% data - vetor com os dados de entrada para serem divididos em grupos
% n_chroms - n�mero de cromossomos que ser� utilizado
% n_gen - n�mero de gera��es que o algoritmo ir� rodar
% n_gen_ls - a cada quantas gera��es fazer busca local
%
% Sa�da
% final_chroms - cromossomos ap�s o fim do algoritmo
% best_chrom - melhor chromossomo encontrado pelo algorimo
%

function [ final_chroms, best_chrom ] = geneticEvolutionLS( data, n_chroms, n_gen, n_gen_ls )

    n_created =10*n_chroms;     % n�mero de novos pares de filhos que ser�o gerados
    mut_rate = 0.1;             % taxa de muta��o
    
    s = size(data,1);           % tamanho do cromossomo
    best_chrom = zeros(1,s);
    
    chroms = randi([0,1], n_chroms, s); % gera randomicamente cromossomos bin�rios
    
    % valores para montagem do gr�fico de m�ximo, m�nimo e m�dio fitness
    fit_max = zeros(n_gen, 1);  
    fit_min = zeros(n_gen, 1);
    fit_avg = zeros(n_gen, 1);
    
    for i = 1:n_gen
        % crossover para criar novos filhos e muta��o
        new_chroms = crossover(chroms, n_created);
        new_chroms = mutate(new_chroms, mut_rate);
        
        % faz a sele��o incluindo pais e filhos
        all_chroms = [chroms; new_chroms];
        fit = evaluateFitness(all_chroms, data);
        chroms = selectionTournament(all_chroms, fit, n_chroms-1, 2);
        
        % preserva o melhor individuo
        [fit_max(i), pos] = max(fit);
        best_chrom = all_chroms(pos,:);
        % faz busca local, se necess�rio
        if mod(i,n_gen_ls) == 0
            best_chrom = localSeach(best_chrom, data);
        end
        chroms(n_chroms, :) = best_chrom;
        
        fit_min(i) = min(fit);
        fit_avg(i) = mean(fit);
    end

    
    final_chroms = chroms;
    best_fit = evaluateFitness(best_chrom,data);
    
%     if (best_fit == 0.5 || best_fit == 0)
%         fprintf('*')
%     else
%         fprintf('|')
%     end
    fprintf('Best difference found: %d', 1/best_fit-1);
    
    plot(log10(fit_max), 'b');
    hold on;
    plot(log10(fit_min), 'k');
    plot(log10(fit_avg), 'r');
    hold off;
      
end

