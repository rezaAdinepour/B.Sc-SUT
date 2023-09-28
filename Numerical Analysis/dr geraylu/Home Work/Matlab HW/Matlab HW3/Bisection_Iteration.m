clear;clc;close all;
f=input('Enter Function in terms of x: ');
% f = @(x) exp(x)*sin(x)+25*x+1;
tol = input('Enter ERROR: ');
low = input('Enter Initial Guess a(low): ');
high = input('Enter Initial Guess b(high): ');
bisectionfunc(f, low, high, tol);