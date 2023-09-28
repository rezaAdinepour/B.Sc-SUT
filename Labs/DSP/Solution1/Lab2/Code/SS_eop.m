%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 02                              ***
%        ****   Topic          : Generate Function               ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************
function [ye, yo] = SS_eop(x)
    % This function takes a discrete signal x and returns its even and odd parts. 
    % The output is two vectors, even and odd.

    ye = 0.5 * (x + fliplr(x));
    yo = 0.5 * (x - fliplr(x));
end
