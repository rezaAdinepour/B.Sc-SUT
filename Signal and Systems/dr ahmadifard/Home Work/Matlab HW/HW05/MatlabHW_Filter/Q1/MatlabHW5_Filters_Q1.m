clear;clc;close all;
[x fs]=audioread('Audio1.wav');
figure(1);subplot(3,2,1);plot(x);title('Real Time Signal');
N=length(x);
XFFT=fft(x,N);
for i=1:N
   w(i)=(i-1)*pi*2/N; 
end
subplot(3,2,2);plot(w,abs(XFFT));title('Frequency Range in one Periode');
set(gca,'XTick',0:pi/2:2*pi);
set(gca,'XTickLabel',{'0','pi/2','pi','3*pi/2','2*pi'});
axes('position',[0.7, 0.77, 0.1, 0.1]);box on
indexOfInterest = (w > 0.1) & (w < 0.3);
plot(w(indexOfInterest),abs(XFFT(indexOfInterest)));title('Frequency Range of Noise Signal');
axis tight;
WcF=2.8;
WcB=0.3;
for t=1:500
    h_f(t)=sin(WcF*(t-250))/(pi*(t-250));
    h2(t)=(-1)^abs(t-250)*h_f(t);
    h_b(t)=sin(WcB*(t-250))/(pi*(t-250));
    h_f(250)=WcF/pi;h2(250)=WcF/pi;h_b(250)=WcB/pi;
end
% figure;stem(h2)
% figure;stem(h_b)
HF=fft(h2',N);
HB=fft(h_b',N);
subplot(3,2,3);plot(w,abs(XFFT));title('Band Pass Filter');
set(gca,'XTick',0:pi/2:2*pi);
set(gca,'XTickLabel',{'0','pi/2','pi','3*pi/2','2*pi'});
hold on; plot(w,100*abs(HF), 'r');
subplot(3,2,5);plot(w,abs(XFFT));
hold on; plot(w,100*abs(HB), 'r');title('Band Stop Filter');
set(gca,'XTick',0:pi/2:2*pi);
set(gca,'XTickLabel',{'0','pi/2','pi','3*pi/2','2*pi'});
% YF=abs(HF.*XFFT);figur;plot(YF);
% YB=abs(HB.*XFFT);figur;plot(YB);
yf=real(ifft(HF.*XFFT,size(x,1)));
yb=real(ifft(HB.*XFFT,size(x,1)));
subplot(3,2,4);plot(yf);title('Synthesized Noise Signal With BPF');
subplot(3,2,6);plot(yb);title('Synthesized Noise Signal BSF');
audiowrite('onlyNoise.wav',yf,fs);
audiowrite('withOutNoise.wav',2*yb,fs);