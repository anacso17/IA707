 function  [ Cs, max_fit, fit_max ] = ex2_main( n_Cs, n_gen, lambda, graph_on)
    A = -1;
    B = 2;

    mut_rate = 0.1;         % taxa de mutação
    s = 2;       			% tamanho do cromossomo

    % valores para montagem do gráfico de distância mínima e média
    fit_max = zeros(n_gen, 1);
    fit_avg = zeros(n_gen, 1);

    % gera randomicamente cromossomos com valores entre A e B
    Cs = A+(B-A)*rand(n_Cs, s); 
    Omegas = rand(n_Cs, s);
    Thetas = 2*pi()*rand(n_Cs, 1);

    if graph_on
        figure(1)
        graph = draw3DView(Cs, '*k');
    end
    
    for i = 1:n_gen
        new_Cs = zeros(lambda, s);
        new_Omegas = zeros(lambda, s);
        new_Thetas = zeros(lambda, 1);
        
        for j = 1:lambda
            [new_Cs(j,:), new_Omegas(j,:), new_Thetas(j)] = ex2_recombina(Cs, Omegas, Thetas);
            [m_Cs, m_Om, m_Th] = ex2_mute(new_Cs(j,:), mut_rate, new_Omegas(j,:), new_Thetas(j));
            % se a mutação não for valida retoma os valores originais
            if m_Cs(1) >= -1 && m_Cs(1) <= 2 && m_Cs(2) >= -1 && m_Cs(2) <= 2
                new_Cs(j,:) = m_Cs;
                new_Omegas(j,:) = m_Om;
                new_Thetas(j) = m_Th;
            end
        end
        
        % lambida*n_gen avaliações de fitness
        % fitness dos filhos
        fit = ex2_evaluateFitness(new_Cs);
        
        selected_inds = selction_determ_ind(new_Cs, fit, n_Cs-1);
        Cs(1:n_Cs-1,:) = new_Cs(selected_inds,:);
        Omegas(1:n_Cs-1,:) = new_Omegas(selected_inds,:);
        Thetas(1:n_Cs-1) = new_Thetas(selected_inds);
        
        % dados para o grafico
        [fit_max(i), pos] = max(fit);
        fit_avg(i) = mean(fit);
                
        %salva melhor
        Cs(n_Cs,:) = new_Cs(pos,:);
        Omegas(n_Cs,:) = new_Omegas(pos,:);
        Thetas(n_Cs) = new_Thetas(pos);
        fit(n_Cs) = fit(pos);
        
        if graph_on
            set(graph, 'XData', Cs(:,1), 'YData', Cs(:,2));
            drawnow
        end

    end
    
    max_fit = max(fit);
    
    if graph_on
        figure(10);
        plot(fit_max, 'b');
        hold on;
        plot(fit_avg, 'r');
        hold off;
    end
end

