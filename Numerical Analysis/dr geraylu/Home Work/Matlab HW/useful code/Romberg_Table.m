clear;clc;close all;
 f = input('Enter The Function as a Variable of x (f(x)): ');
 a = input('Enter lower limit, a:  ');
 b = input('Enter upper limit, b:  ');
 n = input('Enter no. of subintervals, n:  ');
  
 h = b-a;
 r = zeros(2,n+1);
 r(1,1) = (f(a)+f(b))/2*h;
 fprintf('\nRomberg integration table:\n');
 fprintf('\n %11.8f\n\n', r(1,1));

 for i = 2:n
    sum = 0;
    for k = 1:2^(i-2)
       sum = sum+f(a+(k-0.5)*h);
    end
    r(2,1) = (r(1,1)+h*sum)/2;
   
    for j = 2:i
       l = 2^(2*(j-1));
       r(2,j) = r(2,j-1)+(r(2,j-1)-r(1,j-1))/(l-1);
    end

    for k = 1:i
       fprintf(' %11.8f',r(2,k));
    end
  
    fprintf('\n\n');
    h = h/2;
    for j = 1:i
       r(1,j) = r(2,j);
    end
 end 