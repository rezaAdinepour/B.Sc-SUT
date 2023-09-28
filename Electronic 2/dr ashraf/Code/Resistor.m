clear;clc;close all;

R1 = input('Enter R_up(K_Ohm): ');
R2 = input('Enter R_down(K_Ohm): ');
Vcc = input('Enter Vcc(Volt): ');
Rth = (R1*R2) / (R1+R2);
Vth = (R2*Vcc) / (R1+R2);
disp('-------------------------');
fprintf('Rth = %f Kohm\n', Rth);
fprintf('Vth = %f Volt\n', Vth);