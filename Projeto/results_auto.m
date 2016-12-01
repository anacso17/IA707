path = 'C:\tempTrab\Base';
pathTeste = 'C:\tempTrab\teste';

% diary results_ED_2filt
% 
% for i=1:10
%     fprintf('Execucao %i - ED, 2 filtros\n', i);
%         
%     [fit, ~, best_filt] = AGmain(10, 100, 2, 1, 8);
%     [fit2 ] = fitness_v5(pathTeste, best_filt, 1, 25);
%     fprintf('Fitness para 25 musicas: %f\n', fit2);
% end
% 
% diary off

diary results_ED_6filt

for i=1:1
    fprintf('Execucao %i - ED, 6 filtros\n', i);
            
    tic;[fit, ~, best_filt] = AGmain(10, 100, 6, 1, 8);toc;
    [fit2 ] = fitness_v5(pathTeste, best_filt, 1, 25);
    fprintf('Fitness para 25 musicas: %f\n', fit2);    
end

diary off