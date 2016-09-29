function [ fit ] = OFRevaluateFitness( chroms )

    X = chroms(:,1);
    Y = chroms(:,2);

    fit = X.*sin(4*pi*X) - Y.*sin(4*pi*Y + pi) + 1;

end

