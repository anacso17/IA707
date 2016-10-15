function [P] = ex1_mainPE(cidades, n_Cs, n_gen, q)

    s = size(cidades,1);
    mut_rate = 0.8;        % taxa de mutação

    % valores para montagem do gráfico de distância mínima e média
    dist_min = zeros(n_gen, 1);
    dist_avg = zeros(n_gen, 1);

    % Inicializa primeira geração
    Cs = zeros(n_Cs, s);
    for i = 1:n_Cs
        Cs(i,:) = randperm(s);
    end

    Dist_matrix = ex1_calcDistMatrix(cidades);
    dist = ex1_calcFitness(Cs,Dist_matrix);

    best_Cs = zeros(1,s);

    for i = 1:n_gen
        %mutação em 100% da população
        filhos = ex1_mutation(Cs, mut_rate);
        dist_filhos = ex1_calcFitness(Cs, Dist_matrix);

        %seleção por torneio estocástico
        fit = 1./(1+[dist;dist_filhos]);
        [Cs,fit] = ex1_torneioPE([Cs;filhos], fit, q);
        dist = 1./fit - 1;

        [dist_min(i), pos] = min(dist);
        best_Cs = Cs(pos,:);
        dist_avg(i) = mean(dist);
    end

    best_dist = ex1_calcPathDist(best_Cs,Dist_matrix);
    fprintf('Best value found: %f\n', best_dist);

    figure(1)
    plot((dist_min), 'b','LineWidth',2);
    hold on;
    plot((dist_avg), 'r','LineWidth',2);
    hold off;
    
    grid
    xlabel('Gerações','FontSize',12,'FontWeight','bold');
    ylabel('Distância','FontSize',12,'FontWeight','bold');

    figure(2)
    ex1_printPath(cidades(best_Cs,:));
    
end