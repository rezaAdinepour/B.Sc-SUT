clear;clc;close;
syms x i f(x) derivative
f(x)=3*x^2+2*x+1;
for i=1:4
    derivative(i)=diff(f(x), i)
end