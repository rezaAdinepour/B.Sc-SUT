%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 04                              ***
%        ****   Topic          : Generate Noise Function         ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************

function noisy_signal = add_noise(signal, SNR)
    % Adds noise with a given SNR to a signal
    % signal: input signal
    % SNR: signal-to-noise ratio in dB
    
    % Calculate signal power
    signal_power = norm(signal)^2 / length(signal);
    
    % Calculate noise power from SNR
    noise_power = signal_power / (10^(SNR/10));
    
    % Generate noise with the same length as the signal
    noise = sqrt(noise_power) * randn(size(signal));
    
    % Add noise to the signal
    noisy_signal = signal + noise;
end