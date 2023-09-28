%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 02                              ***
%        ****   Topic          : Customize Function              ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************
function [y] = SS_delta(n, width)

    % SS_delta returns unit impulse function
    % SS_delta(n) retutns the value 0 for n < 0 and n > 0, and 1 for n = 0;
    % SS_delta(n, width) returns the value 1/(2 * width) for -width < n < width, and 0 for other times.
    
    if (nargin == 1)
        y = (n == 0);
    else
        y = 1 * ((n >= -width) & (n <= width));
    end
end