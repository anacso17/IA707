%
% evaluateEvolutionParam
% função para testes de diferentes parâmetros (população e número de 
% gerações) para o algoritmo
%

function [ results ] = evaluateEvolutionParam( data )

    n_reps = 20;
    max_ps = 200;
    max_gens = 200;
    
    ps_vals = 200:20:max_ps;
    gens_vals = 200:50:max_gens;

    results = zeros(size(ps_vals,1), size(gens_vals,1));
    
    i = 0;
    j = 0;
    for ps = ps_vals
        i = i + 1;
        for gens = gens_vals
            j = j + 1;
            sum_best_fit = 0;
            for rep = 1:n_reps
                [~, b] = geneticEvolution(data, ps, gens);
                best_fit = evaluateFitness(b,data);
                sum_best_fit = sum_best_fit+(1/best_fit-1);
                 if best_fit == 0.5
                     fprintf('*')
                 else
                     fprintf('|')
                 end
            end
            results(i,j) = sum_best_fit/n_reps; 
            fprintf('\nindv: %d; gens: %d; avg_best: %f\n', ps, gens, results(i,j))
        end
    end
end

