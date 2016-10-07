function [ m_chrom ] = localSearchDouble( chrom, data )

    fit = evaluateFitness(chrom, data);     % fitness do cromossomo
    chrom_size = size(chrom, 2);            % tamanho do cromossomo
    
    for i = 1:chrom_size-1
        chrom(i) = 1 - chrom(i);    % muda bit

        if evaluateFitness(chrom, data) > fit
            break
        end

        % segunda troca
        for j = i+1:chrom_size
            chrom(j) = 1 - chrom(j);    % muda bit
        
            if evaluateFitness(chrom, data) > fit
                break
            else
                chrom(j) = 1 - chrom(j);   % reverte mudan�a j
            end
        end
        chrom(i) = 1 - chrom(i);   % reverte mudan�a i

    end
    
    m_chrom = chrom;        % n�o obteve melhora
end

