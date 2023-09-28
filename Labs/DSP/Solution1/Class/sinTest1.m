clear;clc;close all;

[y t] = mySin(1e3, 16e3, 1);
plot(t, y);
xlim([0, 0.005])