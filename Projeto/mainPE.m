function [ best ] = mainPE(n_filters, n_Cs, n_gen, q)
    
    s = n_filters+1;

    % valores para montagem do gráfico de distância mínima e média
    fit_max = zeros(n_gen, 1);
    fit_avg = zeros(n_gen, 1);

    % Inicializa primeira geração
    Cs = 0.25*rand(n_Cs,s);
    Cs = sort(Cs,2,'ascend');
    Cs = [Cs 10.^-(6+2*rand(n_Cs,1))];

    for i = 1:n_Cs
        fit(i,1) = fitness('C:\Users\AnaClara\Documents\MATLAB\EG507\Projeto\data_set',Cs(i,:));
    end
    
    best_Cs = zeros(1,s);

    for i = 1:n_gen
        %mutação em 100% da população
        filhos = PEmutate_v2( Cs, 0, 0.5 );
        for  j = 1:n_Cs
            filhos(j,:) = EDfix( filhos(j,:) );
        end    
        filhos(:,1:end-1) = sort(filhos(:,1:end-1),2,'ascend');
        for j = 1:n_Cs
            fit_filhos(j,1) = fitness('C:\Users\AnaClara\Documents\MATLAB\EG507\Projeto\data_set',filhos(j,:));
        end

        %seleção por torneio estocástico
        Cs = [Cs;filhos];
        fit = [fit;fit_filhos];
        [Cs,fit] = PEtorneio(Cs, fit, q);

        [fit_max(i,1), pos] = max(fit);
        best_Cs = Cs(pos,:);
        fit_avg(i,1) = mean(fit);
        
%         Cs
        fprintf('População %i\n',i)
        for j = 1:n_Cs
            fprintf('%s\n', mat2str(Cs(j,:), 3));
        end
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