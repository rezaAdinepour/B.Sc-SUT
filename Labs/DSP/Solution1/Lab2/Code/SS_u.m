%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 02                              ***
%        ****   Topic          : Customize Function              ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************
function [y] = SS_u(n)

    y = 1.*(n >= 0); % return 1 for n >= 0 and 0 for others.

end

