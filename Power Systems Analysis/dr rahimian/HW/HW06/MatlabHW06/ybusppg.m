% Program to for Admittance And Impedance Bus Formation....
function Y = ybusppg(num)  % Returns Y
linedata = linedatas(num);      % Calling Linedatas...
fb = linedata(:,1);             % From bus number...
tb = linedata(:,2);             % To bus number...
r = linedata(:,3);              % Resistance, R...
x = linedata(:,4);              % Reactance, X...
b = linedata(:,5);              % Ground Admittance, B/2...
a = linedata(:,6);              % Tap setting value..
z = r + i*x;                    % z matrix...
y = 1./z;                       % To get inverse of each element...
b = i*b;                        % Make B imaginary...
nb = max(max(fb),max(tb));      % No. of buses...
nl = length(fb);                % No. of branches...
Y = zeros(nb,nb);               % Initialise YBus...
 
 % Formation of the Off Diagonal Elements...
 for k = 1:nl
     Y(fb(k),tb(k)) = Y(fb(k),tb(k)) - y(k)/a(k);
     Y(tb(k),fb(k)) = Y(fb(k),tb(k));
 end
 
 % Formation of Diagonal Elements....
 for m = 1:nb
     for n = 1:nl
         if fb(n) == m
             Y(m,m) = Y(m,m) + y(n)/(a(n)^2) + b(n);
         elseif tb(n) == m
             Y(m,m) = Y(m,m) + y(n) + b(n);
         end
     end
 end
 %Y;                  % Bus Admittance Matrix
 %Z = inv(Y);      % Bus Impedance Matrix
