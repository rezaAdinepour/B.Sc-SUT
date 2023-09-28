clear;clc;close;
syms x f(x) n derivative(i);
f(x) = input('Enter the polynomial you want[f(x)]: ')
% pretty('f(x) = 'f(x))
biasPoint = input('Enter X0 (The value of the function and derivatives are calculated at this point): ')
nearPoint = input('Enter X (The Taylor approximation is calculated at this point): ')
nDegree = input('Enter Degree of n: ')
if nDegree < 0
    disp('Was not declared! Please Enter Correct Degree.');
    return
end
% syms derivative(z)
% derivative(z) = zeros(nDegree, 1)
for i=1:nDegree
%     derivative(i) = diff(f(x), i);
    taylorOPX = sum(((nearPoint-biasPoint)^i).*diff(f(x), i)/factorial(i), i, 1, nDegree)
end
% taylorapx = symsum(((nearPoint-biasPoint)^n)/(factorial(n)).*derivative(1,n), n, 0, nDegree)

% taylorOPX = sum(f(biasPoint)+(nearPoint-biasPoint).*derivative(1)+(((nearPoint-biasPoint)^2)/factorial(2)).*derivative(2))


 
% taylorapx = symsum(((nearPoint-biasPoint)^n)/(factorial(n)).*diff(biasPoint, n), n, 0, nDegree)
% FFF = f(nearPoint)