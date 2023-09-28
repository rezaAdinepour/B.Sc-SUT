clc;
clear;
close all;
%% Create Signal
[f1,t1]=mysin(2,1000,20); 
[f2,t2]=mysin(8,1000,20); 
[f3,t3]=mysin(19,1000,20); 
[f4,t4]=mysin(44,1000,20); 
[f5,t5]=mysin(60,1000,20); 
MySignal=f1+f2+f3+f4+f5;
figure(1)
plot(MySignal);

%% STFT

L=256;                      %Length of windows
R=round((1-0.25)*L);        %Overlap=25%

k=0;                        %Number of windows

while (k*R<(length(MySignal)-L))
    
    for j=1:L
        frame(k+1,j)=MySignal((k*R)+j);
    end
    k=k+1;
end

for i=1:size(frame,1)
    F(i,:)=abs(fft(frame(i,:),2*L));
end

figure(2)
imagesc(log10(F(:,1:256)));

figure(3)
spectrogram(MySignal);



