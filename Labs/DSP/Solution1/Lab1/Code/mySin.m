%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 01                              ***
%        ****   Topic          : Generate Sin Function           ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************

function [y, t] = mySin(f, fs, len) %(freq. of signal, sampling freq, signal length)
    ts = 1/fs;
    t = 0:ts:len;
    y = sin(2*pi*f*t);
end