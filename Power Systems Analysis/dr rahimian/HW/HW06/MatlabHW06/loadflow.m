% Program for Bus Power Injections, Line & Power flows (p.u)...
function [Pi Qi Pg Qg Pl Ql] = loadflow(nb,V,del,BMva)
Y = ybusppg(nb);                % Calling Ybus program..
lined = linedatas(nb);          % Get linedats..
busd = busdatas(nb);            % Get busdatas..
Vm = pol2rect(V,del);           % Converting polar to rectangular..
Del = 180/pi*del;               % Bus Voltage Angles in Degree...
fb = lined(:,1);                % From bus number...
tb = lined(:,2);                % To bus number...
nl = length(fb);                % No. of Branches..
Pl = busd(:,7);                 % PLi..
Ql = busd(:,8);                 % QLi..
Z=zeros(nb,10);
Iij = zeros(nb,nb);
Sij = zeros(nb,nb);
Si = zeros(nb,1);
% Bus Current Injections..
 I = Y*Vm;
 Im = abs(I);
 Ia = angle(I);
 
%Line Current Flows..
for m = 1:nl
    p = fb(m); q = tb(m);
    Iij(p,q) = -(Vm(p) - Vm(q))*Y(p,q); % Y(m,n) = -y(m,n)..
    Iij(q,p) = -Iij(p,q);
end
Iij = sparse(Iij);
Iijm = abs(Iij);
Iija = angle(Iij);
% Line Power Flows..
for m = 1:nb
    for n = 1:nb
        if m ~= n
            Sij(m,n) = Vm(m)*conj(Iij(m,n))*BMva;
        end
    end
end
Sij;
k=1;
l=1;
for m=1:nb
    for n=1:nb
        if n>m
         if Sij(m,n)~=0;
            Z(k,1)=m;
            Z(k,2)=n;
            Z(k,3)= real(Sij(m,n));
            Z(k,4)= imag(Sij(m,n));
            k=k+1;
         end
        else m>n
          if Sij(m,n)~=0;
            Z(l,5)=m;
            Z(l,6)=n;
            Z(l,7)= real(Sij(m,n));
            Z(l,8)= imag(Sij(m,n));
            l=l+1;
          end
        end
    end
end
Sij = sparse(Sij);
Pij = real(Sij);
Qij = imag(Sij);
 
% Line Losses..
Lij = zeros(nl,1);
for m = 1:nl
    p = fb(m); q = tb(m);
    Lij(m) = Sij(p,q) + Sij(q,p);
    
end
Lpij = real(Lij);
Lqij = imag(Lij);
for m=1:nl
   Z(m,9)=Lpij(m,1);
   Z(m,10)=Lqij(m,1);
end 
Z;
% Bus Power Injections..
for i = 1:nb
    for k = 1:nb
        Si(i) = Si(i) + conj(Vm(i))* Vm(k)*Y(i,k)*BMva;
    end
end
Pi = real(Si);
Qi = -imag(Si);
Pg = Pi+Pl;
Qg = Qi+Ql;
 
disp('#########################################################################################');
disp('-----------------------------------------------------------------------------------------');
disp('                              Newton Raphson Loadflow Analysis ');
disp('-----------------------------------------------------------------------------------------');
disp('| Bus |    V   |  Angle  |     Injection      |     Generation     |          Load      |');
disp('| No  |   pu   |  Degree |    MW   |   MVar   |    MW   |  Mvar    |     MW     |  MVar | ');
for m = 1:nb
    disp('-----------------------------------------------------------------------------------------');
    fprintf('%3g', m); fprintf('  %8.4f', V(m)); fprintf('   %8.4f', Del(m));
    fprintf('  %8.3f', Pi(m)); fprintf('   %8.3f', Qi(m)); 
    fprintf('  %8.3f', Pg(m)); fprintf('   %8.3f', Qg(m)); 
    fprintf('  %8.3f', Pl(m)); fprintf('   %8.3f', Ql(m)); fprintf('\n');
end
disp('-----------------------------------------------------------------------------------------');
fprintf(' Total                  ');
fprintf('  %8.3f', sum(Pi)); 
fprintf('   %8.3f', sum(Qi)); 
fprintf('  %8.3f', sum(Pi+Pl));
fprintf('   %8.3f', sum(Qi+Ql));
fprintf('  %8.3f', sum(Pl)); 
fprintf('   %8.3f', sum(Ql)); 
fprintf('\n');
disp('-----------------------------------------------------------------------------------------');
disp('#########################################################################################');
disp('-------------------------------------------------------------------------------------');
disp('                              Line FLow and Losses ');
disp('-------------------------------------------------------------------------------------');
disp('|From|To |    P    |    Q     | From| To |    P     |   Q     |      Line Loss      |');
disp('|Bus |Bus|   MW    |   MVar   | Bus | Bus|    MW    |  MVar   |     MW   |    MVar  |');
for m = 1:nl
    p = Z(m,1); q = Z(m,2); Pij=Z(m,3); Qij=Z(m,4); Pji= Z(m,7); Qji=Z(m,8); Lpij= Z(m,9); Lqij=Z(m,10);
    disp('-------------------------------------------------------------------------------------');
    fprintf('%4g', p); fprintf('%4g', q); fprintf('  %8.3f', Pij); fprintf('   %8.3f', Qij); 
    fprintf('   %4g', q); fprintf('%4g', p); fprintf('   %8.3f', Pji); fprintf('   %8.3f', Qji);
    fprintf('  %8.3f', Lpij); fprintf('   %8.3f', Lqij);
    fprintf('\n');
end
disp('-------------------------------------------------------------------------------------');
fprintf('   Total Loss                                                 ');
fprintf('  %8.3f', sum(Z(:,9))); fprintf('   %8.3f', sum(Z(:,10)));  fprintf('\n');
disp('-------------------------------------------------------------------------------------');
disp('#####################################################################################');
end
