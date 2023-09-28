%% dsp lab :: session 2

clear;clc;close all;

%% random number

% N = 10;
% n = randn(1, N);
% nMax = max(n);
% nMin = min(n);
% 
% a = n - nMin;
% b = a ./ (max(a) - min(a));
% 
% 
% disp('orginal vector: ')
% disp(n)
% disp('max element: ')
% disp(nMax)
% disp('min element: ')
% disp(nMin)
% disp('normalize vector between 0-1: ')
% disp(b)
% 
% figure(1);
% stem(n)
% title('original vector');
% 
% figure(2);
% stem(b)
% title('normalize vector between 0-1')

%% function

h = input('enter height: ');
w = input('enter weigth: ');
[a, p] = rectCalc(w, h);
fprintf('mohit: %d\n', p);
fprintf('masahat: %d\n', a)