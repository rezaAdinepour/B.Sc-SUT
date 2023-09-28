clear;clc;close all;

%================= Half Wave Rectifier With Resistive Inductive Load =================

vin = input('enter Vin(Sinusoidal source) in volt: ');
vCheack = input('is this peack or rms? ');
if(lower(vCheack) == 'r' || lower(vCheack) == "rms")
    vinRms = vin;
    vinPeak = vinRms*sqrt(2);
elseif(lower(vCheack) == 'p' || lower(vCheack) == "peak")
    vinPeak = vin;
    vinRms = vinPeak/sqrt(2);
end
freqin = input('enter frequency of input source: ');
freqCheack = input('is this hertz or radian? ');
if(lower(freqCheack) == 'h' || lower(freqCheack) == "hertz")
    fin = freqin;
    win = 2*pi*fin;
elseif(lower(freqCheack) == 'r' || lower(freqCheack) == "radian")
    win = freqin;
    fin = win/(2*pi);
end
R = input('enter R in ohm: ');
L = input('enter L in H: ');
wl = win * L;
Z = sqrt((R^2) + wl^2);
teta = atan(wl/R);
tetaDeg = teta * 180 / pi;
taw = L / R;
wtaw = win * taw;
I = @(x) (vinPeak/Z)*(sin(x-teta)+sin(teta)*exp(-x/wtaw));
II = @(x) ((vinPeak/Z)*(sin(x-teta)+sin(teta)*exp(-x/wtaw))).^2;
betaVector = fsolve(@(x) sin(x-teta)+sin(teta)*exp(-x/wtaw), 0:5);
betaRad = betaVector(end);
betaDeg = betaVector(end) * 180/pi;

IO = (1/2*pi) * (integral(I, 0, betaRad))/10;
Irms = sqrt((1/2*pi)*0.1*integral(II, 0, betaRad));