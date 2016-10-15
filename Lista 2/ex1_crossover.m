function [ F1, F2 ] = ex1_crossover( P1, P2 )

    s = size(P1, 2);
    
    % posições de corte
    i1 = randi(s);
    i2 = randi(s);

    % i1 deve ser menor que i2
    if i1 > i2
        i = i1;
        i1 = i2;
        i2 = i;
    end
    
    % filhos
    F1 = P1;
    F2 = P2;

    % informação se a posição já foi usada no filho
    M1 = zeros(s,1);
    M2 = zeros(s,1);
    
    % marca as posições que serão copiadas para os filhos
    for i = i1:i2
        M1(P1(i)) = 1;
        M2(P2(i)) = 1;
    end
    
    i = i2+1;
    if i > s
        i = 1;
    end
    j1 = i; j2 = i;
    
    % altera o resto de cada filho
    while i ~= i1
        
        % encontra o próximo valor para o filho 1 no pai 2
        while M1(P2(j1)) == 1
            j1 = j1 + 1;
            if j1 > s       % reseta a posição para 1
                j1 = 1;
            end
        end
        
        M1(P2(j1)) = 1;
        F1(i) = P2(j1);
        
        % encontra o próximo valor para o filho 2 no pai 1
        while M2(P1(j2)) == 1
            j2 = j2 + 1;
            if j2 > s       % reseta a posição para 1
                j2 = 1;
            end
        end
        
        M2(P1(j2)) = 1;
        F2(i) = P1(j2);
        
        i = i + 1;
        if i > s
            i = 1;
        end
    end
    
end

    