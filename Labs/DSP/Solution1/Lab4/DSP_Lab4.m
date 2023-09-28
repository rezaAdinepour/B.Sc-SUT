%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 04                              ***
%        ****   Topic          : Moving Average Filter           ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************

clear; clc; close all;

% Generate a sample input signal
Fs = 1e3;
t = 0:1/Fs:1;
f = 5;
x = sin(2 * pi * f * t);
SNR = input('Enter the desired SNR value: ');
noisy_signal = add_noise(x, SNR);

% Calculate the legth of moving average filter
filter_length = input('Enter length of filter(must be odd): '); % [3, 5, 7, 9]

figure(1);
subplot(length(filter_length)+1, 2, 1);
plot(t, x);
title('input signal without noise');
xlabel('time');
ylabel('amplitude')
% grid on;
% grid minor;

subplot(length(filter_length)+1, 2, 2);
plot(t, noisy_signal);
title(['noisy signal with SNR = ', num2str(SNR), 'dB']);
xlabel('time');
ylabel('amplitude')
% grid on;
% grid minor;

for j=1:length(filter_length)
    filtered_signal = moving_average_filter(noisy_signal', filter_length(j));
    subplot(length(filter_length)+1, 2, j + 2);
    plot(t, filtered_signal);
    title(['filtered signal with N = ', num2str(filter_length(j))]);
    xlabel('time');
    ylabel('amplitude')
%     grid on;
%     grid minor;
end