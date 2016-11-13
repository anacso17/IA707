function [ new_Cs, new_fit ] = PEtorneio(Cs, fit, q)

    s = size(Cs,1);
    col = size(Cs,2);
    v = zeros(s,1);

    for i = 1:s
        for j = 1:q
            cara = randi(s);

            if fit(i) >= fit(cara)
                v(i,1) = v(i,1) + 1;
            end       
        end
    end

    aux = sortrows([v Cs fit],-1);
    new_Cs = aux(1:s/2,2:col+1);
    new_fit = aux(1:s/2,col+2);

end