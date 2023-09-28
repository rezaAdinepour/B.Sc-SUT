% IMPLEMENTATION OF NEWTON RAPHSON METHOD IN MATLAB
% DESIGNED BY: 
%               HAFIZ KASHIF KHALEEL  B-12588
% CREATED: 16-JAN-2010
% SEMESTER # 7, EE(POWER).
% SUBJECT: POWER SYSTEM OPERATION AND CONTROL.
% TEXT BOOK: POWER SYSTEM ANALYSIS BY WILLIAM D. STEVENSON, JR.
% CHAPTER # 9.3 - 9.4 (PAGE # 342 - 356).
% UNIVERSITY OF SOUTH ASIA. LAHORE. PAKISTAN.
%======================================================= DATA INPUT =======================================================%
clear;clc;close all;

format short g
disp (' TABLE 9.2 PAGE # 337   LINE DATA FOR EXAMPLE 9.2 ')
linedata=[1     2       0.01008,    0.05040,   3.815629,     -19.078144,     10.25,  0.05125;
          1     3       0.00744,    0.03720,   5.169561,     -25.847809,     7.75,   0.03875;
          2     4       0.00744,    0.03720,   5.169561,     -25.847809,     7.75,   0.03875;
          3     4       0.01272,    0.06360,   3.023705,     -15.118528,     12.75,  0.06375]
      
      
disp (' TABLE 9.3 PAGE # 338   BUS DATA FOR EXAMPLE 9.2 ')    
busdata=[1   0,     0,  50,     30.99,  1.00,   0   1;
         2   0,     0,  170,    105.35, 1.00,   0   2;
         3   0,     0,  200,    123.94, 1.00,   0   2;
         4   318,   0 , 80,     49.58,  1.02,   0   3]
     %  Last column shows Bus Type: 1.Slack Bus    2.PQ Bus    3.PV Bus
     
%=================================================== PROGRAM STARTS HERE ===================================================%     
ss=i*linedata(:,8);     % Y/2
y=linedata(:,5)+i*linedata(:,6);
     
totalbuses = max(max(linedata(:,1)),max(linedata(:,2)));    % total buses
totalbranches = length(linedata(:,1));                      % no. of branches
ybus = zeros(totalbuses,totalbuses);  
w=0;
u=0;
for n=1:totalbuses        % total no of PV busses
    if busdata(n,2)>0
        w=w+1;
    end
end
for n=2:totalbuses        % total no of PQ busses
    if busdata(n,2)==0
        u=u+1;
    end
end
% ------ INITIALLIZING YBUS ------
for b=1:totalbranches
    ybus((linedata(b,1)),(linedata(b,2)))=-y(b);
    ybus((linedata(b,2)),(linedata(b,1))) =ybus((linedata(b,1)),(linedata(b,2)));
    
end
 for c=1:totalbuses
     for d=1:totalbranches
         if linedata(d,1) == c || linedata(d,2) == c
             ybus(c,c) = ybus(c,c) + y(d) + ss(d);
         end
     end
 end
disp('TABLE 9.3 PAGE # 338   BUS ADMITTANCE MATRIX FOR EXAMPLE 9.2')
ybus
ybusR=zeros(totalbuses,totalbuses);
ybusA=zeros(totalbuses,totalbuses);
z=zeros(totalbuses,8);
busnumber=busdata(:,1);
PG=busdata(:,2);
QG=busdata(:,3);
PL=busdata(:,4);
QL=busdata(:,5);
V=busdata(:,6);
VV=V;
ANG=busdata(:,7);
type = busdata(:,8);
s=(2*totalbuses)-w-2;
J=zeros(s,s);         % initiallizing empty jacobian matrix
MM=zeros(s,1);
AN=ANG;
P = (PG-PL)./100;    % per unit active power at buses
Q = (QG-QL)./100;    % per unit reactive power at buses
tol=1;
iter=0;
kk=input('Enter the tolerance for iteration ');
%------------------------------Rect to Polar--------------------------------
for b=1:totalbranches
    % Real part of ybus
    ybusR((linedata(b,1)),(linedata(b,2)))=abs(-y(b));
    ybusR((linedata(b,2)),(linedata(b,1))) =ybusR((linedata(b,1)),(linedata(b,2)));
    ybusR(b,b)=abs(-ybus(b,b));
    % Angle of ybus    
    ybusA((linedata(b,1)),(linedata(b,2)))=angle(-y(b));
    ybusA((linedata(b,2)),(linedata(b,1))) =ybusA((linedata(b,1)),(linedata(b,2)));
    ybusA(b,b)=angle(-ybus(b,b));
end
ybusR;
ybusA;
while tol > kk
    
%------------------------ Delta P --------------------------------%
    
    for i = 2:totalbuses
   
      YVV = 0;
    
        for n = 1:totalbuses
            if i~=n
                YVV = YVV + (ybusR(i,n)* V(n)*V(i))*cos((ybusA(i,n))+busdata(n,7)-busdata(i,7));  % multiplying admittance & voltage
            end
        YVV;
        end
             
        Pc(i) = ((abs(V(i))^2)*real(ybus(i,i)))+YVV; % Compute Calculated P.
        deltaP(i)=P(i)-Pc(i);
    end
    Pc;
    dp=deltaP';
    for i=2:totalbuses
    MM(i-1,1)=dp(i);
    end
    %------------------------ Delta Q -----------------------------%
  
    for i = 2:totalbuses-w
   if busdata(i,8)== 2
      YVV = 0;
    
        for n = 1:totalbuses
            if i~=n
                YVV = YVV + (ybusR(i,n)* V(n)*V(i))*sin((ybusA(i,n))+busdata(n,7)-busdata(i,7));  % multiplying admittance & voltage
            end
        YVV;
        end
             
        Qc(i) = -((abs(V(i))^2)*imag(ybus(i,i)))-YVV; % Compute Calculated Q.
        deltaQ(i)=Q(i)-Qc(i);
   end
     end
    Qc;
    dq=deltaQ';
    
 
 
 
 for i=2:totalbuses-w
     if busdata(i,8)== 2
    MM(totalbuses-2+i,1)=dq(i);
     else
         i=i-1;
    end
 end 
 J11=zeros(totalbuses-1,totalbuses-1);
 J12=zeros(totalbuses-1,u);
 J21=zeros(u,totalbuses-1);
 J22=zeros(u,u);
    %----------------------------J11-------------------------------%
    for i=2:totalbuses
        for j=2:totalbuses
            if i~=j
        J11(i-1,j-1)= -abs(((ybusR(i,j)* V(i)*V(j)))*sin((ybusA(i,j))+busdata(j,7)-busdata(i,7)));
            end
               if i==j
                   for n=1:totalbuses
                    if n~=i
                 J11(i-1,i-1)=J11(i-1,i-1)+( abs(((ybusR(i,n)* V(i)*V(n)))*sin((ybusA(i,n))+busdata(n,7)-busdata(i,7))));
                    end
                end
               end
            end
    end
    J11;
    %----------------------------J12-------------------------------%   
    
    for i=2:totalbuses
       
        
        for j=2:totalbuses-w
             if busdata(j,8)== 2
            
            if i~=j
        J12(i-1,j-1)= (abs(V(j))*abs((ybusR(i,j)* V(i))))*cos((ybusA(i,j))+busdata(j,7)-busdata(i,7));
            end
            yv12=0;
            if i==j
                for n=1:totalbuses
                    if n~=i
         yv12=yv12 + abs((ybusR(i,n)* V(n)))*cos((ybusA(i,n))+busdata(n,7)-busdata(i,7));
        
                    end
                end
             J12(i-1,j-1) = abs(V(i))*(2*abs(V(i))*real(ybus(i,i))+yv12);
            end
        end
    end
    end
    J12;
   %----------------------------J21-------------------------------%    
  
   for i=2:totalbuses-w
        if busdata(i,8)== 2
       
       for j=2:totalbuses
           if i~=j
               J21(i-1,j-1)= abs(((ybusR(i,j)* V(i)*V(j)))*cos((ybusA(i,j))+busdata(j,7)-busdata(i,7)));
            end
               if i==j
                   for n=1:totalbuses
                    if n~=i
                 J21(i-1,j-1)=J21(i-1,j-1)+( -abs(((ybusR(i,n)* V(i)*V(n)))*cos((ybusA(i,n))+busdata(n,7)-busdata(i,7))));
                    end
                end
               end
            end
   end
   end
   J21;
    %----------------------------J22-------------------------------%    
    
    for i=2:totalbuses-w
       
        
        for j=2:totalbuses-w
             if busdata(i,8)== 2 && busdata(j,8)== 2
            
            if i~=j
        J22(i-1,j-1)= -(abs(V(j))*abs((ybusR(i,j)* V(i))))*sin((ybusA(i,j))+busdata(j,7)-busdata(i,7));
            end
            yv12=0;
            if i==j
               J22(i-1,j-1)=-(J11(i-1,i-1)) - (2*(abs(V(i))^2)*imag(ybus(i,i)));
            end
        end
    end
    end
    J22;
    %---------------------------------------------------------------------------------%
    
    for k=1:totalbuses-1
        for l=1:totalbuses-1
            
            J(k,l)=J11(k,l);
        end
    end
    
    for k=1:u
        for l=1:totalbuses-1
            
            J(l,k+totalbuses-1)=J12(l,k);
        end
    end
    
    for k=1:u
        for l=1:totalbuses-1
            
            J(k+totalbuses-1,l)=J21(k,l);
        end
    end
    
    for k=1:u
        for l=1:u
            
            J(l+totalbuses-1,k+totalbuses-1)=J22(l,k);
        end
    end
    MM;
    J;
    format short g
    k=inv(J)*MM;
    
      for n=1:totalbuses-1
        S(n)=(ANG(n+1)+k(n));
        sa=radtodeg(S);
        %-------------
        busdata(n+1,7)=S(n);
        
        %-------------
      end
    ANG=busdata(:,7);
    sa;
   
       for m=2:u+1
        V(m)=abs(busdata(m,6)+k(totalbuses-2+m));
        %abs(VV)
      busdata(m,6)=V(m);
       end
     V;
     
   tol=max(abs(abs(V) - abs(VV))) &&  max(abs(abs(ANG) - abs(AN)));
  
    iter=iter+1;
  VV=V;
  AN=ANG;
  
  
end
J
iter
%-------------------------DISPLAYING OUTPUTS---------------------------%
%real(VACC')
z(1:totalbuses,1)=busdata(:,1);
z(1:totalbuses,2)=busdata(:,8);
z(1:totalbuses,3)=abs(busdata(:,6));
z(1:totalbuses,4)=radtodeg(busdata(:,7));
z(1:totalbuses,5)=PG;
z(1:totalbuses,7)=busdata(:,4);
z(1:totalbuses,8)=busdata(:,5);
disp('         |Bus No.|   |Bus Type|  |Voltage|    |Angle|       |MW(G)|     |Mvar(G)|     |MW(L)|   |Mvar(L)| ');
format short g
z
