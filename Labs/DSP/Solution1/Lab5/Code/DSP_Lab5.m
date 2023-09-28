%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 05                              ***
%        ****   Topic          : Determine frequency of signal   ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************

clear; clc; close all;

% Generate a sinusoidal signal in 0 to 1 sec with:
% signal frequency = 1 kHz
% sampling frequency = 16 kHz

f = 1e3;
fs = 16e3;
T = 10;

% Generate a sinusoidal signal
[y t] = mySin(f, fs, T);

% Compute Fourier transform of the signal
y_fourier = fft(y);
N = length(y);
X_mag = abs(y_fourier(1:N/2+1)); % Magnitude of positive frequency components
frequencies = linspace(0, fs/2, N/2+1); % Frequencies corresponding to positive frequency components

% Plot magnitude of Fourier transform versus frequency
figure(1);
subplot(3, 1, 1);
plot(t, y);
title(['input signal with f = ', num2str(f), 'Hz']);
xlim([0, 0.005]);

subplot(3, 1, 2);
plot(t, abs(fftshift(y_fourier)));
title('fourier transform of input signal');

subplot(3, 1, 3)
plot(frequencies, X_mag);
title('frequency spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');