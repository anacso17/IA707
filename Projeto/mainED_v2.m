function [ max_fit, fit_max, best_filt ] = mainED_v2( NP, CR, F, n_iter, n_filters, graph_on, m, div,sub ) 

    % number of cut frequencies
    D = 2*n_filters;

    % valores para montagem do gráfico de distância mínima e média
    fit_max = zeros(n_iter, 1);
    fit_avg = zeros(n_iter, 1);
    
    x = 0.5*rand(NP,D);
    x = sort(x,2,'ascend');
    x = [x 10.^-(6+2*rand(NP,1))];

    for i = 1:NP
        fitx(i) = fitness_v5('C:\Users\AnaClara\Documents\MATLAB\EG507\Projeto\data_set_3',x(i,:),0,m);
    end
    
    u = zeros(NP,D+1);
    
    for n_i = 1:n_iter
        for i = 1:NP
            vi = EDmutacao(x,F);
            u(i,:) = EDcrossover(x(i,:), vi, CR);
        end
        
        for  i = 1:NP
            u(i,:) = EDfix( u(i,:) );
        end
        u(:,1:end-1) = sort(u(:,1:end-1),2,'ascend');
        
        % NP*n_gen avaliações de fitness
        for i = 1:NP
            fitu(i) = fitness_v5('C:\Users\AnaClara\Documents\MATLAB\EG507\Projeto\data_set_3',u(i,:),0,m);
            if fitu(i) > fitx(i) 
                x(i,:) = u(i,:);
                fitx(i) = fitu(i);
            end
        end
        
        if mod(n_i,div) == 0
            aux = sortrows([ fitx' x ],-1);
            aux((NP-sub+1):NP,2:D+1) = 0.5*rand(sub,D);
            aux((NP-sub+1):NP,D+2) = 10.^-(6+2*rand(sub,1));
            for j = (NP-sub+1):NP
                aux(j,1) = fitness_v5('C:\Users\AnaClara\Documents\MATLAB\EG507\Projeto\data_set_3',aux(j,2:D+2),0,m);
            end
            x = aux(:,2:D+2);
            x(:,1:end-1) = sort(x(:,1:end-1),2,'ascend');
            fitx = aux(:,1)';
        end

        % dados para o grafico
        fit_max(n_i) = max(fitx);
        fit_avg(n_i) = mean(fitx);
        
        fprintf('População %i\n',n_i)
        for j = 1:NP
            fprintf('%s\n', mat2str(x(j,:), 3));
        end

    end
    
    [ max_fit, best ] = max(fitx); 
    best_filt = x(best,:); 
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

