function [ value ] = OFRmutNUniforme( t, y, T, p)
    
    value = y*(1-rand()^((1-t/T)^p));

end