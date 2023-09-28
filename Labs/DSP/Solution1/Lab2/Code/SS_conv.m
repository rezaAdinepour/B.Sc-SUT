%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 02                              ***
%        ****   Topic          : Customize Function              ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************
function [y, n_y] = SS_conv(h,x, xll, xul, hll, hul)
    n_x = xll:xul;
    n_h = hll:hul;
    y = conv(h,x);
    n_y = n_x(1) + n_h(1):n_x(end) +n_h(end);
end