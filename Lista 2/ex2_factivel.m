function [ out ] = ex2_factivel( x, range )

    out = 0;
    
    if x'>=range(:,1) & x'<range(:,2)
        out = 1;
    end

end

