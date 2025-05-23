
%% Topology of the power system (IEEE 9 bus system)
% Information about the bus matrix
  % nd   V    Ang.    Pg      Qg      PL      QL      Gs       jBs    Type
  % (1) (2)   (3)     (4)     (5)     (6)     (7)     (8)      (9)    (10)
  % Colum 11: if the bus has shunt element =1, if it hasnt shunt element =0
bus = [   1	    1.0	  0.0	  0.00	 0.0      0.00	   0.0	    0.0	    0.0	  1   0;
          2	    1.0	  0.0     1.63	 0.0      0.00	   0.0	    0.0	    0.0	  2   0;
          3	    1.0	  0.0     0.85	 0.0      0.00	   0.0	    0.0	    0.0	  2   0;
          4	    1.0	  0.0	  0.00	 0.0      0.00	   0.0	    0.0	    0.0	  3   0;
          5	    1.0	  0.0	  0.00	 0.0      0.90	   .30	    0.0	    0.0	  3   0;
          6	    1.0	  0.0	  0.00	 0.0      0.00	   0.0	    0.0	    0.0	  3   0;
          7	    1.0	  0.0	  0.00	 0.0      1.00     .35	    0.0	    0.0	  3   0;
          8	    1.0	  0.0	  0.00	 0.0      0.00	   0.0	    0.0	    0.0	  3   0;
          9	    1.0	  0.0	  0.00	 0.0      1.25     .50	    0.0	    0.0	  3   0];
      
%Information about the line matrix
%COL 1.-  From bus
%COL 2.-  to bus
%COL 3.-  R P.U.
%COL 4.-  Xl P.U.
%COL 5.-  Xc (parallel) P.U.
%COL 6.-  Type of line: 0==Line ; 1==Transformer
%COL 7.- phase shifter angle
line = [1     4	     0.0000	    0.0576      0.000	1.0   0.0;
        4	  5	     0.0170     0.0920      0.158	0.0   0.0;
        5     6	     0.0390     0.1700      0.358	0.0   0.0;
        3     6	     0.0000	    0.0586	    0.000	1.0   0.0;
        6     7	     0.0119     0.1008      0.209	0.0   0.0;
        7     8	     0.0085     0.0720      0.149	0.0   0.0;
        8     2      0.0000	    0.0625	    0.000	1.0   0.0;
        8     9	     0.0320	    0.1610      0.306	0.0   0.0;
        9     4	     0.0100	    0.0850      0.176	0.0   0.0];
