clear;clc;close all;
x=0;
y=1;
h=0.1;
for i=1:10
    f=y-x*x+1;
    y=y+f*h+.5*(f-2*x)*h*h;
    x=x+h;
    ye=(x+1)^2-.5*exp(x);
    fprintf('x = %10.7f, y = %10.7f\n',x,y)
end
