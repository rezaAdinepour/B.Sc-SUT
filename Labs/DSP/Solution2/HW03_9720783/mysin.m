%% Part A
function [y,t]=mysin(f,fs,l)
    %f=Signal Freq.
    %fs=Sampling Freq.
    %l=Signal length
    ts=1/fs;
    t=0:ts:l;
    y=sin(2*pi*f*t);
end
