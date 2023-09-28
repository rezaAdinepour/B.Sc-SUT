clc;
clear;
close all;

%% Create  Noise & Data Signal
[noise,fs1]=audioread('2-Smoke_Detector.mp3');  %noise --> Smoke_Detector
[sig,fs2]=audioread('1-MyMessage.mp3');         %signal --> Message Signal
%% Convert stereo to mono
sig=sig(:,1);                                  
noise=noise(:,1);                                                        
%% Equalize the dimensions of the matrices
sig(483001:length(sig),:)=[];
noise(483001:length(noise),:)=[];
%% Adding Noise to Signal
%Compute Sout = signal + noise such that SNR = Ps/Pn
%s: Input signal
%SNR: Desired signal-to-noise ratio
%d: Output signal
SNR=30;       %in dB
Es = sum(sig(:).^2);
En = sum(noise(:).^2);
alpha = sqrt(Es/(SNR*En));
Sout = sig+(alpha*noise);
audiowrite('3-Combined_signal(SNR=30).wav',Sout,fs2);        %Save Combined Signal

%% Frequency Analyze
figure
subplot(2,1,1)
a0=fft(sig);
b0=fftshift(a0);
plot(abs(b0),'b','linewidth',1.5);
title('Message Fourier transform')
xlabel('483000 symbol')

grid minor

subplot(2,1,2)
a1=fft(Sout);
b1=fftshift(a1);
plot(abs(b1),'r','linewidth',1.5);
title('Noise Fourier transform')
xlabel('48000symbol')
grid minor

%% Time Analyze
figure
subplot(3,1,1)
plot(sig,'b')
title('Message Signal')
grid minor
subplot(3,1,2)
plot(noise,'r')
title('Noise')
grid minor
subplot(3,1,3)
plot(Sout,'k')
title('Addative Signal')
grid minor

figure
plot(Sout,'r')
hold on
plot(sig,'b')
grid minor
legend('Addative Signal','Message Signal')

%% Design Filter
%copy to command window 
%A=filter(MyFilter,Sout); 
%audiowrite('4-Filtered_Signal.wav',A,fs);       
%sound('4-Filtered_Signal.wav',fs)











