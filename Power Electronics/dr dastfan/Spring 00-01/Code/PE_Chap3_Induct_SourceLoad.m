clear;clc;close all;

%================= Half Wave Rectifier With Inductance Source Load =================

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

L = input('enter L in mH: ');
wl = win * L * 1e-3;
alfa = asin(vdc/vinPeak);
alphaDeg = alfa * 180 / pi;

I = @(x) (vinPeak/wl)*(cos(alfa)-cos(x))+(vdc/wl)*(alfa-x);
II = @(x) ((vinPeak/wl)*(cos(alfa)-cos(x))+(vdc/wl)*(alfa-x)).^2;
betaVector = fsolve(I, 0:5);
betaRad = betaVector(end);
betaDeg = betaVector(end) * 180/pi;

IO = (1/2*pi) * (integral(I, alfa, betaRad))/10;
Irms = sqrt((1/2*pi)*0.1*integral(II, 0, betaRad));