clc;
clear;
close all;
%% Part B

[y1,t1]=mysin(1,1000,4);   %sig01
[y2,t2]=mysin(3,1000,4);   %sig02
[y3,t3]=mysin(9,1000,4);   %sig03
[y4,t4]=mysin(25,1000,4);  %sig04
[y5,t5]=mysin(55,1000,4);  %sig05

New_sig1=[y1,y2,y3,y4,y5]; 
figure(1)
plot(New_sig1);

%% Part C
[f1,t1]=mysin(2,1000,20);   %sig11
[f2,t2]=mysin(8,1000,20);   %sig12
[f3,t3]=mysin(19,1000,20);   %sig13
[f4,t4]=mysin(44,1000,20);  %sig14
[f5,t5]=mysin(60,1000,20);  %sig15

New_sig2=f1+f2+f3+f4+f5; 
figure(2)
plot(New_sig2);

%% Part D

figure(3)
plot(abs(fft(New_sig1)));
title('New-sig1')

figure(4)
plot(abs(fft(New_sig2)));
title('New-sig2')
