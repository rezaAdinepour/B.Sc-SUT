clear;clc;close all;

%================= Controled Half Wave Rectifier With R-L Load =================


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
alphaDeg = input('enter alpha in deg: ');
alpha = alphaDeg * pi / 180;

wl = win * L;
Z = sqrt((R^2) + wl^2);
teta = atan(wl/R);
tetaDeg = teta * 180 / pi;
taw = L / R;
wtaw = win * taw;
A = (-vinPeak/Z)*sin(alpha-teta);

I = @(x)  (vinPeak/Z) * (sin(x-teta)-sin(alpha-teta)*exp((alpha-x)/(wtaw)));
II = @(x) ((vinPeak/Z) * (sin(x-teta)-sin(alpha-teta)*exp((alpha-x)/(wtaw)))).^2;

betaVector = fsolve(I, 0:5);
betaRad = betaVector(end);
betaDeg = betaVector(end) * 180/pi;
gama = betaRad - alpha;
gamaDeg = gama * 180 / pi;

IO = (1/2*pi) * (integral(I, alpha, betaRad))/10;
Irms = sqrt((1/2*pi)*0.1*integral(II, alpha, betaRad));