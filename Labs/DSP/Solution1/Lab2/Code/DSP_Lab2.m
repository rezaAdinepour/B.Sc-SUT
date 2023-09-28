%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 02                              ***
%        ****   Topic          : Customize Function              ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************
clear; clc; close all;

%% part1: test delta dirac function
N1 = -10;
N2 = 10;
n = N1:N2; %sequence range

f1 = SS_delta(n);
f2 = SS_delta(n - 2);
f3 = SS_delta(n, 3); %create pulse with pulse width = 2 * 3 + 1

figure('Name','delta dirac function');
subplot(3, 1, 1);
stem(n, f1, 'LineWidth', 1, 'Color', 'b');
title('$\delta[n]$', 'Interpreter','latex');
xlabel('$n$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
grid on;
grid minor;

subplot(3, 1, 2);
stem(n, f2, 'LineWidth', 1, 'color', '#77AC30');
title('$\delta[n - 2]$', 'Interpreter','latex');
xlabel('$n$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
grid on;
grid minor;

subplot(3, 1, 3);
stem(n, f3, 'LineWidth', 1, 'Color', 'r');
title('$u[n + 3]-u[n - 4]$', 'Interpreter','latex');
xlabel('$n$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
grid on;
grid minor;

%% part2: test pulse function
f4 = SS_u(n);
f5 = SS_u(n + 3);
f6 = SS_u(n + 4) - SS_u(n - 2);

figure('Name','pulse function');
subplot(3, 1, 1);
stem(n, f4, 'LineWidth', 1, 'Color', 'b');
title('$u[n]$', 'Interpreter','latex');
xlabel('$n$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
grid on;
grid minor;

subplot(3, 1, 2);
stem(n, f5, 'LineWidth', 1, 'color', '#77AC30');
title('$u[n + 3]$', 'Interpreter','latex');
xlabel('$n$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
grid on;
grid minor;

subplot(3, 1, 3);
stem(n, f6, 'LineWidth', 1, 'Color', 'r');
title('$u[n + 4]-u[n - 2]$', 'Interpreter','latex');
xlabel('$n$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
grid on;
grid minor;

%% part3: even and odd part of signals
f7 = [1 4 5 3 0 0 0 4 7 9 2 0 1 0 0 0 0 1 1 4 7];
% f7 = SS_u(n) - SS_u(n - 10);
if(length(f7) ~= length(n))
    disp('length not be same!')
else
    [f7e, f7o] = SS_eop(f7);
    
    figure('Name','even and odd part');
    subplot(3, 1, 1);
    stem(n, f7, 'LineWidth', 1, 'Color', 'b');
    title('$x[n]$', 'Interpreter','latex');
    xlabel('$n$', 'Interpreter','latex');
    ylabel('$y$', 'Interpreter','latex');
    grid on;
    grid minor;
    
    subplot(3, 1, 2);
    stem(n, f7e, 'LineWidth', 1, 'color', '#77AC30');
    title('$x_e[n] = Even\{x[n]\}$', 'Interpreter','latex');
    xlabel('$n$', 'Interpreter','latex');
    ylabel('$y$', 'Interpreter','latex');
    grid on;
    grid minor;
    
    subplot(3, 1, 3);
    stem(n, f7o, 'LineWidth', 1, 'Color', 'r');
    title('$x_o[n] = odd\{x[n]\}$', 'Interpreter','latex');
    xlabel('$n$', 'Interpreter','latex');
    ylabel('$y$', 'Interpreter','latex');
    grid on;
    grid minor;
end

%% part4: convolution of two sequence
[f8, n_y] = SS_conv(f6, f5, N1, N2, N1, N2);
f9 = conv(f6, f5);

figure('Name','convolution');
subplot(4, 1, 1);
stem(n, f6, 'LineWidth', 1, 'Color', 'b');
title('$u[n + 4]-u[n - 2]$', 'Interpreter','latex');
xlabel('$n$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
grid on;
grid minor;

subplot(4, 1, 2);
stem(n, f5, 'LineWidth', 1, 'color', '#77AC30');
title('$u[n + 3]$', 'Interpreter','latex');
xlabel('$n$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
grid on;
grid minor;

subplot(4, 1, 3);
stem(n_y, f8, 'LineWidth', 1, 'Color', 'r');
title('$y[n]=x[n]*h[n]\ with\ my\ function$', 'Interpreter','latex');
xlabel('$n$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
grid on;
grid minor;

subplot(4, 1, 4);
stem(n_y, f9, 'LineWidth', 1, 'Color', 'black');
title('$y[n]=x[n]*h[n]$\ with\ matlab\ function', 'Interpreter','latex');
xlabel('$n$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
grid on;
grid minor;