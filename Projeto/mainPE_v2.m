function [ best_C ] = mainPE_v2( n_Cs, n_gen, q, n_filters, m )
    
    s = 2*n_filters;

    % valores para montagem do gráfico de distância mínima e média
    fit_max = zeros(n_gen, 1);
    fit_avg = zeros(n_gen, 1);

    % Inicializa primeira geração
    Cs = 0.5*rand(n_Cs,s);
%     Cs = sort(Cs,2,'ascend');
    Cs = [Cs 10.^-(6+2*rand(n_Cs,1))];
%     n_filters = randi([2 20],n_Cs,1);
%     factor = 1.01+(5 - 1.01)*rand(n_Cs,1);
%     initial_freq = 0.2*rand(n_Cs,1);
%     Cs = [initial_freq factor n_filters];

    for i = 1:n_Cs
        fit(i,1) = fitness_v5('C:\Users\AnaClara\Documents\MATLAB\EG507\Projeto\data_set',Cs(i,:),0,m);
    end
    
    best_C = zeros(1,s);

    for i = 1:n_gen
        %mutação em 100% da população
        filhos = PEmutate_v2( Cs, 0, 0.5 );
%         filhos = PEmutation( Cs, i, 0, 0.5, n_gen, 3);
        for  j = 1:n_Cs
            filhos(j,:) = EDfix( filhos(j,:) );
        end    
%         filhos(:,1:end-1) = sort(filhos(:,1:end-1),2,'ascend');

        for j = 1:n_Cs
            fit_filhos(j,1) = fitness_v5('C:\Users\AnaClara\Documents\MATLAB\EG507\Projeto\data_set',filhos(j,:),0,m);
        end

        %seleção por torneio estocástico
        Cs = [Cs;filhos];
        fit = [fit;fit_filhos];
        [Cs,fit] = PEtorneio(Cs, fit, q);

        [fit_max(i,1), pos] = max(fit);
        best_C = Cs(pos,:);
        fit_avg(i,1) = mean(fit);
        
        fprintf('%i/%i\n',i,n_gen)
        for j = 1:n_Cs
            fprintf('%s\n', mat2str(Cs(j,:), 3));
        end
        fprintf('Fitness - melhor: %f\n%s\n', fit(pos),mat2str(best_C, 3));
    end
    
    [ max_fit, best ] = max(fit); 
    best_filt = Cs(best,:); 
    fprintf('Best fitness: %f\n%s\n', max_fit, mat2str(best_filt, 3));

    figure
    plot((fit_max), 'b','LineWidth',2);
    hold on;
    plot((fit_avg), 'r','LineWidth',2);
    hold off; 
    grid
    xlabel('Gerações','FontSize',11,'FontWeight','bold');
    ylabel('Fitness','FontSize',11,'FontWeight','bold');
    
end