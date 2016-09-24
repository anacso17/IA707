function [ fitness ] = evaluateFitnessKnapsack( chroms, p, v, c, opt)

    valor = chroms * v;
    peso = chroms * p;
    
    fitness = 1./(1+abs(opt-valor)+opt.*(peso>c));

end

