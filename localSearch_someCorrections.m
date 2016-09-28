function [ m_chrom ] = localSearch_someCorrections( chrom, data )

    fit = evaluateFitness(chrom, data);     % fitness do cromossomo
    chrom_size = size(chrom, 2);            % tamanho do cromossomo
    
    for i = 1:chrom_size
        chrom(i) = 1 - chrom(i);    % muda bit
        
        if evaluateFitness(chrom, data) < fit
            chrom(i) = 1 - chrom(i);   % reverte mudança
        end
    end
    
    m_chrom = chrom;        
end

