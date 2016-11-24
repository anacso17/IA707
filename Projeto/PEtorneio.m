function [ new_Cs, new_fit ] = PEtorneio(Cs, fit, q)

    n_Cs = size(Cs,1);
    s = size(Cs,2);
    v = zeros(n_Cs,1);

    for i = 1:n_Cs
        for j = 1:q
            cara = randi(n_Cs);

            if fit(i) >= fit(cara)
                v(i,1) = v(i,1) + 1;
            end       
        end
    end

    aux = sortrows([v Cs fit],-1);
    new_Cs = aux(1:n_Cs/2,2:end-1);
    new_fit = aux(1:n_Cs/2,end);

end