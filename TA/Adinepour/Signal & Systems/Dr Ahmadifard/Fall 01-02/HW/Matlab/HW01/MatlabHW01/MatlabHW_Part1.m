clear;clc;close all;

n = 0:50;
h = (1/2).^n; % impulse response .* ./
x = SS_u(n) - SS_u(n - 10); % input signal

% h = SS_u(n - 2) - 2 * SS_u(n - 5); % impulse response
% x = SS_u(n) - SS_u(n - 10); % input signal

y = conv(x, h);
n_y = 2*n(1):2*n(end);

figure(1);
subplot(2, 2, 1);
stem(n, x);
title('input signal', '$x[n]$', 'Interpreter','latex')
% title('input signal x[n}')

subplot(2, 2, 2);
stem(n, h);
title('impulse response', '$h[n]$', 'Interpreter','latex')

subplot(2, 2, [3, 4]);
stem(n_y, y);
title('$y = x[n]*h[n]$', 'interpreter', 'latex');