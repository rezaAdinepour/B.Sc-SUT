clear; clc; close all;

score = 4;
HW = 10;
step = score / HW;

student_scores = [15 15 15 15 15 15 15 15 15 15;   % ebrahimi
                  18 0 0 0 0 0 0 0 0 20;           % jalali
                  19 20 15 15 15 15 20 20 20 20;   % poodineh
                  18 20 0 15 15 0 15 15 15 15;     % hatami
                  15 15 15 15 15 15 20 20 15 15;   % hojati
                  18 20 15 15 15 15 15 15 15 15;   % hozouri
                  0 0 0 0 0 0 0 0 0 0              % kheyrabadi
                  20 20 0 0 0 0 0 0 0 0;           % dadpour
                  0 20 20 20 15 15 0 20 20 15;     % saremi
                  15 15 15 15 15 15 20 20 20 20;   % safari
                  20 20 20 20 20 20 15 20 20 20;   % abbasabadi
                  20 20 20 20 0 0 0 0 15 0;        % feyzmokhtari
                  15 15 15 15 15 15 15 15 15 15;   % ghasemi
                  18 20 20 20 20 20 0 20 0 20;     % ghanbari
                  20 20 20 20 20 20 20 20 20 20;   % malmir
                  15 0 0 0 0 20 15 0 0 0;          % mohammadi
                  20 20 20 20 20 20 20 0 0 20;     % madani
                  0 20 15 15 15 15 15 15 15 15;    % meshkini
                  20 20 20 0 0 0 0 0 0 0;          % vaziri
                  0 0 0 0 0 0 0 0 0 0;             % valian
                  20 15 15 15 15 15 15 15 15 15];  % veise

st_size = size(student_scores);
final_score = zeros(1, st_size(1));
sclae_score = zeros(st_size(1), st_size(2));


for i=1:st_size(1)
    for j=1:st_size(2)
        sclae_score(i, j) = student_scores(i, j) .* step;
        sclae_score(i, j) = sclae_score(i, j) ./ 20;
    end
end

for i=1:st_size(1)
    final_score(i) = sum(sclae_score(i, :));
end

disp('final scores: ');
final_score'