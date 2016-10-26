function [ max_fit ] = ex2_evolucaoDiferencial( NP, CR, F, range, n_iter, graph_on ) 

    D = size(range,1);

    % valores para montagem do gráfico de distância mínima e média
    fit_max = zeros(n_iter, 1);
    fit_avg = zeros(n_iter, 1);
    
    % range é igual a uma matrix do tipo
    % [ min(x) max(x); 
    %   min(y) max(y);
    %   min(z) max(z);
    %  ...]
    % Deve ter dimensão D
    x = (range(:,1)*ones(1,NP))' +...
        ((range(:,2)-range(:,1))*ones(1,NP))'.*rand(NP,D);
    
    if graph_on
        figure(1)
        graph = draw3DView(x, '*k');
    end

    fitx = ex2_evaluateFitness(x);
    
    u = zeros(NP, D);
    
    for n_i = 1:n_iter
        for i = 1:NP
            vi = ex2_mutacaoED(x,F);
            u(i,:) = ex2_crossoverED(x(i,:), vi, CR);
        end
        
        fitu = ex2_evaluateFitness(u);
        for i = 1:NP
            if fitu(i) > fitx(i) && ex2_factivel(u(i,:), range)
                x(i,:) = u(i,:);
                fitx(i) = fitu(i);
            end
        end
        
        % dados para o grafico
        fit_max(n_i) = max(fitx);
        fit_avg(n_i) = mean(fitx);
        
        if graph_on
            set(graph, 'XData', x(:,1), 'YData', x(:,2));
            drawnow
        end

    end
    
    max_fit = max(fitx);
    
    if graph_on
        figure(10);
        plot(fit_max, 'b');
        hold on;
        plot(fit_avg, 'r');
        hold off;
    end
end

