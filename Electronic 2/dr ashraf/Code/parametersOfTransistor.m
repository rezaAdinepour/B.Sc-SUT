clear;clc;close all;

Ic = input('Enter Ic(in mA): ');
beta = input('Enter beta: ');
VA = input('Enter Va(Early Voltage(in Volt)...Please Enter inf if this voltage is infinity): ');
VT = input('Enter VT(Termal Voltage(in mV)...Please Enter 0 if not given in the example): ');
if VT == 0
    gm = 40 * Ic;
else
    gm = (Ic / VT) * 1000;
end

if VA == 'inf'
    ro = INF;
else
    r_o = VA / Ic;
end
r_pi = beta / gm;
disp('-------------------------');
fprintf('gm = %f mMoho\n', gm);
fprintf('r_pi = %f kOhm\n', r_pi);
fprintf('r_o = %f kOhm\n', r_o);
