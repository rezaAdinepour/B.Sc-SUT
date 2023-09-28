

function [y,t]=mysin(f,fs,L)
    %f=Signal Freq.
    %fs=Sampling Freq.
    %l=Signal length
    ts=1/fs;
    t=0:ts:(L-ts);
    y=sin(2*pi*f*t);
end
