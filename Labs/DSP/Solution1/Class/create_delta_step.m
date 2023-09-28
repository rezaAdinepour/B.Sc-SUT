clear;clc;close all;

y1 = ss_delta(-5, 5, 0);
y2 = ss_step(-5, 5, 2);

figure(1);
subplot(1, 2, 1)
stem(y1)
subplot(1, 2, 2)
stem(y2)