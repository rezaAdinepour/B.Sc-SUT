clear;clc;close all;

%================= Controled Half Wave Rectifier With Resistive Load =================


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
alpha = input('enter alpha in radian(enter 0 if didnt in question): ');
if(alpha == 0)
    voAvg = input('enter Vo(avg) in volt: ');
    alpha = acos(voAvg*(2*pi/vinPeak)-1);
    alphaDeg = alpha * 180 / pi;
    vrms = (vinPeak/2)*sqrt(1-(alpha/pi)+(sin(2*alpha)/2*pi));
end