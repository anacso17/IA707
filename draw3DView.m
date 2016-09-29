function [  ] = draw3DView(  )
    
    x = linspace(-1,2,200);
    y = linspace(-1,2,200);
    [X,Y] = meshgrid(x,y);
    Z = X.*sin(4*pi*X) - Y.*sin(4*pi*Y + pi) + 1;

    %figure
    %contour(X,Y,Z,20)
    figure
    C = del2(-Z);
    surf(X,Y,Z,C)
end

