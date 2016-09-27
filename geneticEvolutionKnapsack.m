%
% geneticEvolution: Algoritmo genético
%
% Entrada:
% v - vetor com os dados de entrada para serem divididos em grupos
% n_chroms - número de cromossomos que será utilizado
% n_gen - número de gerações que o algoritmo irá rodar
%
% Saída
% final_chroms - cromossomos após o fim do algoritmo
% best_chrom - melhor chromossomo encontrado pelo algorimo
%

function [ best_chrom ] = geneticEvolutionKnapsack( v, p, c, opt, n_chroms, n_gen )

    n_created =10*n_chroms;     % número de novos pares de filhos que serão gerados
    mut_rate = 0.1;             % taxa de mutação
    
    s = size(v,1);           % tamanho do cromossomo
    best_chrom = zeros(1,s);
    
    chroms = geraPopInicialDes(n_chroms, s); % gera randomicamente cromossomos binários
    
    % valores para montagem do gráfico de máximo, mínimo e médio fitness
    fit_max = zeros(n_gen, 1);  
    fit_min = zeros(n_gen, 1);
    fit_avg = zeros(n_gen, 1);
    
    for i = 1:n_gen
        % crossover para criar novos filhos e mutação
        new_chroms = crossover(chroms, n_created);
        new_chroms = mutate(new_chroms, mut_rate);
        
        % faz a seleção incluindo pais e filhos
        all_chroms = [chroms; new_chroms];
        fit = evaluateFitnessKnapsack(all_chroms, p, v, c, opt);
        chroms = selectionTournament(all_chroms, fit, n_chroms-1, 2);
        
        % preserva o melhor individuo
        [fit_max(i), pos] = max(fit);
        best_chrom = all_chroms(pos,:);
        chroms(n_chroms, :) = best_chrom;
        
        fit_min(i) = min(fit);
        fit_avg(i) = mean(fit);
    end

    
    %final_chroms = chroms;
    best_fit = evaluateFitnessKnapsack(best_chrom, p, v, c, opt);
    
%     if (best_fit == 0.5 || best_fit == 0)
%         fprintf('*')
%     else
%         fprintf('|')
%     end
    fprintf('Best fitness found: %d', best_fit);
    
    plot(fit_max, 'b');
    hold on;
    plot(fit_min, 'k');
    plot(fit_avg, 'r');
    hold off;
      
end

