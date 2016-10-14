function [ tot_dist ] = ex1_calcPathDist( C, Dist )
    
    dim = size(C, 2);
    tot_dist = 0;
    
    for i= 1:dim-1
        tot_dist = tot_dist + Dist(C(i),C(i+1));
    end
    
    tot_dist = tot_dist + Dist(C(dim),C(1));

end

