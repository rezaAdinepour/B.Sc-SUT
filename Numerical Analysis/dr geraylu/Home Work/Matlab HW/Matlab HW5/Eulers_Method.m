clear;clc;close all;

menu = input('Enter one of them:\n 1) general eulers\n 2) beter than eulers\n ====> ');
f = input('Enter equation to be solved in terms of x,y (@(x,y)=... ): ');
a = input('Enter low limit period: ');
b = input('Enter high limit period: ');
h = input('Enter the step size (h): ');
y(1) = input('Enter the intial value for y ( y(0) ): ');
% N = (b - a) / h;
x = a:h:b;
disp('--------------------------------------');
if (menu == 1)
    fprintf('k      x_k        y_k\n');
    for i=1:length(x)
        y(i+1) = y(i) + h*f(x(i), y(i));
        fprintf('%d)    %2.3f     %f \n', i-1, x(i), y(i));
    end 
end
if (menu == 2)
   z(1) = y(1) + h*f(x(1), y(1));
    fprintf('k      x_k         z_k          y_k\n');
    fprintf('%d)    %2.3f      %f     %f \n', 0, x(1), z(1), y(1));
    for i=1:length(x)-1
        z(i+1) = y(i) + h*f(x(i), y(i));
        y(i+1) = y(i) + 0.5*h*( f(x(i), y(i)) + f(x(i+1), z(i+1)) );
        fprintf('%d)    %2.3f      %f     %f \n', i, x(i+1), z(i+1), y(i+1));
    end 
end

