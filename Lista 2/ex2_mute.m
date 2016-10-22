function [ new_X, new_Omega, new_Theta] = ex2_mute( X, mut_rate, Omega, Theta )
	
    if rand() < mut_rate
        s = size(X,2);

        Tal_linha = 1/2; 
        Tal = 1/sqrt(2*sqrt(2));
        Beta = 0.0873;
        N1 = randn();
        N2 = randn();

        new_Omega = zeros(1,s);
        for j = 1:s
            new_Omega(j) = Omega(j)*exp(Tal_linha*N1 + Tal*N2);
        end

        new_Theta = mod(Theta + Beta*N2, 2*pi());

        T = [cos(new_Theta), -sin(new_Theta) ; sin(new_Theta), cos(new_Theta)];
        
        new_X = X + (T'*diag(new_Omega)'*randn(s,1))';

    else % não ocorrerá mutação
        new_X = X;
        new_Omega = Omega;
        new_Theta = Theta;
    end
end


