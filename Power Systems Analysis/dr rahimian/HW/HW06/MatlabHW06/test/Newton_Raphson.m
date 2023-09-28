
%% Newton Raphson Load Flow analysis
clear all; close all; clc
%% Choose the system to analize 
disp('Choose the power system to analize')
flag=0;
while (flag==0)
    disp(' Type 1 to use the IEEE 5 bus power system')
    disp(' Type 2 to use the IEEE 6 bus power system')
    disp(' Type 3 to use the IEEE 9 bus power system')
    disp(' Type 4 to use the 4 bus power system from Stevenson Book')
    sel = input('enter selection >> ');
    if sel==1
        Datasets=1;
        flag = 1;
    elseif sel==2
        Datasets=2;
        flag = 1;
    elseif sel==3
        Datasets=3;
        flag = 1;
    elseif sel==4
        Datasets=4;
        flag = 1;
    else
        disp('not a valid choice')
    end
end
%% Power systems available to analize
switch Datasets
    case 1
        data5; % 5 bus electric power system data
    case 2
        data6; % 6 bus electric power system data
    case 3
        data9; % 9 bus electric power system data
    case 4
        data4; % 4 bus electric power system data (Stevenson book)
end
%% Compute the admittance matrix and define the initial states
nbuses=length(bus(:,1)); % number of buses of the electric power system
[Y] = Y_admi(line,bus,nbuses); % function to get the admittance matrix 
V=bus(:,2); % initial voltage
Theta=bus(:,3); % initial phase
% Net power (Generation - Load)
P_neta=bus(:,4)-bus(:,6);     
Q_neta=bus(:,5)-bus(:,7); 
%Get the conductance and suceptance matrix
G = real(Y);             % conductance matrix
B = imag(Y);             % suceptance matrix
% Type of bus
slack=find(bus(:,10)==1);% slack bus
PQ=find(bus(:,10)==3);   % PQ bus
PV=find(bus(:,10)==2);   % PV bus
% Adquiere the total number of buses
nslack=length(slack);    % slack bus
nPQ=length(PQ);          % number of load buses: PQ; find V y Theta
nPV=length(PV);          % number of generation buses: PV; find Theta
tol_max=10e-6;    % tolerance of the solution
%% Iterative method Newton Raphson
Tol=1; %
Ciclos=0;
st=clock; % start the iteration time clock
while (Tol>tol_max)
    [P_cal,Q_cal]=cal_power(G,B,nbuses,Theta,V); % this function calculates the power
    [mismatch_PQ]=mismatch_Power(P_neta,Q_neta,P_cal,Q_cal,nbuses,PQ,nPQ); % this function gets the mismatch power
    % Jacobian Matrix
    [J]=Jacobian(G,B,V,Theta,nbuses,PQ,nPQ); % this function gets the jacobian matrix for the n iteration
    mismatch_X=inv(J)*mismatch_PQ;
    dTeth=mismatch_X(1:nbuses-1);
    dV=mismatch_X(nbuses:end);
    %Update V and Tetha
    Theta(2:nbuses)=Theta(2:nbuses)+dTeth;
    for i=1:nPQ
        n=PQ(i);
        V(n)=V(n)+dV(i);
    end
    Tol=max(abs(mismatch_PQ));
    Ciclos=Ciclos+1;
end
ste=clock; % end the iteration time clock
%% Power flows
Vm = V.*cos(Theta) + 1i*V.*sin(Theta);% Complex voltage in PU
% currents at each node
I=Y*Vm;
% Power at each node
S=Vm.*conj(I); % Complex power
for k=1:nbuses
    if bus(k,10)==1
        % Real and reactive generation at the Slack bus
        Pgen(k)=real(S(k));
        Qgen(k)=imag(S(k));
    end
    if bus(k,10)==2
        % Real and reactive generation at the PV buses
        Pgen(k)=real(S(k))+bus(k,6);
        Qgen(k)=imag(S(k))+bus(k,7);
    end
    if bus(k,10)==3
        Pgen(k)=0;
        Qgen(k)=0;
    end
end
% calculate the line flows and power losses
FromNode=line(:,1);
ToNode=line(:,2);
nbranch=length(line(:,1)); % number of branches
for k=1:nbranch
    a=line(k,6);   % Find out if is a line or a transformer, a=0 -> line, a=1 -> transformer, 0<a<1 -> Transformer
    switch a    % for both cases use the pi model
        case 0  %if its a line a=0
            b=1i*line(k,5);
            suceptancia(k,1)=b/2; 
            suceptancia(k,2)=b/2;
        otherwise %if its a transformer
            Zpq=line(k,3)+1i*line(k,4);
            Ypq=Zpq^-1;
            suceptancia(k,1)=(Ypq/a)*((1/a)-1); 
            suceptancia(k,2)=Ypq*(1-(1/a));
    end
end
% Define admmitance of lines
r = line(:,3);
rx = line(:,4);
z = r + j*rx;
y = ones(nbranch,1)./z;
% Define complex power flows
Ss = Vm(FromNode).*conj((Vm(FromNode) - Vm(ToNode)).*y ...
   + Vm(FromNode).*suceptancia(:,1)); % complex flow of the sending buses
Sr = Vm(ToNode).*conj((Vm(ToNode) - Vm(FromNode)).*y ...
   + Vm(ToNode).*suceptancia(:,2)); % complex low of the receiving buses
% Define active and reactive power flows
Pij=real(Ss);
Qij=imag(Ss);
Pji=real(Sr);
Qji=imag(Sr);
% Active power lossess
P_loss=sum(Pij+Pji);
% Reactive power lossess
Q_loss=sum(Qij+Qji);
% +++++++++++++++++++++++++++ Print results +++++++++++++++++++++++++++++++
disp('                      Newton Raphson Load-Flow Study')
disp('                    Report of Power Flow Calculations ')
disp(' ')
disp(date)
fprintf('Number of iterations       : %g \n', Ciclos)
fprintf('Solution time              : %g sec.\n',etime(ste,st))
fprintf('Total real power losses    : %g.\n',P_loss)
fprintf('Total reactive power losses: %g.\n\n',Q_loss)
disp('                                      Generation             Load')
disp('      Bus      Volts     Angle      Real  Reactive      Real  Reactive ')
ywz=[  bus(:,1)    abs(Vm)  (180/pi)*Theta  Pgen'  Qgen'  bus(:,6)  bus(:,7)];
disp(ywz)
disp('                      Line Flows                     ')
disp('    #Line    From Bus   To Bus     Real    Reactive   ')
l=1:1:length(line(:,1));
xy=[l' FromNode ToNode Pij Qij];
yx=[l' ToNode  FromNode Pji Qji];
disp(xy)
disp(yx)
%% Additional options
 flag1=0;
 while (flag1==0)
     disp(' Type 1 to see bus voltage magnitude')
     disp(' Type 2 to see bus voltage phase')
     disp(' Type 3 to see active power flows')
     disp(' Type 4 to see reactive power flows')
     disp(' Type 5 to  quit')     
     sel = input('Introduce an option >> ');
     if sel==1
      bar(V)
      title('bus voltage magnitude')
      xlabel('bus number')
      ylabel('voltage in pu')
      disp('paused: press any key to continue')
      pause
     elseif sel==2
     bar((180/pi)*Theta)
     title('bus voltage phase')
     xlabel('bus number')
     ylabel('phase in degrees')
     disp('paused: press any key to continue')
     pause
     elseif sel==3
     bar(Pij)
     title('Active power flows (Pij)')
     xlabel('# of line')
     ylabel('Active flow in pu')
     disp('paused: press any key to continue')
     pause
     elseif sel==4
     bar(Qij)
     title('Reactive power flows (Qij)')
     xlabel('# of line')
     ylabel('Reactive flow in pu')
     disp('paused: press any key to continue')
     pause
     elseif sel ==5
         flag1=1;
     else
         disp('not a valid choice')
     end 
end
