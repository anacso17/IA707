function [ ui ] = ex2_crossoverED( xi, vi, CR )

    D = size(xi,2);
    r = rand(D,1);
    li = randi(D);
    
    ui = zeros(1,D);
    
    for j = 1:D
        if r(j) <= CR || j == li
            ui(j) = vi(j);
        else
            ui(j) = xi(j);
        end
    end           

end

