clear;clc;close all;


u = input('enter your vector: ');
L1 = norm(u, 1);
L2 = norm(u, 2);
Linf = norm(u, 'inf');
%Lfro = norm(u, "fro");


fprintf('norm1: %.3d \n', L1)
fprintf('norm2: %.3d \n', L2)
fprintf('norminf: %.3d \n', Linf)
