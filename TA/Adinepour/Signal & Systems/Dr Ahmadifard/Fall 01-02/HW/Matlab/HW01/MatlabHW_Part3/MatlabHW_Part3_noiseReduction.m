clear;clc;close;

[s, fs] = audioread('inputAudio.wav');
noiseSignal = s + 0.01*randn(1, length(s))';
audiowrite('noiseAudio.wav',noiseSignal, fs);
% player1 = audioplayer(noiseSignal,fs);
% play(player1);
movingAverageFilter = dsp.MovingAverage(200);
smoothedSignal = movingAverageFilter(noiseSignal);
% player = audioplayer(2*smoothedSignal,fs);
% play(player);
audiowrite('outputAudio.wav',smoothedSignal, fs);

figure(1);
subplot(3, 2, [1 2]);
plot(s);
title('input signal without noise');
subplot(3, 2, [3 4]);
plot(noiseSignal);
title('input signal with noise');
subplot(3, 2, [5 6]);
plot(smoothedSignal);
title('filtered signal with moving average');