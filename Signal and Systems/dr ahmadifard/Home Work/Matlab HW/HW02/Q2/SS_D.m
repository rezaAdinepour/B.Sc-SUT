function [y] = SS_D(n)

% SS_D returns unit response function
% SS_D( n ) retutns the value 0 for n < 0, n > 0 and 1 for n = 0.

y = 0.*(n<=-1)+0.*(n>=1)+1.*(n==0);

end