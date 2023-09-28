%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 03                              ***
%        ****   Topic          : Generate Noise Function         ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************

clear; clc; close all;

% Generate a sine wave signal
Fs = 1000; % Sampling frequency
t = 0:1/Fs:1; % Time vector
f = 10; % Signal frequency
x = sin(2*pi*f*t); % Signal

% Add noise with SNR=5dB
SNR = input('Enter the desired SNR value: ');
noisy_signal = add_noise(x, SNR);

% Plot the original signal and the noisy signal
figure(1)
subplot(2,1,1);
plot(t,x);
title('Original signal');
grid on;
grid minor;

subplot(2,1,2);
plot(t,noisy_signal);
title(['Noisy signal with SNR =' num2str(SNR) 'dB']);
grid on;
grid minor;