clear;clc;close all;                                                                 
f = input('Enter The Function as a Variable of x (f(x)): ');
% f = @(x) x^4-x-10          for debugging
df = input('Enter Derivative of This Function: ');
% f = @(x) 4*x^3-1           for debugging
err = input('Enter Tolerance: ');
x0 = input('Enter Intial Point: ');
n = input('Enter Number of Iteration: ');
disp('-----------------------------');
fprintf('x0 = %.10f \n', x0);
if df(x0)~=0
   for i=1:n
       x1 = x0 - f(x0)/df(x0);
       fprintf('x%d = %.10f \n', [i x1]);
       if abs(x1-x0) < err
           break
       end
       if df(x1)==0
          disp('Newton Raphson Method Failed') ;
       end
       x0=x1;
   end
else
    disp('Newton Raphson Method Failed');
end