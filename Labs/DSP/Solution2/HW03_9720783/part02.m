clc;
clear;
close all;

%% Part02

%Define X(t)
fs=1e3;
ts=1/fs;
t=0:ts:10;

if 0<t<2.5
    x=cos(2*pi*10*t);
end

if 2.5<t<5
    x=cos(2*pi*10*t);
end

if 5<t<7.5
    x=cos(2*pi*10*t);
end

if 7.5<t<10
    x=cos(2*pi*10*t);
end

L=256;                      %Length of windows
R=round((1-0.25)*L);        %Overlap=25%

k=0;                        %Number of windows

while (k*R<(length(x)-L))
    
    for j=1:L
        frame(k+1,j)=x((k*R)+j);
    end
    k=k+1;
end

for i=1:size(frame,1)
    F(i,:)=abs(fft(frame(i,:),2*L));
end

figure(4)
imagesc(log10(F(:,1:256)));

figure(5)
spectrogram(x);




