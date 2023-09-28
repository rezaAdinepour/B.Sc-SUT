% input data (line and bus)
% bus types: type-1=slack, type-2=PV, type-3=PQ

function [linedata,busdata,tolerence,npv,nlb,lpv] = data()
    %         |  From |  To   |   R     |   X     |   Y/2     |  Capacity   |
    %         |  Bus  | Bus   |         |         |           |             |
    linedata = [ 1      2        0.10      0.170     0.0        2.0;
                 1      4        0.15      0.258     0.0        1.0;
                 2      4        0.12      0.197     0.0        2.0;
                 5      6        0.08      0.140     0.0        1.0;
                 3      6        0.01      0.018     0.0        1.0;
                 2      3        0.02      0.037     0.0        2.0;
                 4      5        0.02      0.37      0.0        2.0;];


    %         |Bus | Type | Vsp | theta |  PGi   |  QGi   |  PLi   |   QLi  | Qmin | Qmax | B_shunt  |
    busdata = [ 1     1    1.00     0      0.0      0.0      0.6      0.25    -2.0    2.0    0.0;
                2     2    1.05     0      1.4      0.0      0.5      0.20    -1.0    1.4    0.0;
                3     3    1.00     0      0.0      0.0      0.4      0.15     0.0    0.0    0.0;
                4     3    1.00     0      0.0      0.0      0.4      0.15     0.0    0.0    0.0;
                5     3    1.00     0      0.0      0.0      0.5      0.20     0.0    0.0    0.0;
                6     3    1.00     0      0.2      0.1      0.5      0.20    -0.1    0.2    0.0;];

    nlb=4; % number of LOAD-buses   
    npv=1; % number of PV-buses       
    lpv=2; % lowest value of PV-bus number

    tolerence=0.0001; % Defining the value of accepted tolerence
end