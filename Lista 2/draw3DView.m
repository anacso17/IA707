function [ sc ] = draw3DView( chroms , type)
    
    x = linspace(-1,2,200);
    y = linspace(-1,2,200);
    [X,Y] = meshgrid(x,y);
    Z = X.*sin(4*pi*X) - Y.*sin(4*pi*Y + pi) + 1;
    
    
    contour(X,Y,Z,20)
    hold on
    sc = scatter(chroms(:,1), chroms(:,2), type);
    hold off
    %figure
    %C = del2(-Z);
    %surf(X,Y,Z,C)
end

