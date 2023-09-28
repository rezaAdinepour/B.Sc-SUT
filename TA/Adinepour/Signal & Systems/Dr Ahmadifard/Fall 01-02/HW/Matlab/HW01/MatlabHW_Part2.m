clear;clc;close all;


n = 0:50;

h = SS_u(n - 2) - 2 * SS_u(n - 5); % impulse response
x = SS_u(n) - SS_u(n - 10); % input signal

[y, n_y] = SS_conv(h, x, n(0), n(end), 0, 50);
stem(n_y, y);
title('$y = x[n]*h[n]$', 'interpreter', 'latex');