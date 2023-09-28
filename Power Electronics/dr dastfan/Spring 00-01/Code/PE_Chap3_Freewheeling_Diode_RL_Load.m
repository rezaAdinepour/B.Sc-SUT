clear;clc;close all;

%================= Half Wave Rectifier With Freewheeling Diode and RL Load =================

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

n = 5;
V=zeros(1, n);
I=zeros(1, n);
Z=zeros(1, n);

V0 = vinPeak/pi;
V1 = vinPeak/2;
for n=2:2:10
    V(n-1) = (2*vinPeak)/(((n^2)-1)*pi);
end
V = [V0 V1 V]

Z0 = R;
Z1 = abs(R +  j * win * L);
for n=2:2:10
    Z(n-1) = abs(R +  j * n * win * L);
end
Z = [Z0 Z1 Z]

I0 = V0/R;
I1 = V1/Z1;
for n=2:2:10
    I(n-1) = V(n-1)/Z(n-1);
end
I = [I0 I1 I]