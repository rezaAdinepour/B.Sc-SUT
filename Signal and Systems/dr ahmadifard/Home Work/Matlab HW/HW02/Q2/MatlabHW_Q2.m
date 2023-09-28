% =====================================================
% in this program use SS_u.m for unit step function.
% SS_u and SS_D function file attached.
% =====================================================
clear;clc;close;


%% Question 1
% n = -5:5;
% x = SS_D(n+1)+2*SS_D(n+2);
% h = 2*SS_D(n)-SS_D(n-3); % Unit Impulse Response
% 
% convHX = conv(x, h);
% n_convHX = 2*n(1):2*n(end);
% 
% figure(1);
% subplot(2, 2, 1);
% stem(n, x, 'LineWidth', 3 );
% title('$x[n+1]$','interpreter', 'latex');
% grid on;
% grid minor;
% 
% subplot(2, 2, 2);
% stem(n, h, 'LineWidth', 3, 'color', '#FF0000');
% title('$h[n-1]$','interpreter', 'latex');
% grid on;
% grid minor;
% 
% subplot(2, 2, [3 4]);
% stem(n_convHX, convHX, 'LineWidth', 3, 'color', '#77AC30');
% title('$y[n]=x[n+1]*h[n-1]$','interpreter', 'latex');
% grid on;
% grid minor;

%% Question 2
% n = -10:10;
% x = ((0.5).^(n-1)).*(SS_u(n)-SS_u(n-10));
% h = ((3).^n).*(SS_u(-n+2)); % Unit Impulse Response
% 
% convHX = conv(x, h);
% n_convHX = 2*n(1):2*n(end);
% 
% figure(2);
% subplot(2, 2, 1);
% stem(n, x, 'LineWidth', 3 );
% title('$x[n]$','interpreter', 'latex');
% grid on;
% grid minor;
% 
% subplot(2, 2, 2);
% stem(n, h, 'LineWidth', 3, 'color', '#FF0000');
% title('$h[n]$','interpreter', 'latex');
% grid on;
% grid minor;
% 
% subplot(2, 2, [3 4]);
% stem(n_convHX, convHX, 'LineWidth', 3, 'color', '#77AC30');
% title('$y[n]=x[n]*h[n]$','interpreter', 'latex');
% grid on;
% grid minor;


%% Question 3
% t=-10:0.001:10;
% x = 2*exp(t-1).*SS_u(-t);
% h = exp(t+1).*(SS_u(t)-SS_u(t-5)); % Unit Impulse Response
% 
% 
% convHX = conv(x, h);
% t_convHX = 2*t(1):0.001:2*t(end);
% 
% figure(2);
% subplot(2, 2, 1);
% plot(t, x, 'LineWidth', 3 );
% title('$x[n]$','interpreter', 'latex');
% grid on;
% grid minor;
% 
% subplot(2, 2, 2);
% plot(t, h, 'LineWidth', 3, 'color', '#FF0000');
% title('$h[n]$','interpreter', 'latex');
% grid on;
% grid minor;
% 
% subplot(2, 2, [3 4]);
% plot(t_convHX, convHX, 'LineWidth', 3, 'color', '#77AC30');
% title('$y[n]=x[n]*h[n]$','interpreter', 'latex');
% grid on;
% grid minor;


%% Question 4
n = -10:10;
x = SS_u(n)-2*SS_u(n-2)+SS_u(n-6);
h = (1/2).^n .* SS_u(n); % Unit Impulse Response

convHX1 = conv(x, h);
n_convHX1 = 2*n(1):2*n(end);

figure(1);
subplot(2, 2, 1);
stem(n, x, 'LineWidth', 3);
title('$x[n]$','interpreter', 'latex');
grid on;
grid minor;
subplot(2, 2, 2);
stem(n, h, 'r', 'LineWidth', 3);
title('$h[n]$', 'interpreter', 'latex');
grid on;
grid minor;
subplot(2, 2, [3 4]);
stem(n_convHX1, convHX1, 'color', '#77AC30', 'LineWidth', 3);
title('$y1 = x[n]*h[n]$', 'interpreter', 'latex');
grid on;grid minor;