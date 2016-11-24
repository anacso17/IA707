function [ fit ] = evaluation_v2(found_onsets, ground_truth)

    s = length(ground_truth);
    
    err_tot = 0;
    for i = 1:s
        pos = ground_truth(i);
        
        min_quad_err = min((found_onsets-pos).^2);
        err_tot = err_tot + min_quad_err;
        
    end

    % erro devido à diferença de onsets
    recall = abs(length(found_onsets)-s);
    err_tot = err_tot + recall*err_tot + recall^4;
    
    fit = 1/(1+err_tot);
    
end