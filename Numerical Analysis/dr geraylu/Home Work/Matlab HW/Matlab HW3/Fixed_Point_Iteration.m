clear;clc;close all;
f = input('Enter The Function as a Variable of x (f(x)): ');
g = input('Enter The Function as a Variable of x (g(x)): ');
% f=@(x) 3*x-2*exp(-x);                for debugging
% g=@(x) 2/3*exp(-x);                  for debugging
es = input('Enter The Stoping Error: ');
xi = input('Enter The First Point: ');
disp('-------------------------------------');
i = 0;
fprintf('Iteration    xi        f(x)       ea \n');
fprintf('%5d %12.5f \n', [i xi])
ea = abs((g(xi)-xi)/g(xi));
i = i+1;
fprintf('%5d %12.5f %10.5f %11.5f \n', [i g(xi) f(xi) ea]');
xi = g(xi);
while ea > es
    ea = abs((g(xi)-xi)/g(xi));
    i = i+1;
    fprintf('%5d %12.5f %10.5f %11.5f \n', [i g(xi) f(xi) ea]');
    xi = g(xi);
end
