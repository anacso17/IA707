function [ win, fit_win ] = selctionTournament_determ( Cs, fit, n_win )
	
	n_Cs = size(Cs,1);
    s_Cs = size(Cs,2);

    aux = sortrows([fit Cs],-1);
    win = aux(1:n_win,2:s_Cs+1);
    fit_win = aux(1:n_win,1);

end

