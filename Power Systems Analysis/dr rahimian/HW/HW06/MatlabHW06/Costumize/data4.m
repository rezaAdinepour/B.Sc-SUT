
%% Topology of the power system (Stevenson 4 bus test case)
% Information about the bus matrix
  % nd   V    Ang.    Pg      Qg      PL      QL        Gs       jBs    Type
  % (1) (2)   (3)     (4)     (5)     (6)     (7)       (8)      (9)    (10)
  % Colum 11: if the bus has shunt element =1, if it hasnt shunt element =0
bus=[1  1.00  0.000   0.00    0.00    0.60    0.2500    0.000    0.000  1  0.0;
     2  1.05  0.000   1.40    0.00    0.50    0.2000    0.000    0.000  2  0.0;
     3  1.00  0.000   0.20    0.10    0.40    0.1500    0.000    0.000  3  0.0;
     4  1.00  0.000   0.00    0.00    0.40    0.1500    0.000    0.000  3  0.0;
     5  1.00  0.000   0.00    0.00    0.50    0.2000    0.000    0.000  3  0.0;
     6  1.00  0.000   0.00    0.00    0.50    0.2000    0.000    0.000  3  0.0;];
 
 %Information about the line matrix
%COL 1.-  From bus
%COL 2.-  to bus
%COL 3.-  R P.U.
%COL 4.-  Xl P.U.
%COL 5.-  Xc (parallel) P.U.
%COL 6.-  Type of line: 0==Line ; 1==Transformer
%COL 7.- phase shifter angle
line=[1  2   0.10000   0.17000    0.00000   0.00   0.00;
      1  4   0.15000   0.25800    0.00000   0.00   0.00;
      2  4   0.12000   0.19700    0.00000   0.00   0.00;
      5  6   0.08000   0.14000    0.00000   0.00   0.00;
      3  6   0.01000   0.01800    0.00000   0.00   0.00;
      2  3   0.02000   0.03700    0.00000   0.00   0.00;
      4  5   0.02000   0.03700    0.00000   0.00   0.00;]; 
