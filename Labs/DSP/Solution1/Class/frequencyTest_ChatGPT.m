% Generate a test signal with an unknown frequency
fs = 1000; % Sampling frequency
t = 0:1/fs:1; % Time vector
f_unknown = 50; % Unknown frequency
x = sin(2*pi*f_unknown*t) + 0.5*randn(size(t)); % Test signal with noise

% Apply a Hamming window to the signal
win = hamming(length(x));
xw = x.*win;

% Compute the periodogram of the windowed signal using FFT
N = length(xw);
Pxx = abs(fft(xw)).^2/N;

% Compute the frequency vector
f = (0:N-1)*(fs/N);

% Find the frequency component with the highest power
[~,idx] = max(Pxx);
f_est = f(idx);

% Display the true and estimated frequencies
disp(['True frequency: ' num2str(f_unknown) ' Hz']);
disp(['Estimated frequency: ' num2str(f_est) ' Hz']);

% Plot the periodogram
figure;
plot(f,Pxx);
xlabel('Frequency (Hz)');
ylabel('Power');
title('Periodogram');