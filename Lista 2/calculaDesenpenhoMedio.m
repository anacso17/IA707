% PARA TESTES

function [ ] = calculaDesenpenhoMedio ( n_Cs, n_gen, n_filhos, n_reps)

sum_fit = [0 0];

sumPA = 0;
sumPB = 0;
sumPC = 0;

for i = 1:n_reps
    fprintf('\n\nRepetição %d\n', i);
    
    fprintf('Executando estratégia evolutiva (?,?)... ');
    tic;[~, max_fitA, fit_maxA] = ex2_main(n_Cs,n_gen,n_filhos,0);toc;
    
    fprintf('Executando estratégia evolutiva (?+?)... ');
    tic;[~, max_fitB, fit_maxB] = ex2_main2(n_Cs,n_gen,n_filhos,0);toc;
    
    fprintf('Executando evolução diferencial... ');
    tic;[~, fit_maxC] = ex2_evolucaoDiferencial(n_filhos, 0.9, 0.5,[-1 2; -1 2], n_gen, 0);toc;
    
    if i<=5
        figure(100+i);
        plot(fit_maxA, 'r');
        hold on;
        plot(fit_maxB, 'b');
        plot(fit_maxC, 'k');
        hold off;
    end
    
    pA = genToMax(fit_maxA, 4.2539);
    pB = genToMax(fit_maxB, 4.2539);
    pC = genToMax(fit_maxC, 4.2539);

    fprintf('Repetições para chegar ao melhor valor:\n');
    fprintf('EE(?,?): %f   EE(?+?): %f   EvDiff: %f\n', pA, pB, pC);
    
    sumPA = sumPA + pA;
    sumPB = sumPB + pB;
    sumPC = sumPC + pC;
    
    %sum_fit = sum_fit+[max_fitA, max_fitB];
    %fprintf('%i- fitA: %f  fitB: %f\n', i, max_fitA, max_fitB);
    %fprintf('-');
    
end
%avg_fit = sum_fit./n_reps;
%fprintf('\navg_fitA: %f | avg_fitB: %f\n', avg_fit(1), avg_fit(2));

fprintf('\nEE (?,?) encontra o máximo na média em  %f gerações\n', sumPA/n_reps);
fprintf('EE (?+?) encontra o máximo na média em  %f gerações\n', sumPB/n_reps);
fprintf('Evolução Diferencial encontra o máximo na média em  %f gerações\n', sumPC/n_reps);

% n_Cs = 200;
% n_gens = 200;
% n_filhos = 10;
% 
% ex2_main2(3,200,70,0);
% 
% results = 
% 
% i = 0;
% j = 0;
% k = 0;
% for p1 = n_Cs
%     i = i + 1;
%     for gens = gens_vals
%         j = j + 1;
%         sum_best_fit = 0;
%         for rep = 1:n_reps
%             [~, b] = geneticEvolution(data, ps, gens);
%             best_fit = evaluateFitness(b,data);
%             sum_best_fit = sum_best_fit+(1/best_fit-1);
%              if best_fit == 0.5
%                  fprintf('*')
%              else
%                  fprintf('|')
%              end
%         end
%         results(i,j) = sum_best_fit/n_reps; 
%         fprintf('\nindv: %d; gens: %d; avg_best: %f\n', ps, gens, results(i,j))
%     end
% end
