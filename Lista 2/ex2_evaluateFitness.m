function [ fit ] = ex2_evaluateFitness( Cs )

	X = Cs(:,1);
	Y = Cs(:,2);

	fit = X.*sin(4*pi*X) - Y.*sin(4*pi*Y + pi) + 1;

end
