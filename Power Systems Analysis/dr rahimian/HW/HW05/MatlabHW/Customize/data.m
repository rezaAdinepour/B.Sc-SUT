% A 6-bus system data

% bus type: 1:slack, 2:P-V(Voltage Controled) 3:P_Q(Load)

%       No  type PG  QG  QGmax  QGmin  PD  QD     V
bus_data=[1  1  0.0  0.0  2.0  -2.0   0.6  0.25  1.0
          2  2  1.4  0.0  1.4  -1.0   0.5  0.2  1.05
          3  3  0.0  0.0  0.0   0.0   0.4  0.15  1.0];
      
      
      
      
%       NO  From To  R+jX   Capacity  Bc(ادمیتانس خازنی موازی)
line_data=[1  1  2  0.1+0.17j   2   0
           2  1  4  0.15+0.258j  1   0
           3  2  4  0.12+0.197j  2   0
           4  5  6  0.08+0.14j  1   0
           5  3  6  0.01+0.18j  1   0
           6  2  3  0.02+0.037j  2   0
           7  4  5  0.02+0.037j  2   0];
    