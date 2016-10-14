function [ vet_fitness ] = ex1_calcFitness( Cs, Dist )

    s = size(Cs,1);
    vet_fitness = zeros(s,1);

    for i = 1:s
        vet_fitness(i) = ex1_calcPathDist(Cs(i,:),Dist);
    end
    
end

