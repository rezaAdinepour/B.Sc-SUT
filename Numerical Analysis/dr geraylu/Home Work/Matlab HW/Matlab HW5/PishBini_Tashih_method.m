clear;clc;close all;

f = input('Enter equation to be solved in terms of x,y (@(x,y)=... ): ');
a = input('Enter low limit period: ');
b = input('Enter high limit period: ');
h = input('Enter the step size (h): ');
x = a:h:b;
y = zeros(1,length(x));
y(1) = input('Enter the intial value for y ( y(0) ): ');
disp('--------------------------------------');
fprintf('PishBini method:\n\nk      x_k        y_k\n');
for i=1:length(x)
    y(i+1) = y(i) + h*f(x(i), y(i));
    fprintf('%d)    %2.3f     %f \n', i-1, x(i), y(i));
end
disp('--------------------------------------');
fprintf('Tashih method:\n\nk      x_k        y_k\n');
fprintf('%d)    %2.3f     %f \n', 0, x(1), y(1));
fprintf('%d)    %2.3f     %f \n', 1, x(2), y(2));
for i=2:length(x)-1
    y(i+1) = y(i) + 0.5*h*(f(x(i), y(i)) + f(x(i+1), y(i+1)));
    fprintf('%d)    %2.3f     %f \n', i, x(i+1), y(i+1)); 
end