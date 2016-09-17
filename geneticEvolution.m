%
% geneticEvolution: Algoritmo genético
%
% Parâmetros e variáveis
% data - 
% n_chroms - 
% n_gen - 
% n_created - 
% mut_rate - 
% s -
% best_chrom - 
% all - chroms - 
% fit_max - 
% fit_min - 
% fit_avg - 
% chroms - 
% new_chroms - 
% fit - 
% pos - 
%

function [ final_chroms, best_chrom ] = geneticEvolution( data, n_chroms, n_gen )
%GENETICSELECTION Summary of this function goes here
%   Detailed explanation goes here

    n_created =5*n_chroms;
    mut_rate = 0.05;            %taxa de mutação normalmente é baixa
    
    s = size(data,1);
    best_chrom = zeros(1,s);
    
    chroms = randi([0,1], n_chroms, s);
    
    fit_max = zeros(n_gen, 1);
    fit_min = zeros(n_gen, 1);
    fit_avg = zeros(n_gen, 1);
    
    for i = 1:n_gen
        new_chroms = crossover(chroms, n_created);
        new_chroms = mutate(new_chroms, mut_rate);
        
        % faz a seleção incluindo pais e filhos
        all_chroms = [chroms; new_chroms];
        
        fit = evaluateFitness(all_chroms, data);
        
        chroms = selectionTournament(all_chroms, fit, n_chroms-1, 2);
        
        [fit_max(i), pos] = max(fit);
        % preserva o melhor individuo
        best_chrom = all_chroms(pos,:);
        chroms(n_chroms, :) = best_chrom;
        
        fit_min(i) = min(fit);
        fit_avg(i) = mean(fit);
    end

    final_chroms = chroms;
   
    best_fit = evaluateFitness(best_chrom,data);
    
    if (best_fit == 0.5 || best_fit == 0)
        fprintf('*')
    else
        fprintf('|')
    end
    fprintf('%d', 1/best_fit-1);
    
    plot(log10(fit_max), 'b');
    hold on;
    plot(log10(fit_min), 'k');
    plot(log10(fit_avg), 'r');
    hold off;
        
end

