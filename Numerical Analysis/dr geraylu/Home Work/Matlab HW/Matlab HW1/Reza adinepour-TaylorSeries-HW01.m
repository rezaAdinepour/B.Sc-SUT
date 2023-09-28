clear;clc;
maxDeg = input('Enter The Maximum degree of the function: ');
if maxDeg <= 0 
    disp('Was not declared! Please Enter Correct Degree.');
    return
end
funCoeff = input('Enter Function coefficients: ');
if (size(funCoeff, 2) > maxDeg+1) || (size(funCoeff, 2) < maxDeg+1)
    disp('Was not declared! Please Enter the Correct Number of Coefficients.');
    return
end
biasPoint = input('Enter X0 (The value of the function and derivatives are calculated at this point): ');
nearPoint = input('Enter X (The Taylor approximation is calculated at this point): ');
nDegree = input('Enter Degree of n: ');
if nDegree < 0
    disp('Was not declared! Please Enter Correct Degree.');
    return
end
for i = 1:nDegree
   taylorApx(i) = sum(((nearPoint-biasPoint)^i).*polyder(funCoeff)/factorial(i));
end
disp('-------------------------------------')
fprintf('Taylor Approximation Value is: %f \n', taylorApx(2))
real = polyval(funCoeff, biasPoint);
fprintf('Exact Value is: %f \n', real)
fplot(taylorApx(2))
hold on
fplot(real)