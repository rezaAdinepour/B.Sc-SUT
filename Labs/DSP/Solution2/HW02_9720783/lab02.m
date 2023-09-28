clc;
clear;
close all;


L=1;
f=1000; 
fs=16000;
ts=1/fs;

t=0:ts:(L-ts);
sig1=sin(2*pi*f*t);
sig2=abs(fft(sig1));

figure(1) 
plot(t,sig1,'linewidth',1.3)
grid on


figure(2)
plot(sig2,'r','linewidth',2)
grid on

