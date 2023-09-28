clear;clc;close all;

vin = input('enter Vin(Sinusoidal source) in volt: ');
vCheack = input('is this peack or rms? ');
if(lower(vCheack) == 'r' || lower(vCheack) == "rms")
    vinRms = vin;
    vinPeak = vinRms*sqrt(2);
elseif(lower(vCheack) == 'p' || lower(vCheack) == "peak")
    vinPeak = vin;
    vinRms = vinPeak/sqrt(2);
end
vdc = input('enter V-dc source in volt: ');
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
L = input('enter L in mH: ');
wl = win * L * 1e-3;
Z = sqrt((R^2) + wl^2);
teta = atan(wl/R);
alfa = asin(vdc/vinPeak);
taw = L / R;
wtaw = win * taw;