% Faz crossover n_cross vezes
function [ new_Cs ] = ex1_reconbination( Cs, n_cross )

    s = size(Cs, 1);
    
    new_Cs = zeros(2*n_cross, size(Cs,2));
    
    for i = 1:n_cross
        P1 = Cs(randi(s),:);
        P2 = Cs(randi(s),:);
        
        [F1, F2] = ex1_crossover(P1, P2);
        
        new_Cs(2*i-1,:) = F1;
        new_Cs(2*i,:) = F2;
    end
    
end

