function [ Dist ] = ex1_calcDistMatrix( data )

    x = data(:,1);
    y = data(:,2);

    [X1,X2] = meshgrid(x);
    [Y1,Y2] = meshgrid(y);

    Dist = sqrt((X1-X2).^2 + (Y1-Y2).^2);
    
end

