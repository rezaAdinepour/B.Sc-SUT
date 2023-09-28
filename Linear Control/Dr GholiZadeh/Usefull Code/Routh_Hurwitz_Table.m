clear;clc;close all;



% Example input: 
% 1. P = s^4 + 10*s^3 + 35*s^2 + 50*s + 24 ;
%    R = myRouth( [1 10 35 50 24] )

syms k
R = myRouth( [1 k 30*k 200*k] )
