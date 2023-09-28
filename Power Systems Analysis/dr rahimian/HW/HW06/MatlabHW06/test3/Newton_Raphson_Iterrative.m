clc
clear
format short g
%        |From| |To | |  R  | |  X   |
%        |Bus | |Bus| 
Linedata=[ 1      2    0.042   0.168;
           1      5    0.031   0.126;
           2      3    0.031   0.126;
           3      4    0.084   0.336;
           3      5    0.053   0.210;
           4      5    0.063   0.252];
       
%        |Voltage||Angle||Generated||Generated||Load ||Load    ||Type|
%        |Per    ||Per  ||Real     ||Reactive ||Real ||Reactive||of  |
%        |Unit   ||Unit ||Power    ||Power    ||Power||Power   ||Bus |
Busdata=[ 1.04      0         0         0        65       30      1;
          1.00      0         0         0       115       60      3;
          1.02      0        180        0        70       40      2;
          1.00      0         0         0        70       30      3;
          1.00      0         0         0        85       40      3];
n1=max(Linedata(:,1));
n2=max(Linedata(:,2));
n=max(n1,n2);
x=size(Linedata);
a=x(1);
for k=1:a
b=Linedata(k,:);
f=b(1);
t=b(2);
R=b(3);
X=b(4);
z(f,t)=R+j*X;
y(f,t)=1/(z(f,t));
y(t,f)=y(f,t);
end
y;
for k=1:n
Y(k,k)=sum(y(k,:));  %Diagonal element
end
for p=1:n
for q=1:n
if p~=q
Y(p,q)=-y(p,q);  %Off-diagonal element
end
end
end
Ybus=Y;          % Admittance matrix
[n,m]=size(Busdata);
Ym=abs(Ybus);         %Magnitude of Admittance matrix
YTheta=angle(Ybus);  % Angle of admittance matrix in radian
Vm=Busdata(:,1);  %Known voltage magnitude
Delta=Busdata(:,2); %Known angle in radian
type=Busdata(:,7); %Type of buses 1 for slack bus, 2 for P-V bus, 3 for P-Q bus
Pg=Busdata(:,3)/100; %Generated real power in per unit, base is 100 Watt
Pl=Busdata(:,5)/100; %real power for  load in per unit, base is 100 Watt
Qg=Busdata(:,4)/100; %Reactive power for generation in per unit, Base is 100 MVA
Ql=Busdata(:,6)/100; %Reactive power for load in per unit, base is 100 MVA
P=Pg-Pl; %Real power
Q=Qg-Ql; %Reactive power
pa=find(type>1); %Position to determine angle
o=length(pa); %How many quantaties to determine angle
pv=find(type>2); %position to determine voltage
l=length(pv); %How many quantaties to determine voltage
pq=find(type==1|type==2); %Position to determine reactive power
pp=find(type==1); %Position to determine real power
r=length(pq); %How many quantaties to determine reactive power
s=length(pp); %How many quantaties to determine real power
P=P(pa,:);
Q=Q(pv,:);
disp('     Angle         Voltage  Real_Power_Generation  Reactive_Power_Generation Real_Power_Load  Reactive_Power_Load')
Iter=0;
while (1) %Iteration start
for ii=1:o
SumP=0;
for ii=1:o
SumP=0;
for t=1:n %There is one slack bus
SumP=SumP+Vm(pa(ii))*Vm(t)*Ym(pa(ii),t)*cos(YTheta(pa(ii),t)-Delta(pa(ii))+Delta(t));
F(pa(ii),1)=SumP;
end
end
F=F(pa,:);
for ii=1:l
SumQ=0;  %Calculation of reactive power
for t=1:n
SumQ=SumQ-Vm(pv(ii))*Vm(t)*Ym(pv(ii),t)*sin(YTheta(pv(ii),t)-Delta(pv(ii))+Delta(t));
G(pv(ii),1)=SumQ;
end
end
G=G(pv,:);
dP=P-F;
dQ=Q-G;
Pm=[dP;dQ];  % Power mismatch
for ii=1:o %Calculation of Jacobian matrix
    for k=1:o
        for u=1:l
            for v=1:l
                if(pa(ii)~=pa(k)|pa(ii)~=pv(u)|pv(u)~=pa(ii)|pv(u)~=pv(v)) %Off-diagonal element
H(pa(ii),pa(k))=-Vm(pa(ii))*Vm(pa(k))*Ym(pa(ii),pa(k))*sin(YTheta(pa(ii),pa(k))-Delta(pa(ii))+Delta(pa(k)));
L(pa(ii),pv(u))=Vm(pa(ii))*Ym(pa(ii),pv(u))*cos(YTheta(pa(ii),pv(u))-Delta(pa(ii))+Delta(pv(u)));
M(pv(u),pa(ii))=-1*Vm(pv(u))*Vm(pa(ii))*Ym(pv(u),pa(ii))*cos(YTheta(pv(u),pa(ii))-Delta(pv(u))+Delta(pa(ii)));
N(pv(u),pv(v))=-1*Vm(pv(u))*Ym(pv(u),pv(v))*sin(YTheta(pv(u),pv(v))-Delta(pv(u))+Delta(pv(v)));
                else
sumH=0; sumL=0; sumM=0; sumN=0;  % Diagonal Element
for t=1:n
    if (t~=pa(ii)|t~=pv(u))
sumH=sumH+Vm(pa(ii))*Vm(t)*Ym(pa(ii),t)*sin(YTheta(pa(ii),t)-Delta(pa(ii))+Delta(t));
H(pa(ii),pa(k))=sumH;
sumL=sumL+Vm(t)*Ym(pa(ii),t)*cos(YTheta(pa(ii),t)-Delta(pa(ii))+Delta(t));
L(pa(ii),pv(u))=sumL+2*Vm(pa(ii))*Ym(pa(ii),pa(ii))*cos(YTheta(pa(ii),pa(ii)));
sumM=sumM+Vm(pv(u))*Vm(t)*Ym(pv(u),t)*cos(YTheta(pv(u),t)-Delta(pv(u))+Delta(t));
M(pv(u),pa(ii))=sumM;
sumN=sumN+Vm(t)*Ym(pv(u),t)*sin(YTheta(pv(u),t)-Delta(pv(u))+Delta(t));
N(pv(u),pv(v))=-(sumN)-2*Vm(pv(u))*Ym(pv(u),pv(u))*sin(YTheta(pv(u),pv(u)));
end
end
end
end
end
end
end
H=H(:,pa);
H=H(pa,:);   % H Matrix
L=L(pa,:);
L=L(:,pv);   % L Matrix
M=M(pv,:);
M=M(:,pa);   % M Matrix
N=N(pv,:);
N=N(:,pv);    % N Matrix
J=[H L;M N];  % Jacobian Matrix
R=J\Pm;       % Result
RAngle=R(1:o); %Result angle in radian
RVoltage=R(o+1:l+o); % Result Voltage
k=1;
for ii=1:n;
    if (type(ii)==2 | type(ii)==3)
        Delta(ii)=RAngle(k) + Delta(ii);
        k=k+1;
    end
end
k=1;
for ii=1:n
if type(ii)==3
Vm(ii)=RVoltage(k)+Vm(ii);
k=k+1;
end
end
Iter=Iter+1;
ea=max(abs(Pm)); % Error Accuracy
if Iter>=50|ea<=0.00001 %Test of convergence
end
end
break
end
for ii=1:n %Angle in degree
Angle(ii,1)=((Delta(ii)*180)/pi);
end
Angle;
Voltage=Vm;
for ii=1:s
SumP=0;
for t=1:n
SumP=SumP+Vm(pp(ii))*Vm(t)*Ym(pp(ii),t)*cos(YTheta(pp(ii),t)-Delta(pp(ii))+Delta(t));
Pcal(pp(ii),1)=SumP;
end
end
Pcal=Pcal(pp,:);
k=1;
for ii=1:n
if type(ii)==1
Pg(ii)=Pcal(k);
k=k+1;
end
end
Real_Power_Generation=Pg*100;
for ii=1:r
SumQ=0;
for t=1:n
SumQ=SumQ-Vm(pq(ii))*Vm(t)*Ym(pq(ii),t)*sin(YTheta(pq(ii),t)-Delta(pq(ii))+Delta(t));
Qcal(pq(ii),1)=SumQ;
end
end
Qcal=Qcal(pq,:);
k=1;
for ii=1:n
if type(ii)==1|type(ii)==2
Qg(ii)=Qcal(k);
k=k+1;
end
end
Reactive_Power_Generation=Qg*100;
Real_Power_Load=Pl*100;
Reactive_Power_Load=Ql*100;
disp([Angle, Voltage, Real_Power_Generation, Reactive_Power_Generation, Real_Power_Load, Reactive_Power_Load])
