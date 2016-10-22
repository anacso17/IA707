function [ new_Cs, new_Omega, new_Theta ] = ex2_recombina( Cs, Omegas, Thetas )

    n_Cs = size(Cs, 1);
    s = size(Cs, 2);

    Ia = randi(n_Cs ,1);
    Ib = randi(n_Cs ,1);
    Xa = Cs(Ia, :);
    Xb = Cs(Ib, :);
    Oma = Omegas(Ia,:);
    Omb = Omegas(Ib,:);
    Tha = Thetas(Ia);
    Thb = Thetas(Ib);

    new_Cs = zeros(1,s);
    new_Omega = zeros(1,s);
    
    for j = 1:s
        r = rand();
        new_Cs(j) = r*Xa(j) + (1-r)*Xb(j);
    end

    for j = 1:s
        r = rand();
        new_Omega(j) = r*Oma(j) + (1-r)*Omb(j);
    end

    r = rand();
    new_Theta = r*Tha + (1-r)*Thb;

end
    


