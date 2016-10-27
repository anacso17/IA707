function [ win_inds ] = selction_determ_ind( Cs, fit, n_win )
	
	n_Cs = size(Cs,1);
    
    inds = 1:n_Cs;
    aux = sortrows([fit inds'],-1);
    win_inds = aux(1:n_win,2);

end

