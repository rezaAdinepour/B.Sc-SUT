clc;
clear;
close all;

%%
n=0:20;
figure(1)
x=step(0,0,20)-step(10,0,20);
title('x(n)')
xlabel('n')

h=((0.9).^n).*step(0,0,20);
figure(2)
stem(n,h,'r','linewidth',1.8)
title('h(n)')
xlabel('n')
grid on


y=Conv(x,h);
figure(3)
stem(y,'k','linewidth',1.8)
title('y(n)=x(n)*h(n)')
grid on
xlabel('n')