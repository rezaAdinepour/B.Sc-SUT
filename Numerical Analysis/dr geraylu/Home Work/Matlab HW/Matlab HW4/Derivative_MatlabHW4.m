clear;clc;close all;

fprintf('\t\t\t\t\t\t\t\t\tHello! Welcome to this program.\n\n\nSelect one of the option from menu:\n\n');
fprintf('1)derivative calculation With richardson extrapolation.\n');
fprintf('2)derivative calculation With teylor series.\n');
menu = input('=====> ');
if (menu == 1)
    f = input('Enter the function you want to derived, as a viriable of x (f(x)): ');
    h = input('Enter The Step (h): ');
    x = input('Enter the point you want to derived (x): ');
    eps_step = 1e-5;
    disp('--------------------------------------------');
    R(1, 1) = (f(x + h) - f(x - h))/(2*h);
    for i=1:100
        h = h/2;
        R(i + 1, 1) = (f(x + h) - f(x - h))/(2*h);
        for j=1:i
            R(i + 1, j + 1) = (4^j*R(i + 1, j) - R(i, j))/(4^j - 1);
        end
        if (abs(R(i + 1, i + 1) - R(i, i)) < eps_step)
            fprintf("f'(%d)= %.4f \n", x, R(i,j));
            break;
        elseif (i == 100)
            error('Richardson extrapolation failed to converge');
        end
    end
elseif (menu == 2)
    f = input('Enter the function you want to derived, as a viriable of x (f(x)): ');
    h = input('Enter The Step (h): ');
    x = input('Enter the point you want to derived (x): ');
    F = (-f(x+2)+8*f(x+1)-8*f(x-1)+f(x-2))/(12*h);
    fprintf("f'(%d)= %.4f \n", x, F);  
end