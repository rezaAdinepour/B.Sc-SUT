function result = transistor()

clc
clear
disp('Please Enter Ic (Current of collector) mA: ');
Ic = input('');
V_A = 100;
Beta = 100;
gm = 40*Ic
r_pi = Beta / gm 
r_o = V_A / Ic


end