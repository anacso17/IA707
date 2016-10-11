function [ new_Cs, new_fit ] = ex1_torneioPE(Cs, fit, q)

s = size(Cs,1);
v = zeros(s,1);

for i = 1:s
    for j = 1:q
        cara = randi(s);
        
        if fit(i) >= fit(cara)
            v(i) = v(i) + 1;
        end       
    end
end

indices = knnsearch(v,q,'K',s/2);
new_Cs = Cs(indices,:); 

new_fit = fit(indices);

end