% PARA TESTES

function [ ] = fitnessMedioDe ( n_Cs, n_gen, n_filhos, n_reps)

sum_fit = [0 0];
for i = 1:n_reps
    [~, max_fitA] = ex2_main(n_Cs,n_gen,n_filhos,0);
    [~, max_fitB] = ex2_main2(n_Cs,n_gen,n_filhos,0);
    sum_fit = sum_fit+[max_fitA, max_fitB];
    %fprintf('%i- fitA: %f  fitB: %f\n', i, max_fitA, max_fitB);
    fprintf('-');
end
avg_fit = sum_fit./n_reps;
fprintf('\navg_fitA: %f | avg_fitB: %f\n', avg_fit(1), avg_fit(2));

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
