function [y] = ss_step(n1, n2, n0)
    n = n1:n2;
    y = [(n - n0) >= 0];
end