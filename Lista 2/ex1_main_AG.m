function [ final_Cs, best_Cs ] = ex1_main_AG( cidades, n_Cs, n_gen )

    s = size(cidades,1);
    n_created = n_Cs/2;    % número de novos filhos que serão gerados
    mut_rate = 0.1;        % taxa de mutação

    % Inicializa primeira geração
    Cs = zeros(n_Cs, s);
    for i = 1:n_Cs
        Cs(i,:) = randperm(s);
    end
    
    Dist_matrix = ex1_calcDistMatrix(cidades);
    
    % valores para montagem do gráfico de distância mínima e média
    dist_min = zeros(n_gen, 1);
    dist_avg = zeros(n_gen, 1);

    best_Cs = zeros(1,s);
    
    for i = 1:n_gen
        % crossover para criar novos filhos e mutação
        new_Cs = ex1_reconbination(Cs, n_created); 
        new_Cs = ex1_mutation(new_Cs, mut_rate);
        
        % faz a seleção incluindo pais e filhos
        all_Cs = [Cs; new_Cs];
        dist = ex1_calcFitness(all_Cs,Dist_matrix);
        Cs = selectionTournament(all_Cs, 1./(1+dist), n_Cs-1, 2);
        
        [dist_min(i), pos] = min(dist);
        best_Cs = all_Cs(pos,:);
        
        % preserva o melhor individuo
        Cs(n_Cs, :) = best_Cs;
        
        dist_avg(i) = mean(dist);
        
    end

    
    final_Cs = Cs;
    best_dist = ex1_calcPathDist(best_Cs,Dist_matrix);
    
%     if (best_fit == 0.5 || best_fit == 0)
%         fprintf('*')
%     else
%         fprintf('|')
%     end
    fprintf('Best value found: %f\n', best_dist);
    
    figure(1)
    plot(dist_min, 'b');
    hold on;
    plot(dist_avg, 'r');
    hold off;
    
    figure(2)
    ex1_printPath(cidades(best_Cs,:));
    
end

