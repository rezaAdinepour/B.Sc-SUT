%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 04                              ***
%        ****   Topic          : Moving Average Filter           ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************

function filtered_signal = moving_average_filter(input_signal, filter_length)
    % input_signal: vector of the input signal
    % filter_length: odd number for length of the moving average filter
    
    if (mod(filter_length, 2) == 0)
        warning('Filter length should be odd. Rounding up to nearest odd number.');
        filter_length = filter_length + 1;
    end
    
    % Pad input signal with zeros at the beginning and end to ensure that the
    % output signal is the same length as the input signal
    pad_length = floor(filter_length / 2);
    padded_signal = [zeros(pad_length, 1);
    input_signal;
    zeros(pad_length, 1)];
    
    % Initialize output signal
    filtered_signal = zeros(size(input_signal));
    
    % Calculate the moving average for each element in the input signal
    for i = 1:length(input_signal)
        filtered_signal(i) = mean(padded_signal(i:i + filter_length - 1));
    end
end