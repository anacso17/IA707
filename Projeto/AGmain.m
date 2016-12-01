function [ max_fit, fit_max, best_filt ] = AGmain( n_Cs , n_gen, n_filters, graph_on, m ) 

    path = 'C:\tempTrab\Base';     
    n_sons = 2*n_Cs;       % numero de filhos  
    mut_rate = 0.1;        % taxa de mutação
    tourn = 2;             % numero de integrantes do torneio
    
    % numero de frequencias de corte
    s = 2*n_filters;

    % valores para montagem do gráfico de distância mínima e média
    fit_max = zeros(n_gen, 1);
    fit_avg = zeros(n_gen, 1);
    
    % Inicializa primeira geração
    Cs = 0.5*rand(n_Cs,s);
    Cs = sort(Cs,2,'ascend');
    Cs = [Cs 10.^-(6+2*rand(n_Cs,1))];
    
    fit = zeros(size(Cs,1),1);
    for j = 1:size(Cs,1)
        fit(j) = fitness_v5(path,Cs(j,:),0,m);
    end
            
    for n_i = 1:n_gen
        %mutação em 10% da população
        new_Cs = AGmutate( Cs, 0, 0.5, mut_rate);
        new_Cs = AGcrossover( new_Cs, n_sons );
        
        for  j = 1:n_Cs
            new_Cs(j,:) = EDfix( new_Cs(j,:) );
        end
        new_Cs(:,1:end-1) = sort(new_Cs(:,1:end-1),2,'ascend');
        
        % 2*n_Cs*n_gen avaliações de fitness
        % calcula o fitness dos filhos
        new_fit = zeros(size(new_Cs,1),1);
        for j = 1:size(new_Cs,1)
            new_fit(j) = fitness_v5(path,new_Cs(j,:),0,m);
        end
        
        all_Cs = [Cs; new_Cs];
        all_fit = [fit; new_fit];
        
        % guarda o melhor individuo
        [fit_max(n_i), pos] = max(all_fit);
        best_C = all_Cs(pos,:);
        
        % faz a seleção incluindo pais e filhos
        [Cs, fit] = selectionTournament(all_Cs, all_fit, n_Cs-1, tourn);
        Cs(n_Cs, :) = best_C;
        fit(n_Cs) = fit_max(n_i);
        
%         for j = 1:size(Cs,1)
%             fit(j) = fitness_v5(path,Cs(j,:),0,m);
%         end

        % dados para o grafico
        fit_avg(n_i) = mean(fit);
        
        fprintf('População %i\n',n_i)
        for j = 1:n_Cs
            fprintf('%s\n', mat2str(Cs(j,:), 3));
        end

    end
    
    [ max_fit, best ] = max(fit); 
    best_filt = Cs(best,:); 
    fprintf('Best fitness: %f\n%s\n', max_fit, mat2str(best_filt, 3));
    
    if graph_on
        figure
        plot((fit_max), 'b','LineWidth',2);
        hold on;
        plot((fit_avg), 'r','LineWidth',2);
        hold off; 
        grid
        xlabel('Gerações','FontSize',11,'FontWeight','bold');
        ylabel('Fitness','FontSize',11,'FontWeight','bold');
    end
end

