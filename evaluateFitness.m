function [ fitness_vec ] = evaluateFitness( chroms, data )
%EVALUATEFITNESS Summary of this function goes here
%   Detailed explanation goes here

    sumA = chroms * data;
    sumB = (1-chroms) * data;

    fitness_vec = 1./(1+abs(sumA-sumB));
end

