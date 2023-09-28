clear;clc;close all;

Fs = 16e3;
f = 1e3;

dt = 1/Fs;
sec = 1;
t = 0:dt:sec-dt;


x = sin(2*pi*f*t);
xf = fft(x, 16e3);

plot(t, abs(fftshift(xf)))

X = abs(fft(x));
[m idx] = max(X);
fHat = idx * Fs / length(x);

