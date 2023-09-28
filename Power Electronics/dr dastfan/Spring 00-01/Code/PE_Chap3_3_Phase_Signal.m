clear;clc;close all;

Fs = 8000;
dt = 1/Fs;
StopTime = 0.02;
t = (0:dt:StopTime-dt)';
N = size(t,1);
Fc = 50;
phi = [ -2*pi/3 0 2*pi/3 ];
Vrms = 110;
x = Vrms*sqrt(2)*cos(2*pi*Fc*t*ones(1,3) + ones(N,1)*phi);
figure;
plot(t,x, 'LineWidth', 1);
grid on;
legend('eaN', 'ecN', 'ebN');