clear;clc;close all;
[x fs]=audioread('Audio2.wav');
N=length(x);
XFFT=fft(x, N);
for i=1:N
   w(i)=(i-1)*pi*2/N;
end
figure(1);subplot(3,2,1);plot(w,x, 'color', '#0072BD');title('Real Time Signal');
subplot(3,2,2);plot(w,abs(XFFT), 'color', '#0072BD');title('Frequency Range in one Periode');
set(gca,'XTick',0:pi/2:2*pi);
set(gca,'XTickLabel',{'0','pi/2','pi','3*pi/2','2*pi'});
NoiseSignal = x + 0.2.*randn(1,N)';
subplot(3,2,3);plot(w, NoiseSignal, 'color', '#0072BD');title('Real Time Noise Signal');
audiowrite('NoiseSignal.wav', NoiseSignal, fs);
NoiseFFT=fft(NoiseSignal, N);
subplot(3,2,4);plot(w, abs(NoiseFFT), 'color', '#0072BD');title('Noise Signal Frequency Spectrum');
set(gca,'XTick',0:pi/2:2*pi);
set(gca,'XTickLabel',{'0','pi/2','pi','3*pi/2','2*pi'});
Wc=1.01;
DW1=0.02;DW2=0.022;DW3=0.027;DW4=0.029;
W01=0.3;W02=0.5;W03=0.78;W04=0.98;
for t=1:500 
    h(t)=2*cos(W01*t)*(sin(DW1*t/2)/pi*t)+2*cos(W02*t)*(sin(DW2*t/2)/pi*t)+2*cos(W03*t)*(sin(DW3*t/2)/pi*t)+2*cos(W04*t)*(sin(DW4*t/2)/pi*t);
end
% figure;stem(abs(h));
H=fft(h',N);
% figure;plot(w,H)
subplot(3,2,5);plot(w,abs(NoiseFFT), 'color', '#0072BD');title('Band Pass Filter');
set(gca,'XTick',0:pi/2:2*pi);
set(gca,'XTickLabel',{'0','pi/2','pi','3*pi/2','2*pi'});
hold on;plot(w, 100*abs(H), 'r');
% Y=abs(NoiseFFT.*H);figure;plot(Y);
y=real(ifft(NoiseFFT.*H, size(x,1)));
subplot(3,2,6);plot(w, y, 'color', '#0072BD');title('Synthesized Noise Signal BPF')
audiowrite('withOutNoise.wav', y, fs);