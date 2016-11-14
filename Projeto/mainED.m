function [ max_fit, fit_max, best_filt ] = mainED( NP, CR, F, n_iter, n_filters, graph_on ) 

    % number of cut frequencies
    D = n_filters+2;

    % valores para montagem do gráfico de distância mínima e média
    fit_max = zeros(n_iter, 1);
    fit_avg = zeros(n_iter, 1);
    
    x = 0.5*rand(NP,D-1);
    x = sort(x,2,'ascend');
    x = [x 10.^-(6+2*rand(NP,1))];

    for i = 1:NP
        fitx(i) = fitness('C:\Users\AnaClara\Documents\MATLAB\EG507\Projeto\data_set',x(i,:));
    end
    
    u = zeros(NP,D);
    
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
            fitu(i) = fitness('C:\Users\AnaClara\Documents\MATLAB\EG507\Projeto\data_set',u(i,:));
            if fitu(i) > fitx(i) 
                x(i,:) = u(i,:);
                fitx(i) = fitu(i);
            end
        end
        
%         x
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

