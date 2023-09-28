clear;clc;close all;
f = input('Enter The Function as a Variable of x (f(x)): ');
df = input('Enter Derivative of This Function: ');
p0 = input('Enter Intial Point: ');
delta = input('Enter convergence tolerance for p: ');
epsilon = input('Enter convergence tolerance for yp: ');
max1 = input('Enter maximum number of iterations: ');
aiitkenfunc(f,df,p0,delta,epsilon,max1)