function [ best_fit, fit_max, best_x ] = simulated_anneling( Temp, n_iter, n_filters, graph_on, m ) 
    path = 'C:\tempTrab\Base';
    % number of cut frequencies
    D = 2*n_filters;

    temp_decrease = (Temp-1)/n_iter;
    
    filt = 0.001+0.998*rand(1,D);
    filt = sort(filt,2,'ascend');
    cut_freq = 10.^-(6+2*rand());
    %Temp = 50.0;
    x = [filt, cut_freq];
    
    fit_max = zeros(n_iter, 1);
    
    fit = fitness_v5(path,[filt, cut_freq],0,m);
    best_fit = 0;
    T = Temp;
    
    for i = 1:n_iter
        new_filt = min(max(filt -(T/Temp/2) + rand(1,D)*T/Temp, 0.001), 0.999);
        new_filt = sort(new_filt,2,'ascend');
        new_cut_freq = 10.^-8;
        
        new_fit = fitness_v5(path,[new_filt, new_cut_freq],0,m);
            
        dif = new_fit - fit;
        
        % guarda o melhor filtro
        if new_fit > best_fit
            best_fit = new_fit;
            best_x = [new_filt, new_cut_freq];
        end
        
        % altera o filtro atual
        if dif > 0
            fit = new_fit;
            x = [new_filt, new_cut_freq];
        else
            if rand() <= exp(600*dif/T)
                fit = new_fit;
                x = [new_filt, new_cut_freq];
            end
        end
        
        fprintf('%d: Fitness atual: %f\n%s\n', i, fit, mat2str(x, 3));
        fprintf('%s\nmudar:%f%%\n', mat2str([new_filt, new_cut_freq], 3), exp(500*dif/T));
        
        fit_max(i) = fit;

        T = T - temp_decrease;
    end
    
    fprintf('Best fitness: %f\n%s\n', best_fit, mat2str(best_x, 3));
    
    if graph_on
        figure
        plot((fit_max), 'b','LineWidth',2);
%         hold on;
%         plot((fit_avg), 'r','LineWidth',2);
%         hold off; 
        grid
        xlabel('Gerações','FontSize',11,'FontWeight','bold');
        ylabel('Fitness','FontSize',11,'FontWeight','bold');
    end    
end


