clear;clc;close all;

fprintf('\t\t\t\t\t\t\t\t\tHello! Welcome to this program.\n\n\nSelect one of the option from menu:\n\n');
fprintf('1)Integral calculation With composite-Trapezoidal Rule.\n');
fprintf('2)Integral calculation With Simpson Rule.\n');
fprintf('3)Integral calculation With composite Mid-point.\n');
menu = input('=====> ');

if (menu == 1)
    f = input('Enter the function you want to derived, as a viriable of x (f(x)): ');
    %     f = @(x) 1./(1+x.^3); //
    a = input('Enter lower limit of integral: ');
    b = input('Enter upper limit of integral: ');
    N = input('Enter the  number of sub-intervals (N): ');
    h = (b-a)/N;
    disp('----------------------------------');
    eps_step = 1e-5;
    ctrap = 0.5*(f(a) + f(b))*h;
    for i=1:N
        h = h/2;
        ctrapn = 0.5*(f(a) + 2*sum( f((a + h):h:(b - h)))+ f(b))*h;
        if abs( ctrap - ctrapn ) < eps_step 
            fprintf("I = %.5f \n", ctrapn);
            break;
        elseif i == N
            error( 'The composite trapezoidal rule did not converge' );
        end
            ctrap = ctrapn;
    end
    
elseif (menu == 2)
    f = input('Enter the function you want to derived, as a viriable of x (f(x)): ');
    a = input('Enter lower limit of integral: ');
    b = input('Enter upper limit of integral: ');
    N = input('Enter the  number of sub-intervals (N): ');
    h = (b-a)/N; 
    xi=a:h:b;
    I = h/3*(f(xi(1))+2*sum(f(xi(3:2:end-2)))+4*sum(f(xi(2:2:end)))+f(xi(end)));
    fprintf("I = %.5f \n", I);
    
elseif (menu == 3)
    f = input('Enter the function you want to derived, as a viriable of x (f(x)): ');
    a = input('Enter lower limit of integral: ');
    b = input('Enter upper limit of integral: ');
    N = input('Enter the  number of sub-intervals (N): ');
    h = (b-a)/N; 
    result = 0;
    for i = 0:(N-1)
        result = result + f((a + h/2) + i*h);
    end
    I = h*result;
    fprintf("I = %.5f \n", I);
end    