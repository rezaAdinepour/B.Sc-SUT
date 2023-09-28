%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 06                              ***
%        ****   Topic          : Aaudio Processing               ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************

function noisy_signal = add_noise_2_audio(clean_signal, snr_db, noise_filename)
    % this function adds external noise to the input voice signal with the specified 
    % SNR in decibels, and returns the resulting noisy signal.
    
    % load the external noise data from the file
    [noise_data, noise_sample_rate] = audioread(noise_filename);
    
    % Resample the noise data to match the sample rate of the clean signal
    if (noise_sample_rate ~= 44100)
        noise_data = resample(noise_data, 44100, noise_sample_rate);
        noise_sample_rate = 44100;
    end
    
    % determine the power of the clean signal
    signal_power = rms(clean_signal)^2;
    
    % convert the SNR from dB to a linear scale
    snr_linear = 10^(snr_db/10);
    
    % determine the power of the noise to add
    noise_power = signal_power / snr_linear;
    
    % generate a random starting point for the noise data
    start_index = randi(length(noise_data) - length(clean_signal) + 1);
    
    % extract a segment of the noise data with the same length as the clean signal
    noise_segment = noise_data(start_index:start_index+length(clean_signal)-1);
    
    % scale the noise segment to the desired power level
    noise_segment = sqrt(noise_power) * noise_segment / rms(noise_segment);
    
    % add the noise to the clean signal to create the noisy signal
    noisy_signal = clean_signal + noise_segment;
end