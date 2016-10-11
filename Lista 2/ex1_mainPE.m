function [P] = ex1_mainPE(cidades, nCs, ngen, q)

s = size(cidades,1);

% valores para montagem do gráfico de distância mínima e média
dist_min = zeros(n_gen, 1);
dist_avg = zeros(n_gen, 1);

for i = 1:nCs
    randperm(
end

dist = ex1_fitness(...);


for i = 1:ngen
    %mutação em 100% da população
    filhos = ex1_mutation(...);
    dist_filhos = ex1_fitness(...);
    
    %seleção por torneio estocástico
    fit = 1./(1+[dist;dist_filhos]);
    [Cs,fit] = ex1_torneio([Cs;filhos], fit, q);
    dist = 1./fit - 1;
    
    dist_min(i) = min(dist);
    dist_avg(i) = mean(dist);
end

    figure
    plot((dist_min), 'b','LineWidth',2);
    hold on;
    plot((dist_avg), 'r','LineWidth',2);
    hold off;
    
    grid
    xlabel('Gerações','FontSize',12,'FontWeight','bold');
    ylabel('Distância','FontSize',12,'FontWeight','bold');
end