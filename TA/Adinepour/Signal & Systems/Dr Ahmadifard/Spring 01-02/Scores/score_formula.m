clear; clc; close all;

score = 2;
HW = 9;
step = score / HW;

student_scores = [ 20 0 0 0 0 0 0 0 0;            % akbari
                   20 19 20 20 0 20 0 20 20;      % pira
                   20 20 20 20 20 20 20 20 20;    % jaberi
                   20 18 20 20 20 20 20 20 20;    % chandar
                   20 20 0 0 0 0 0 0 20;          % hajmohammadi
                   20 18 0 0 0 0 0 0 0;           % rezaie
                   20 18 20 20 15 20 15 20 20;    % soroush
                   0 0 0 0 0 0 0 0 0;             % saghazadeh
                   15 15 15 15 20 20 20 20 20;    % sahlabadi
                   0 0 0 0 0 0 0 0 0;             % shahbazi
                   20 20 20 20 0 20 0 0 20;       % sharifnia
                   0 0 0 0 0 0 0 0 0;             % shirafkan
                   20 18 20 20 20 0 0 15 0;       % arab
                   20 19 0 20 20 20 0 20 20;      % azizi
                   20 18 20 20 20 20 15 20 20;    % efati
                   20 20 20 20 20 20 0 20 20;     % faraghdani
                   20 20 20 20 15 20 15 20 20;    % goodarzi nia
                   20 20 20 20 20 20 20 20 20;    % mohammadhoseini
                   20 18 0 0 0 20 0 0 0;          % mslemi
                   20 20 20 20 20 20 20 20 20;    % mozafari
                   20 19 0 0 0 20 20 15 15;       % moghadasi
                   20 18 20 0 20 0 0 0 0;         % mehri
                   20 20 20 20 20 20 15 20 20;    % nadali
                   20 0 0 0 0 0 0 0 0;            % nafisi
                   20 19 20 20 15 20 0 20 20;     % hodhodi
                  ]; 

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