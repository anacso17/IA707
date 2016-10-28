% PARA TESTES

function [ ] = calculaDesenpenhoMedio ( n_gen, n_reps)

%sum_fit = [0 0];

sumPA = 0;
sumPB = 0;
sumPC = 0;

n_filhosA = 100;
n_filhosB = 70;
NP = 20;

for i = 1:n_reps
    fprintf('\n\nRepetição %d\n', i);
    
    fprintf('Executando estratégia evolutiva (?,?)... ');
    tic;[~, max_fitA, fit_maxA] = ex2_main(10,n_gen,n_filhosA,0);toc;
    
    fprintf('Executando estratégia evolutiva (?+?)... ');
    tic;[~, max_fitB, fit_maxB] = ex2_main2(40,n_gen,n_filhosB,0);toc;
    
    fprintf('Executando evolução diferencial... ');
    tic;[~, fit_maxC] = ex2_evolucaoDiferencial(NP, 0.9, 0.5,[-1 2; -1 2], n_gen, 0);toc;
    
    if i<=5
        figure(100+i);
        plot(n_filhosA*(1:size(fit_maxA,1)), fit_maxA, 'r');
        hold on;
        plot(n_filhosB*(1:size(fit_maxB,1)), fit_maxB, 'b');
        plot((NP+1)*(1:size(fit_maxC,1)), fit_maxC, 'k');
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

fprintf('\nEE (?,?) encontra o máximo na média em  %f verificações\n', n_filhosA*sumPA/n_reps);
fprintf('EE (?+?) encontra o máximo na média em  %f verificações\n', n_filhosB*sumPB/n_reps);
fprintf('Evolução Diferencial encontra o máximo na média em  %f verificações\n', (NP+1)*sumPC/n_reps);

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
