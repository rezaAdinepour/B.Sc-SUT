clear;clc;close all;

% c(k+2)-1.3c(k+1)+0.4c(k)=r(k) % c(0)=0 and c(1)=0.

delta = [1 zeros(1, 5)];
num = [0 0 1];
den = conv([1  -1.3  0.4],[1  -1]);
c=filter(num, den, delta)