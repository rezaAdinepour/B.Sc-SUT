%           ******************************************************
%          **   course         : Linear Algebra                  **
%         ***   HomeWork       : 01                              ***
%        ****   Topic          : Calculate Determinant           ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************

clear; clc; close all;

A = [1 2 3 -1;0 1 2 7;2 4 -3 2;3 0 15 3]
Adet = det(A);
fprintf('det(A) = %d \n', Adet)