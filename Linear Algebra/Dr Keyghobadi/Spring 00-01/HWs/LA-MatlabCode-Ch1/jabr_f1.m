close all
clear all
clc
%% chapter 1
%%
% a=[1 2 3;10 0 -1;8 14 6]
% b=[14;10;-8] % b=[14 10 -8]'
% c=a*b
% v=[1 2 3;4 5 6]
% w=[0 2 4;-1 -5 7]
% q=v.*w
%% inner product
% v=[1 2 3];
% w=[0 2 4];
% sum(v.*w)
% 
% a=[3 4-2*i 1];
% b=[0 -3*i 4];
% sum(conj(a).*b)

%% norm
% a=[3 4-2*i 1]
% 
% norm(a,1)
% norm(a,2)
% norm(a,inf)
%% function innner product
syms x
f=sin(x)-cos(x)
g=sin(x)+cos(x)
y=f*g;
int(y,0,pi/2)

%% norm of function
%syms t

%f=t-0.5;
%int(abs(f),0,1)
%sqrt(int(f^2,0,1))

% t=0:0.01:1;
% f=t-0.5;
% plot(t,abs(f))

%% integral and derivative of matrix
% syms x
% b=[sin(x) 1 0;x -2*x cos(x)];
% int(b)
% diff(b,x)

%% norm of matrix

% norm(a,1)
% norm(a,2)
% norm(a,inf)
% norm(a,'fro')