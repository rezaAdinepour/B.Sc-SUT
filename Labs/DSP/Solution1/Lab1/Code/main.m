%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 01                              ***
%        ****   Topic          : Generate Sin Function           ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************

clc;clc;close all;
%% Part B
sinLength = 5;

[y1, t1] = mySin(1, 1e3, sinLength);   % signal 01
[y2, t2] = mySin(5, 1e3, sinLength);   % signal 02
[y3, t3] = mySin(10, 1e3, sinLength);   % signal 03
[y4, t4] = mySin(15, 1e3, sinLength);   % signal 04
[y5, t5] = mySin(20, 1e3, sinLength);   % signal 05

newSig1 = [y1, y2, y3, y4, y5]; 
figure(1);
plot(newSig1);
title('newSig1 = [y1, y2, y3, y4, y5]')
grid on; grid minor;

%% Part C
[f1, t1] = mySin(1, 1e3, 5*sinLength);   % signal 01
[f2, t2] = mySin(5, 1e3, 5*sinLength);   % signal 02
[f3, t3] = mySin(10, 1e3, 5*sinLength);  % signal 03
[f4, t4] = mySin(15, 1e3, 5*sinLength);  % signal 04
[f5, t5] = mySin(20, 1e3, 5*sinLength);  % signal 05

newSig2 = f1 + f2 + f3 + f4 + f5; 
figure(2);
plot(newSig2);
title('newSig2 = f1+f2+f3+f4+f5')
grid on; grid minor;

%% Part D
figure(3);
plot(abs(fftshift(fft(newSig1))));
title('newSig-1');
grid on; grid minor;

figure(4);
plot(abs(fftshift(fft(newSig2))));
title('newSig-2');
grid on; grid minor;