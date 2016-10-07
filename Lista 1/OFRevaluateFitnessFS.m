function [ fit ] = OFRevaluateFitnessFS( chroms, thetaS, aS )

    x = chroms(:,1);
    y = chroms(:,2);

    fit = x.*sin(4*pi*x) - y.*sin(4*pi*y + pi) + 1;

    [X1, X2] = meshgrid(x);
    [Y1, Y2] = meshgrid(y);
    
    D = sqrt((X1-X2).^2 + (Y1-Y2).^2);
    
    sh = (1 - (D/thetaS).^aS) .* (D < thetaS);
    
    C = sum(sh, 2);
    
    fit = fit./C;
    
end

