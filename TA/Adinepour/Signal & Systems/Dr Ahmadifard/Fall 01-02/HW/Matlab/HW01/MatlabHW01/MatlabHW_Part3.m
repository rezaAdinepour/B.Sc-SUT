clear;clc;close all;

n = -30:30;

x = sin(pi * n / 15);
noise = 0.1 * randn(1, length(n))

x_n = x + noise;

x_n1 = movmean(x_n, 1);
x_n3 = movmean(x_n, 3);
x_n5 = movmean(x_n, 5);
x_n15 = movmean(x_n, 15);

subplot(3, 3, 1);
stem(n, x);
title('input signal (without noise)');

subplot(3, 3, 2);
stem(n, noise);
title('noise sample');

subplot(3, 3, 3);
stem(n, x_n);
title('input signal (with noise)');

subplot(3, 3, 4);
stem(n, x_n1);
title('filtered input signal with n=1');

subplot(3, 3, 5);
stem(n, x_n3);
title('filtered input signal with n=3');

subplot(3, 3, 6);
stem(n, x_n5);
title('filtered input signal with n=5');

subplot(3, 3, 7);
stem(n, x_n15);
title('filtered input signal with n=15');