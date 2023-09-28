%           ******************************************************
%          **   course         : DSP-Lab                         **
%         ***   HomeWork       : 06                              ***
%        ****   Topic          : Aaudio Processing               ****
%        ****   AUTHOR         : Reza Adinepour                  ****
%         ***   Student ID:    : 9814303                         ***
%          **   Github         : github.com/reza_adinepour/      **
%           ******************************************************

function audio_data = record_audio(duration, filename)

    % this function record audio from the built-in microphone for the specified duration in seconds and
    % saves the recorded audio data as a .wav file with the specified filename in the current folder.
  
    % create an audio recorder object
    recorder = audiorecorder(44100, 16, 1);
    
    % start the recording
    record(recorder);
    disp('[info] Recording in progress now ...')
    
    % wait for the recording to finish
    pause(duration);
    
    % stop the recording
    stop(recorder);
    disp('[info] end of Recording.')
    
    % get the recorded audio data as a column vector
    audio_data = getaudiodata(recorder);
    
    % save the audio data as a .wav file with the specified filename
    audiowrite(filename, audio_data, recorder.SampleRate);
end