function [ new_Cs ] = PEmutate_v2( Cs, a, b )

    n_Cs = size(Cs, 1);
    s = size(Cs, 2);
    
    for i = 1:n_Cs
        for j = 1:s
            if j~=s
                r = a + (b-a)*0.01*rand();
                if randi([0 1]) == 1
                    new_Cs(i,j) = Cs(i,j) + r;
                else
                    new_Cs(i,j) = Cs(i,j) - r;
                end

                if new_Cs(i,j) < 0
                    new_Cs(i,j) = Cs(i,j);
                end
            else
                r = 10^-(6+2*rand());
                if randi([0 1]) == 1
                    new_Cs(i,j) = Cs(i,j) + r;
                else
                    new_Cs(i,j) = Cs(i,j) - r;
                end
            end
        end
        
    end
end

