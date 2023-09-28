clear; clc; close all;

theory_score = 1.5;
sim_scores = 0.5;

theory_HW = 8;
sim_HW = 5;

theory_step = theory_score / theory_HW;
sim_step = sim_scores / sim_HW;

theory_scores = [  20 20 20 20 20 20 20 20;      % ehghaghi
                   19 0 20 19 20 20 20 0;        % esmaeilabadi
                   19 19 17 17 20 20 20 0;       % eghbali
                   19 15 0 20 20 0 0 0;          % pirali
                   19 0 20 20 20 20 20 0;        % tavakoli
                   0 0 0 0 0 0 0 0;              % hajmohammadi
                   20 20 20 20 20 20 20 0;       % hasani
                   18 0 19 19 0 0 0 0;           % hoseini
                   19 19 17 17 20 20 20 0;       % khajeh
                   0 0 0 0 0 0 0 0;              % rezaei firouzjah
                   0 0 0 0 0 0 0 0;              % rezaei nazanin
                   20 19 20 20 20 20 20 0;      % zamani
                   19 19 17 17 20 20 20 0;       % sheikhjafari
                   18 19 0 20 20 20 20 20;       % sedaghat pour
                   20 19 20 20 20 20 20 20;      % zeighami
                   18 19 18 17 20 0 20 20;       % ajam
                   20 20 20 20 20 20 20 20;      % gholamzadeh
                   20 20 19 20 20 20 20 20;      % fattahi
                   20 20 20 20 20 20 20 20;      % ghorbani
                   20 20 20 19 20 20 20 20;      % gheshlaghi
                   18 19 0 17 0 0 0 0;           % keshavarz parsa
                   20 19 20 20 20 20 20 0;       % koohestani
                   20 20 20 0 20 20 20 20;       % mokhtari
                   0 19 0 0 17 0 20 0;           % mazaher kermani
                   19 20 20 20 20 20 20 0;       % mousavi
                   0 0 18 18 20 20 20 20;        % naserian
                   20 0 20 19 20 20 20 20;       % nodeh
                   0 0 0 0 0 0 0 0;              % noei
                   20 20 20 20 20 20 20 20;      % vafaei
                  ]; 

sim_scores = [ 20 20 20 0 20;     % ehghaghi
               0 0 0 0 0;         % esmaeilabadi
               0 0 0 0 0;         % eghbali
               20 20 0 0 0;       % pirali
               15 0 20 0 0;       % tavakoli
               0 20 0 0 0;        % hajmohammadi
               0 0 0 0 0;         % hasani
               0 0 0 0 0;         % hoseini
               0 0 0 0 0;         % khajeh
               0 0 0 0 0;         % rezaei firouzjah
               0 0 0 0 0;         % rezaeian nazanin
               0 0 0 0 0;         % zamani
               20 0 0 0 0;        % sheikhjafari
               0 0 0 0 0;         % sedaghat pour
               20 20 20 20 20;    % zeighami
               0 0 0 0 0;         % ajam
               20 20 20 0 20;     % gholamzadeh
               20 20 0 20 20;     % fattahi
               0 0 0 0 20;        % ghorbani
               20 20 20 20 20;    % gheshlaghi
               0 0 0 0 0;         % keshavarz parsa
               0 0 20 0 0;        % koohestani
               20 20 20 0 0;      % mokhtari
               0 0 0 0 0;         % mazaher kermani
               20 20 20 0 0;      % mousavi
               0 0 0 0 20;        % naserian
               0 0 0 0 0;         % nodeh
               0 0 0 0 0;         % noei
               20 20 20 0 20;     % vafaei    
             ];

% theory
st_size = size(theory_scores);
final_theory_score = zeros(1, st_size(1));
sclae_score = zeros(st_size(1), st_size(2));

% simulation
st_size_sim = size(sim_scores);
final_score_sim = zeros(1, st_size_sim(1));
sclae_score_sim = zeros(st_size(1), st_size_sim(2));

% theory
for i=1:st_size(1)
    for j=1:st_size(2)
        sclae_score(i, j) = theory_scores(i, j) .* theory_step;
        sclae_score(i, j) = sclae_score(i, j) ./ 20;
    end
end

for i=1:st_size(1)
    final_theory_score(i) = sum(sclae_score(i, :));
end


% simulation
for i=1:st_size_sim(1)
    for j=1:st_size_sim(2)
        sclae_score_sim(i, j) = sim_scores(i, j) .* sim_step;
        sclae_score_sim(i, j) = sclae_score_sim(i, j) ./ 20;
    end
end

for i=1:st_size_sim(1)
    final_score_sim(i) = sum(sclae_score_sim(i, :));
end


disp('final theory scores: ');
final_theory_score'

disp('---------------------');

disp('final simulation scores: ');
final_score_sim'

disp('---------------------');

disp('final total scores: ');
(final_score_sim + final_theory_score + 0.02)'