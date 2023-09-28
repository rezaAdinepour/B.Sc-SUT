clear;clc;close all;
syms x
xFunction = input('Enter X-Point of your Function: ');
yFunction = input('Enter Y-Point of your Function: ');
xInter = input('Enter a number, or vector of points you want to interpolation: ');
interpolateFunction = lagrangeIntr(xInter, xFunction, yFunction)
yFunctionSize = size(yFunction, 2);
interpolateSize = size(interpolateFunction, 2);
for i=0:yFunctionSize-1
    yEx(i+1) =(x.^(yFunctionSize-(i+1))).*(yFunction(i+1));
end
for i=0:interpolateSize-1
    yIntr(i+1) =(x.^(interpolateSize-(i+1))).*(interpolateFunction(i+1));
end
fplot(sum(yEx), [-10 10]);
hold on
fplot(sum(yIntr), [-10 10]);
legend('Exact Value', 'Interpolated Value')
grid on;grid minor;