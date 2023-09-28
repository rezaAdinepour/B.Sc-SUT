clear;clc;close;
[s, fs] = audioread('inputAudio.wav');
% sound(s, fs)
delay = 0.1;                   % distance of device from source.
alpha = 0.8;                   % echo strength.
D = delay * fs;
y = zeros(size(s));
y(1:D) = s(1:D);
 for i = D+1:length(s)  
   y(i) = s(i) + alpha*s(i-D);
 end
sound(y, fs);
audiowrite('outputAudio.wav', y, fs);