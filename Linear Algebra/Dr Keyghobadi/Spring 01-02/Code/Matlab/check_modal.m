clear; clc; close all;

% HW01 - Check Modal Matrix
% Reza Adinepour
% Stu. ID: 9814303

A = [6 -2;-4 3];
B = [8 1;-2 1];
T = [1 1;0 2];

T_inv = inv(T);

disp('B=inv(T)*A*T');
B == T_inv * A * T

disp('A=T*B*inv(T)');
A == T * B * T_inv