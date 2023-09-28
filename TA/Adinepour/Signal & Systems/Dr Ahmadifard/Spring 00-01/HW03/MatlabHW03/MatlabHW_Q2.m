% =====================================================
% in this program use SS_u.m for unit step function.
% SS_u function file attached.
% =====================================================

clear;clc;close;
n = -50:50;
h = (1/3).^n .* SS_u(n); %Unit Impulse Response
X1 = SS_u(n)-SS_u(n-10);
X2 = n.*((n>=0)&(n<=10)) + (20-n).*((n>=11)&(n<=20)) + 0.*((n>=-50)&(n<=1));
convHX1 = conv(X1, h);
n_convHX1 = 2*n(1):2*n(end);
convHX2 = conv(X2, h);
figure(1);
subplot(3,3,1);
stem(n, X1, 'LineWidth', 0.8);
title('$x1[n]$','interpreter', 'latex');
grid on;grid minor;
subplot(3,3,2);
stem(n, X2, 'LineWidth', 0.8);
title('$x2[n]$','interpreter', 'latex');
grid on;grid minor;
subplot(3,3,3);
stem(n, h, 'r', 'LineWidth', 0.8);
title('$h[n]$', 'interpreter', 'latex');
grid on;grid minor;
subplot(3,3,[4 5 6]);
stem(n_convHX1, convHX1, 'color', '#77AC30', 'LineWidth', 0.8);
title('$y1 = x1[n]*h[n]$', 'interpreter', 'latex');
grid on;grid minor;
subplot(3,3,[7 8 9]);
stem(n_convHX1, convHX2, 'color', '#7E2F8E', 'LineWidth', 0.8);
title('$y2 = x2[n]*h[n]$', 'interpreter', 'latex');
grid on;grid minor;