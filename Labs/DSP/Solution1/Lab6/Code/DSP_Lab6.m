%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 06                              ***
%        ****   Topic          : Aaudio Processing               ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************

clear; clc; close all;
load('my_filter.mat');

%% read imput files
fprintf('1) Do you want to record sound?\n2) Audio recording is available?\n');
menu = input('Which one? ');
disp('-------------------');

switch(menu)
    case 1
        duration = input('enter duration in Second: ');
        input_voice_name = input('enter voice name: ');
        input_audio = record_audio(duration, [input_voice_name '.wav']);
        fprintf('[info] audio %s was successfully recorded and saved.\n', [input_voice_name '.wav']);
        
    case 2
        input_voice_name = input('enter voice name: '); % 'voice_without_noise.wav'
        [input_audio, sample_rate] = audioread(input_voice_name);
end

%% read smoke detector noise file
[sd_audio, sd_sample_rate] = audioread('smoke_detector_noise.mp3');
% get size of input audio and noise audio
input_audio_size = size(input_audio);
smoke_detector_noise_size = size(sd_audio);
% convert stereo audio to the mono channel audio
sd_audio = sd_audio(:, 1);
sd_audio = sd_audio(1:input_audio_size(1));
audiowrite('smoke_detector_noise.wav', sd_audio, 44100);

%% add noise to audio
SNR = input('Enter the desired SNR value: ');
noisy_audio = add_noise_2_audio(input_audio, SNR, 'smoke_detector_noise.wav');
audiowrite('noisy_signal.wav', noisy_audio, 44100);

%% filter audio
filtered_audio = filter(my_filter, noisy_audio);
audiowrite('filtered_audio.wav', filtered_audio, 44100);

%% determine fourier transform of the audios
input_audio_ft = fft(input_audio);
sd_audio_ft = fft(sd_audio);
noisy_signal_ft = fft(noisy_audio);
filtered_audio_ft = fft(filtered_audio);

N_input_audio = length(input_audio);
N_sd_audio = length(sd_audio);
N_noisy_signal = length(noisy_audio);
N_filtered_audio = length(filtered_audio);

% determine magnitude of positive frequency components
X_mag_input_audio = abs(input_audio_ft(1:N_input_audio/2+1)); 
X_mag_sd_audio = abs(sd_audio_ft(1:N_sd_audio/2+1)); 
X_mag_noisy_audio = abs(noisy_signal_ft(1:N_noisy_signal/2+1)); 
X_mag_filtered_audio = abs(filtered_audio_ft(1:N_filtered_audio/2+1)); 

% determine frequencies corresponding to positive frequency components
fs = 16e3;
frequencies_input_audio = linspace(0, fs/2, N_input_audio/2+1); 
frequencies_sd_audio = linspace(0, fs/2, N_sd_audio/2+1); 
frequencies_noisy_audio = linspace(0, fs/2, N_noisy_signal/2+1);
frequencies_filtered_audio = linspace(0, fs/2, N_filtered_audio/2+1); 

%% plot audios
figure(1);

subplot(4, 2, 1);
plot(input_audio);
title('input audio without noise');

subplot(4, 2, 2);
% plot(abs(fftshift(input_audio_ft)));
plot(frequencies_input_audio, X_mag_input_audio)
title('fourier transform of the input audio');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(4, 2, 3);
plot(sd_audio);
title(['smoke detector noise audio with SNR = ', num2str(SNR)]);

subplot(4, 2, 4);
% plot(abs(fftshift(sd_audio_ft)));
plot(frequencies_sd_audio, X_mag_sd_audio)
title('fourier transform of the smoke detector noise audio');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(4, 2, 5);
plot(noisy_audio);
title('noisy audio');

subplot(4, 2, 6);
%plot(abs(fftshift(noisy_signal_ft)));
plot(frequencies_noisy_audio, X_mag_noisy_audio);
title('fourier transform of the noisy audio');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(4, 2, 7);
plot(filtered_audio);
title('filtered audio')

subplot(4, 2, 8);
%plot(abs(fftshift(filtered_audio_ft)));
plot(frequencies_filtered_audio, X_mag_filtered_audio);
title('fourier transform of the filtered audio');
xlabel('Frequency (Hz)');
ylabel('Magnitude');