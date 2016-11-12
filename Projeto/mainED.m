function [ max_fit, fit_max, best_filt ] = mainED( NP, CR, F, n_iter, n_filters, graph_on ) 

    % number of cut frequencies
    D = n_filters+1;

    % valores para montagem do gráfico de distância mínima e média
    fit_max = zeros(n_iter, 1);
    fit_avg = zeros(n_iter, 1);
    
    x = 0.25*rand(NP,D);
    x = sort(x,2,'ascend')

    for i = 1:NP
        fitx(i) = fitness('C:\Users\AnaClara\Documents\MATLAB\EG507\Projeto\Base',x(i,:));
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
        u = sort(u,2,'ascend');
        
        % NP*n_gen avaliações de fitness
        for i = 1:NP
            fitu(i) = fitness('C:\Users\AnaClara\Documents\MATLAB\EG507\Projeto\Base',u(i,:));
            if fitu(i) > fitx(i) 
                x(i,:) = u(i,:);
                fitx(i) = fitu(i);
            end
        end
        x
        % dados para o grafico
        fit_max(n_i) = max(fitx);
        fit_avg(n_i) = mean(fitx);

    end
    
    [ max_fit, best ] = max(fitx);
    best_filt = x(best,:);
    
    if graph_on
        figure(10);
        plot(fit_max, 'b');
        hold on;
        plot(fit_avg, 'r');
        hold off;
    end
end

