function [ results ] = evaluateEvolutionParam( data )
%EVALUATEEVOLUTIONPARAM Summary of this function goes here
%   Detailed explanation goes here

    n_reps = 30;
    max_ps = 100;
    max_gens = 2000;
    
    ps_vals = 20:20:max_ps;
    gens_vals = 50:100:max_gens;

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
                sum_best_fit = sum_best_fit+evaluateFitness(b,data);
            end
            results(i,j) = sum_best_fit/max_gens; 
            fprintf('indv: %d; gens: %d; avg_best: %e\n', ps, gens, results(i,j))
        end
    end
end

