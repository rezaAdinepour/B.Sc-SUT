clear;clc;close;

n = 0:200;
signal = cos(pi/50 * n);
noiseSignal = signal + 0.03*randn(1, length(n));

%% using dsp.movingaverage object for noise filtering.
movingAverageFilter1 = dsp.MovingAverage(1);        % n in moving average systems is equal 1.
movingAverageFilter3 = dsp.MovingAverage(3);        % n in moving average systems is equal 3.
movingAverageFilter5 = dsp.MovingAverage(5);        % n in moving average systems is equal 5.
movingAverageFilter7 = dsp.MovingAverage(7);        % n in moving average systems is equal 7.
smoothedSignal_1 = movingAverageFilter1(noiseSignal);
smoothedSignal_3 = movingAverageFilter3(noiseSignal);
smoothedSignal_5 = movingAverageFilter5(noiseSignal);
smoothedSignal_7 = movingAverageFilter7(noiseSignal);

%% Plot OutPut Signals
subplot(3,2,1);
plot(signal);
grid on;grid minor;
title('$x[n]=cos(n\pi/50)$','interpreter', 'latex');
legend('$clear signal$ ', 'interpreter', 'latex', 'location', 'southeast');
subplot(3,2,2);
plot(noiseSignal);
legend('$noise signal$ ', 'interpreter', 'latex', 'location', 'southeast');
title('$x[n]=cos(n\pi/50)+noise$','interpreter', 'latex');
grid on;grid minor;
subplot(3,2,3);
plot(noiseSignal);
hold on
plot(n, smoothedSignal_1, 'linewidth', 1.5);
legend('$noise signal$ ', '$movingAVG(1)$' , 'interpreter', 'latex', 'location', 'southeast');
title('$Smoothed Signal With (n=1)$','interpreter', 'latex');
grid on;grid minor;
subplot(3,2,4);
plot(noiseSignal);
hold on
plot(n, smoothedSignal_3, 'linewidth', 1.5);
legend('$noise signal$ ', '$movingAVG(2)$' , 'interpreter', 'latex', 'location', 'southeast');
title('$Smoothed Signal With (n=2)$','interpreter', 'latex');
grid on;grid minor;
subplot(3,2,5);
plot(noiseSignal);
hold on
plot(n, smoothedSignal_5, 'linewidth', 1.5);
legend('$noise signal$ ', '$movingAVG(3)$' , 'interpreter', 'latex', 'location', 'southeast');
title('$Smoothed Signal With (n=3)$','interpreter', 'latex');
grid on;grid minor;
subplot(3,2,6);
plot(noiseSignal);
hold on
plot(n, smoothedSignal_7, 'linewidth', 1.5);
legend('$noise signal$ ', '$movingAVG(4)$' , 'interpreter', 'latex', 'location', 'southeast');
title('$Smoothed Signal With (n=4)$','interpreter', 'latex');
grid on;grid minor;