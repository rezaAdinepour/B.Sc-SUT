clear;clc;close all;

menu = input('Enter one of them:\n 1) 2.Step Adams Moulton (AM2)\n 2) 3.Step Adams Moulton (AM3)\n 3) 4.Step Adams Moulton (AM4)\n====> ');
f = input('Enter equation to be solved in terms of x,y (@(x,y)=... ): ');
a = input('Enter low limit period: ');
b = input('Enter high limit period: ');
h = input('Enter the step size (h): ');
y(1) = input('Enter the intial value for y ( y(0) ): ');
x = a:h:b;
disp('--------------------------------------');
fprintf('%d.Step Adams Moulton (AM%d):\n\nk      x_k        y_k\n', menu+1, menu+1);

if (menu == 1)
    for i=1:length(x)-1
        k1 = h * f(x(i), y(i));
        k2 = h * f(x(i) + h, y(i) + k1);
        y(i+1) = y(i) + 0.5*(k1 + k2);
    end
    fprintf('%d)    %2.3f     %f \n', 0, x(1), y(1));
    fprintf('%d)    %2.3f     %f \n', 1, x(2), y(2));
    for i=2:length(x)-1
        y(i+1) = y(i) + 0.5*h*( f(x(i), y(i)) + f(x(i+1), y(i+1)));
        fprintf('%d)    %2.3f     %f \n', i, x(i+1), y(i+1));
    end
end

if (menu == 2)
    for i=1:length(x)-1
        k1 = h * f(x(i), y(i));
        k2 = h * f(x(i) + h, y(i) + k1);
        y(i+1) = y(i) + 0.5*(k1 + k2);
    end
    fprintf('%d)    %2.3f     %f \n', 0, x(1), y(1));
    fprintf('%d)    %2.3f     %f \n', 1, x(2), y(2));
    for i=2:length(x)-1
        y(i+1) = y(i) + (1/12)*h*( 5*f(x(i+1), y(i+1)) + 8*f(x(i), y(i)) - f(x(i-1), y(i-1)));
        fprintf('%d)    %2.3f     %f \n', i, x(i+1), y(i+1));
    end
end

if (menu == 3)
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
    for i=3:length(x)-1
        y(i+1) = y(i) + (1/24)*h*( 9*f(x(i+1), y(i+1)) + 19*f(x(i), y(i)) - 5*f(x(i-1), y(i-1)) + f(x(i-2), y(i-2)));
        fprintf('%d)    %2.3f     %f \n', i, x(i+1), y(i+1));
    end
end
