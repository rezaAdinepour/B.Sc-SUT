% Power flow based on Gauss Seidel
clear;clc;close all;
data; % Call system data

%% Y-bus calculation
NO_bus=bus_data(end,1);% Number of buses
NO_line=line_data(end,1);% Number of lines
Y=zeros(NO_bus, NO_bus);
for k=1:NO_line
    Y(line_data(k,2),line_data(k,3))=-1/line_data(k,4);
    Y(line_data(k,3),line_data(k,2))=-1/line_data(k,4);
    Y(line_data(k,2),line_data(k,2))=Y(line_data(k,2),line_data(k,2))+1/line_data(k,4)+0.5*line_data(k,6);
    Y(line_data(k,3),line_data(k,3))=Y(line_data(k,3),line_data(k,3))+1/line_data(k,4)+0.5*line_data(k,6);
end

%%
P=bus_data(:,3)-bus_data(:,7);% PG-PD: Active power injection
Q=bus_data(:,4)-bus_data(:,8);% QG-QD: Reactive power injection
V=bus_data(:,9);% Initial voltage
V_data=V;
Vo=bus_data(:,9); % Old value of voltage
epsilon=0.0001;% Maximum acceptable error
error=1;
t=1;% Iteration
bus_data1=bus_data;
while error>epsilon
    t=t+1;
    for b=1:NO_bus
        %% P-|V| buses
        if bus_data1(b,2)==2
            Q(b)=-imag(V(b)'*Y(b,:)*V);% Estimating reactive power injection
            if Q(b)+bus_data1(b,8)>bus_data1(b,5)% if QG>QGmax
                Q(b)=bus_data1(b,5)-bus_data1(b,8); 
                bus_data1(b,2)=3;
            elseif Q(b)+bus_data1(b,8)<bus_data1(b,6)% if QG<QGmin
                Q(b)=bus_data1(b,6)-bus_data1(b,8);
                bus_data1(b,2)=3;
            else                % if QGmin<= QG <= QGmax
                Y1=Y(b,:);
                Y1(1,b)=[];
                V1=V;
                V1(b)=[];
                
                V(b)=(1/Y(b,b))*((((bus_data1(b,3)-bus_data1(b,7))-1j*Q(b))/(V(b)))-(Y1(b,:)*V1)); 
                V(b)=(V(b)/abs(V(b)))*abs(bus_data1(b,9));
            end
        end
        %% P-Q buses
        if bus_data1(b,2)==3
            V(b)=((P(b)-Q(b)*1i)/V(b)'-(Y(b,:)*V-Y(b,b)*V(b)))/Y(b,b);
        end
    end  
    error=max([max(abs(real(V-Vo))),max(abs(imag(V-Vo)))]);
    Vo=V;
    V_data(:,t)=V;
end
b=find(bus_data1(:,2)==1);% Slack bus
P(b)=real(V(b)'*Y(b,:)*V);% Active power injection at slack bus
Q(b)=-imag(V(b)'*Y(b,:)*V);% Reactive power injection at slack bus
power_loss=sum(P);% Active power loss

%% Plot curves

for b=1:NO_bus
    figure('Name',['Voltage Changes In Every Iteration For Bus-' num2str(b)],'NumberTitle','off');
    subplot(2,1,1);
    plot(abs(V_data(b,:)), '-o');
    xlabel('Iteration');
    ylabel('Voltage amplitude (p.u.)');
    
    subplot(2,1,2);
    plot(angle(V_data(b,:))*180/pi, '-o r');
    xlabel('Iteration');
    ylabel('Voltage angle (degree)');
end


disp('                  Report of Power Flow Calculations ')
disp('----------------------------------------------------------------------');
disp('  Bus  |       Voltage        |   Bus Type   |           P-Q           ');
disp('   #   |  Amp(pu)    Ang(deg) |      #       |    P(pu)        Q(pu)   ');
disp('  ---     -------    --------     ---------     --------     --------  ');
for i = 1:NO_bus
    fprintf(' %3g      ',i);
    fprintf(' %1.2f  %10.2f   ',abs(V_data(i,end)),angle(V_data(i,end)));
    if(bus_data(i,2)==1)
        fprintf('     Slack')
    elseif(bus_data(i,2)==2)
        fprintf('      P-V ')
    elseif(bus_data(i,2)==3)
        fprintf('      P-Q ')
    end
    fprintf('     %10.3f   %10.3f       \n',P(i),Q(i));
end
disp('----------------------------------------------------------------------');
fprintf('  Active Power Loss is = %1.4f p.u. \n',power_loss);
fprintf('  Number of Iteration = %d  \n',t);