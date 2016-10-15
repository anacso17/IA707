function ex1_printPath( data )
    
    tam = size(data,1);

    scatter(data(:,1), data(:,2), 'ok');
    hold on
    plot(data(:,1), data(:,2), '-k', 'LineWidth', 2);
    % linha ligando a cidade final à inicial
    plot([data(tam,1),data(1,1)], [data(tam,2), data(1,2)], '-k', 'LineWidth', 2);
    grid on
    hold off

end

