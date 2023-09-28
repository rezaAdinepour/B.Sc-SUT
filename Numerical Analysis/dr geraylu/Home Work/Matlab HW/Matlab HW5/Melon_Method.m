clear;clc;close all;

f = input('Enter equation to be solved in terms of x,y (@(x,y)=... ): ');
a = input('Enter low limit period: ');
b = input('Enter high limit period: ');
h = input('Enter the step size (h): ');
y(1) = input('Enter the intial value for y ( y(0) ): ');
x = a:h:b;
disp('--------------------------------------');
fprintf('k      x_k        y_k \n');
for i = 1:length(x)-1
    k1 = h * f(x(i), y(i));
    k2 = h * f(x(i) + 0.5*h, y(i) + 0.5*k1);
    k3 = h * f(x(i) + 0.5*h, y(i) + 0.5*k2);
    k4 = h * f(x(i) + h, y(i) + k3);
    y(i+1) = y(i) + 1/6 *(k1 + 2*k2 + 2*k3 +k4);
end
fprintf('%d)    %2.3f     %f \n', 0, x(1), y(1));
fprintf('%d)    %2.3f     %f \n', 1, x(2), y(2));
fprintf('%d)    %2.3f     %f \n', 2, x(3), y(3));
fprintf('%d)    %2.3f     %f \n', 3, x(4), y(4));
for i = 4:length(x)-1
   y(i+1) = y(i-3) + (4/3)*h*( 2*f(x(i), y(i)) - f(x(i-1), y(i-1)) + 2*f(x(i-2), y(i-2)) );
   fprintf('%d)    %2.3f     %f \n', i, x(i+1), y(i+1));
end