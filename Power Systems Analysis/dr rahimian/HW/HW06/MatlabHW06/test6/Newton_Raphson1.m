clear;clc;close all;
%% General Program For Newton Raphson Load flow 
% Enter the busdata, and Loaddata in mention form
% Bus data (Bus	 Bus   Vol	   Vol	    Generating	  Load	   Reactive Power limit
%         	no   type  Mag(pu) angle     Pg   QG    Pl     Ql    Qmax   Qmin   
 
% Load Data(From   To       R         X          B            Tap
%            Bus    Bus     (pu)      (pu)       (pu)         Ratio)
clc
clear all
%% Bus data Bus type 1(slack Bus),type2(PV_Bus Bus), type3(PQ_Bus Bus)
tic
		  % Bus	 Bus   Vol	 Vol	  Generating	Load	  Reactive Power limit
          % no   type  Mag   angle     Pg   QG    Pl     Ql    Qmax   Qmin   
busdata=  [ 1     1    1.06    0       0     0     0     0       0       0;
            2     2    1.043   0      40   50.0  21.7   12.7    -40     50;
            3     3    1.0     0       0     0    2.4    1.2     0       0;
            4     3    1.06    0       0     0    7.6    1.6     0       0;
            5     2    1.01    0       0   37.0  94.2   19.0    -40     40;
            6     3    1.0     0       0     0    0.0    0.0     0       0;
            7     3    1.0     0       0     0   22.8   10.9     0       0;
            8     2    1.01    0       0   37.3  30.0   30.0    -10     40;
            9     3    1.0     0       0     0    0.0    0.0     0       0;
            10    3    1.0     0       0   19.0   5.8    2.0     0       0;
            11    2    1.082   0       0   16.2   0.0    0.0    -6      24;
            12    3    1.0     0       0     0   11.2    7.5     0       0;
            13    2    1.071   0       0   10.6   0.0    0.0    -6      24;
            14    3    1.0     0       0     0    6.2    1.6     0       0;
            15    3    1.0     0       0     0    8.2    2.5     0       0;
            16    3    1.0     0       0     0    3.5    1.8     0       0;
            17    3    1.0     0       0     0    9.0    5.8     0       0;
            18    3    1.0     0       0     0    3.2    0.9     0       0;
            19    3    1.0     0       0     0    9.5    3.4     0       0;
            20    3    1.0     0       0     0    2.2    0.7     0       0;
            21    3    1.0     0       0     0   17.5   11.2     0       0;
            22    3    1.0     0       0     0    0.0    0.0     0       0;
            23    3    1.0     0       0     0    3.2    1.6     0       0;
            24    3    1.0     0       0    4.3   8.7    6.7     0       0;
            25    3    1.0     0       0     0    0.0    0.0     0       0;
            26    3    1.0     0       0     0    3.5    2.3     0       0;
            27    3    1.0     0       0     0    0.0    0.0     0       0;
            28    3    1.0     0       0     0    0.0    0.0     0       0;
            29    3    1.0     0       0     0    2.4    0.9     0       0;
            30    3    1.0     0       0     0   10.6    1.9     0       0 ];
%            From   To       R         X          B           Tap
%            Bus    Bus     (pu)      (pu)       (pu)         Ratio
linedata=[   1      2       0.0192    0.0575     0.0264         1
             1      3       0.0452    0.1652     0.0204         1
             2      4       0.0570    0.1737     0.0184         1
             3      4       0.0132    0.0379     0.0042         1
             2      5       0.0472    0.1983     0.0209         1
             2      6       0.0581    0.1763     0.0187         1
             4      6       0.0119    0.0414     0.0045         1
             5      7       0.0460    0.1160     0.0102         1
             6      7       0.0267    0.0820     0.0085         1
             6      8       0.0120    0.0420     0.0045         1
             6      9       0.0       0.2080     0.0        0.978
             6     10       0.0       0.5560     0.0        0.969
             9     11       0.0       0.2080     0.0            1
             9     10       0.0       0.1100     0.0            1
             4     12       0.0       0.2560     0.0        0.932
            12     13       0.0       0.1400     0.0            1
            12     14       0.1231    0.2559     0.0            1
            12     15       0.0662    0.1304     0.0            1
            12     16       0.0945    0.1987     0.0            1
            14     15       0.2210    0.1997     0.0            1
            16     17       0.0824    0.1923     0.0            1
            15     18       0.1073    0.2185     0.0            1
            18     19       0.0639    0.1292     0.0            1
            19     20       0.0340    0.0680     0.0            1
            10     20       0.0936    0.2090     0.0            1
            10     17       0.0324    0.0845     0.0            1
            10     21       0.0348    0.0749     0.0            1
            10     22       0.0727    0.1499     0.0            1
            21     23       0.0116    0.0236     0.0            1
            15     23       0.1000    0.2020     0.0            1
            22     24       0.1150    0.1790     0.0            1
            23     24       0.1320    0.2700     0.0            1
            24     25       0.1885    0.3292     0.0            1
            25     26       0.2544    0.3800     0.0            1
            25     27       0.1093    0.2087     0.0            1
            28     27       0.0       0.3960     0.0        0.968
            27     29       0.2198    0.4153     0.0            1
            27     30       0.3202    0.6027     0.0            1
            29     30       0.2399    0.4533     0.0            1
             8     28       0.0636    0.2000     0.0214         1
             6     28       0.0169    0.0599     0.065          1 ];
%% Data arranged for Linedata in the different vector 
fb=linedata(:,1);tb=linedata(:,2);
r=linedata(:,3);x=linedata(:,4);
b=linedata(:,5);a=linedata(:,6);
z=r+1i*x; 						% Impedance of branch 
y=1./z;b=1i*b;  				% admittance of branch 
nl=length(fb);					% No of branch 
No_of_Bus=max(max(fb),max(tb));		% No of Bus 
%% Formation of YBus matrix 
Y=zeros(No_of_Bus,No_of_Bus);				% Initialize of YBus 
for k=1:nl
    Y(fb(k),tb(k))=Y(fb(k),tb(k))-y(k)/a(k);
    Y(tb(k),fb(k))=Y(fb(k),tb(k));
end
for m=1:No_of_Bus
    for n=1:nl
        if fb(n)==m
            Y(m,m)=Y(m,m)+y(n)/a(n)^2+b(n);
        elseif tb(n)==m
            Y(m,m)=Y(m,m)+y(n)+b(n);
        end
    end
end
G=real(Y);B=imag(Y);			% Separation of YBus 
%% Data arranged for Linedata in the different vector
BMva=100;
busNo=busdata(:,1);type=busdata(:,2);V=busdata(:,3);del=busdata(:,4);
Pg=busdata(:,5)/BMva;Qg=busdata(:,6)/BMva;Pl=busdata(:,7)/BMva;
Ql=busdata(:,8)/BMva;Qmin=busdata(:,9)/BMva;Qmax=busdata(:,10)/BMva;
PV_Bus=find(type==2|type==1);PQ_Bus=find(type==3);  	% type1(Slack),type2(PV_Bus Bus),type3(PQ_Bus Bus )
No_of_PQ_Bus=length(PQ_Bus);No_of_PV_Bus=length(PV_Bus);
Active_Power_specified=Pg-Pl;Reactive_Power_specified=Qg-Ql; % Net Power flow through different node 
Iter=1;Tol=1; % Iterantion And tolerance 
%% Newton Raphson Load Flow 
while Tol>1e-5
    P=zeros(No_of_Bus,1);
    Q=zeros(No_of_Bus,1);
    for i=1:No_of_Bus
        for j=1:No_of_Bus
 P(i)=P(i)+V(i)*V(j)*(G(i,j)*cos(del(i)-del(j))+B(i,j)*sin(del(i)-del(j)));
 Q(i)=Q(i)+V(i)*V(j)*(G(i,j)*sin(del(i)-del(j))-B(i,j)*cos(del(i)-del(j)));
        end
    end
	% Verification of limit violation for reactive power 
    if Iter>2 && Iter<=7
        for n=2:No_of_Bus
            if type(n)==2;
                QG=Q(n)+Ql(n);
                if QG > Qmax(n)
                    V(n)=V(n)-0.01;
                elseif QG < Qmin(n)
                    V(n)=V(n)+0.01;
                end
            end
        end
    end
    dPa=Active_Power_specified-P;
    dQa=Reactive_Power_specified-Q;
    dP=dPa(2:No_of_Bus);
    k=1;
    dQ=zeros(No_of_PQ_Bus,1);
    for i=1:No_of_Bus
        if type(i)==3
            dQ(k,1)=dQa(i);
            k=k+1;
        end
    end
    M=[dP;dQ];% delta Matrix 
	%% Formation Fo Jacobian Matrix[J1 J2;J3 J4]
	%% Formation Of J1 
    J1=zeros(No_of_Bus-1,No_of_Bus-1);
    for i=1:No_of_Bus-1
        m=i+1;
        for j=1:No_of_Bus-1;
            n=j+1;
            if m==n
                for n=1:No_of_Bus 
                J1(i,j)=J1(i,j)+V(m)*V(n)*(-G(m,n)*sin(del(m)-del(n))+B(m,n)*cos(del(m)-del(n)));
                end
                J1(i,j)=J1(i,j)-V(m)^2*B(m,m);
            else
                J1(i,j)=V(m)*V(n)*(G(m,n)*sin(del(m)-del(n))-B(m,n)*cos(del(m)-del(n)));
            end
        end
    end
	%% Formation Of J2
    J2=zeros(No_of_Bus-1,No_of_PQ_Bus);
    for i=1:No_of_Bus-1
        m=i+1;
        for j=1:No_of_PQ_Bus
            n=PQ_Bus(j);
            if m==n
                for n=1:No_of_Bus
                    J2(i,j)=J2(i,j)+V(n)*(G(m,n)*cos(del(m)-del(n))+B(m,n)*sin(del(m)-del(n)));
                end
                J2(i,j)=J2(i,j)+V(m)*G(m,m);
            else
                J2(i,j)=V(m)*(G(m,n)*cos(del(m)-del(n))+B(m,n)*sin(del(m)-del(n)));
            end
        end
    end
	%% Formation Of J3
    J3=zeros(No_of_PQ_Bus,No_of_Bus-1);
    for i=1:No_of_PQ_Bus
        m=PQ_Bus(i);
        for j=1:No_of_Bus-1
            n=j+1;
            if m==n
                for n=1:No_of_Bus
                    J3(i,j)=J3(i,j)+V(m)*V(n)*(G(m,n)*cos(del(m)-del(n))+B(m,n)*sin(del(m)-del(n)));
                end
                J3(i,j)=J3(i,j)-V(m)^2*G(m,m);
            else
                J3(i,j)=V(m)*V(n)*(-G(m,n)*cos(del(m)-del(n))-B(m,n)*sin(del(m)-del(n)));
            end
        end
    end
	%% Formation Of J4
    J4=zeros(No_of_PQ_Bus,No_of_PQ_Bus);
    for i=1:No_of_PQ_Bus
        m=PQ_Bus(i);
        for j=1:No_of_PQ_Bus
            n=PQ_Bus(j);
            if m==n
                for n=1:No_of_Bus
                J4(i,j)=J4(i,j)+V(n)*(G(m,n)*sin(del(m)-del(n))-B(m,n)*cos(del(m)-del(n)));
                end
                J4(i,j)=J4(i,j)-V(m)*B(m,m);
            else
                J4(i,j)=V(m)*(G(m,n)*sin(del(m)-del(n))-B(m,n)*cos(del(m)-del(n)));
            end
        end              
    end
   J=[J1 J2;J3 J4]; % Jacobian Matrix 
   X=inv(J)*M;
    dTh=X(1:No_of_Bus-1); % Change in angle 
    dV=X(No_of_Bus:end);	% change in volatge mag 
    del(2:No_of_Bus)=del(2:No_of_Bus)+dTh; % Voltage angle update 
	% voltage mag update 
    k=1;
    for n=2:No_of_Bus
        if type(n)==3
            V(n)=V(n)+dV(k);
            k=k+1;
        end
    end
    Iter=Iter+1;
    Tol=max(abs(M));
end
Q=zeros(No_of_Bus,1);
 for i=1:No_of_Bus
        for j=1:No_of_Bus
            P(i)=P(i)+V(i)*V(j)*(G(i,j)*cos(del(i)-del(j))+B(i,j)*sin(del(i)-del(j)));
            Q(i)=Q(i)+V(i)*V(j)*(G(i,j)*sin(del(i)-del(j))-B(i,j)*cos(del(i)-del(j)));
        end
 end
 for i=1:No_of_Bus
     del(i)=180*del(i)/pi; % Converion radian to degree 
 end
 %% Load Flow Solution 
disp('----------------------------------------');
disp('  Newton Raphson Loadflow Solution    ');
disp('----------------------------------------');
disp(' |Bus |   |Voltage|    |Angle |');
disp(' | No.|   |pu     |    |Degree|');
disp('----------------------------------------');
for m=1:No_of_Bus 
    fprintf(' %3g   ' ,m);
    fprintf(' %8.3f    ' ,V(m));
    fprintf(' %8.3f  ' ,del(m));
     fprintf(' %8.3f  ',Pg(m)*BMva);
    if type(m)==2
    fprintf(' %8.3f  ',(Q(m)+Ql(m))*BMva);
     
    end
    fprintf('\n');
end
disp('----------------------------------------');
fprintf( 'Number Of Ieration %3g \n',Iter)
toc