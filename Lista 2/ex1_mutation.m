function [ out_Cs ] = ex1_mutation( Cs, mut_rate )

    s = size(Cs,1);
    out_Cs = Cs;
    
    for i = 1:s
        if rand() < mut_rate
            out_Cs(i,:) = ex1_mutate(Cs(i,:));
        end
    end

end

