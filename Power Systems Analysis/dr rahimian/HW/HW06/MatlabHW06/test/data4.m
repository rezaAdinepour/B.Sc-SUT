
%% Topology of the power system (Stevenson 4 bus test case)
% Information about the bus matrix
  % nd   V    Ang.    Pg      Qg      PL      QL        Gs       jBs    Type
  % (1) (2)   (3)     (4)     (5)     (6)     (7)       (8)      (9)    (10)
  % Colum 11: if the bus has shunt element =1, if it hasnt shunt element =0
bus=[1  1.06  0.000   0.00    0.00    0.50    0.3099    0.000    0.000  1  0.0;
     2  1.00  0.000   0.40    0.00    1.70    1.0535    0.000    0.500  3  1.0;
     3  1.00  0.000   0.00    0.00    2.00    1.2394    0.000    0.000  3  0.0;
     4  1.02  0.000   3.18    0.00    0.80    0.4958    0.000    0.500  2  1.0];
 
 %Information about the line matrix
%COL 1.-  From bus
%COL 2.-  to bus
%COL 3.-  R P.U.
%COL 4.-  Xl P.U.
%COL 5.-  Xc (parallel) P.U.
%COL 6.-  Type of line: 0==Line ; 1==Transformer
%COL 7.- phase shifter angle
line=[1  2   0.01008   0.05040    0.05125   0.00   0.00;
      1  3   0.00744   0.03720    0.03875   0.00   0.00;
      2  4   0.00744   0.03720    0.03875   0.00   0.00;
      3  4   0.01272   0.06360    0.06375   0.00   0.00]; 
