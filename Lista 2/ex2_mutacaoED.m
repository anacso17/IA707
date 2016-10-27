function [ vi ] = ex2_mutacaoED( x, F )
    
    r = randperm(size(x, 1), 3);
    vi = x(r(1),:) + F*(x(r(3),:)-x(r(2),:));

%     ok = 0;
%     while ~ok
%         r = randperm(size(x, 1), 3);
%         vi = x(r(1),:) + F*(x(r(3),:)-x(r(2),:));
%         
%         if vi(1) >= -1 && vi(2) < 2
%             ok = 1;
%         end
%     end
    
end

