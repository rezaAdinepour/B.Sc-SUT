clear;clc;close all;

%================= Half Wave Rectifier With Capacitor Filter =================

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

R = input('enter R in ohme: ');
C = input('enter C in F: ');

wRC = win * R * C;
wRCDEG = wRC * 180 / pi;
teta = -atan(wRC) + pi;
tetaDeg = teta * 180 / pi;


alphaVector = fsolve(@(alpha) sin(alpha) - sin(teta)*exp(-((2*pi + alpha - teta)/wRC)), 0:5);
alphaRad = alphaVector(1);
alphaDeg = alphaVector(1) * 180/pi;