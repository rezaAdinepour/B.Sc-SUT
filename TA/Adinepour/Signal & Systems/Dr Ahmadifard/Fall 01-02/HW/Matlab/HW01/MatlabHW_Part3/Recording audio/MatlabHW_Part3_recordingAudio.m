clear;clc;close;
                                                % in first step recording our voise for synthesis.

arec = audiorecorder(44100, 16, 1);
record(arec);                                    % speak into microphone for 5 seconds.
pause(5)
stop(arec);
mySpeech = getaudiodata(arec, 'double');        % get data as double array
audiowrite('inputAudio.wav' ,mySpeech, 44100);