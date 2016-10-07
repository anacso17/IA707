function [ final_chroms, best_chrom ] = OFRmain( n_chroms, n_gen )
    
    A = -1;
    B = 2;
        
    n_created =n_chroms;     % número de novos filhos que serão gerados
    mut_rate = 0.1;             % taxa de mutação
    s = 2;           % tamanho do cromossomo
    
    best_chrom = zeros(1,s);
    
    % gera randomicamente cromossomos com valores entre A e B
    chroms = A+(B-A)*rand(n_chroms, s); 
    draw3DView(chroms, '*b');
    
    % valores para montagem do gráfico de máximo, mínimo e médio fitness
    fit_max = zeros(n_gen, 1);  
    fit_min = zeros(n_gen, 1);
    fit_avg = zeros(n_gen, 1);
    
    for i = 1:n_gen
        % crossover para criar novos filhos e mutação
        new_chroms = OFRcrossover(chroms, n_created);
        new_chroms = OFRmutate(new_chroms, mut_rate, i, A, B, n_gen, 5);
        
        % faz a seleção incluindo pais e filhos
        all_chroms = [chroms; new_chroms];
        fit = OFRevaluateFitness(all_chroms);
        chroms = selectionTournament(all_chroms, fit, n_chroms-1, 2);
        
        [fit_max(i), pos] = max(fit);
        best_chrom = all_chroms(pos,:);
        
        % preserva o melhor individuo
        chroms(n_chroms, :) = best_chrom;
        
        fit_min(i) = min(fit);
        fit_avg(i) = mean(fit);
        
        if mod(i, 10) == 0
            draw3DView(chroms, '*b');
        end
    end

    
    final_chroms = chroms;
    best_fit = OFRevaluateFitness(best_chrom);
    
%     if (best_fit == 0.5 || best_fit == 0)
%         fprintf('*')
%     else
%         fprintf('|')
%     end
    fprintf('Best value found: %f\n', best_fit);
    
    figure
    plot(fit_max, 'b');
    hold on;
    plot(fit_min, 'k');
    plot(fit_avg, 'r');
    hold off;
    
    draw3DView(final_chroms, '*k');
end

