function [y] = SS_u(t, v0)

% SS_U returns unit step function
% SS_u( t ) retutns the value 0 for t < 0, and 1 for t >= 0.
% SS_u( t , v0 ) retutns the value 0 for t < 0, 1 for t > 0, % and v0 for t = 0.

if nargin == 1
    v0 = 1;
end
y = (t>0)+v0*(t==0);

end

