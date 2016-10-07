%
% evaluateFitness
% Avalia o fitness do vetor de cromossomos pegando o inverso da diferen�a
% da soma dos valores do grupo A (bit 1 no cromossomo) da soma do grupo B
% (bit 0 no cromossomo) somado a 1 (1/(1+abs(sumA-sumB)).
%
% Entrada: 
% chroms - cromossomos que ter�o o fitness avaliado 
% data - dados com os valores para calcular o fitness
% 
% S�ida:
% fitness_vec - vetor com o fitness para cada cromossomo
%

function [ fitness_vec ] = evaluateFitness( chroms, data )

    sumA = chroms * data;
    sumB = (1-chroms) * data;

    fitness_vec = 1./(1+abs(sumA-sumB));
end

