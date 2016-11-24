%   Crossover aritmetico

function [ new_Cs ] = AGcrossover( Cs, n_new )

    n_Cs = size(Cs, 1);
    s = size(Cs, 2);
    
    new_Cs = zeros(n_new, s);
    
    for i = 1:n_new
        Xa = Cs(randi(n_Cs,1), :);
        Xb = Cs(randi(n_Cs,1), :);

        for j = 1:s
            r = rand();
            new_Cs(i,j) = r*Xa(j) + (1-r)*Xb(j);
        end
    end
end

