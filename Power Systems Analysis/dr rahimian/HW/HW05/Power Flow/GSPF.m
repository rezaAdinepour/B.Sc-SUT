% Power flow based on Gauss Seidel
clc;
clear;
data; % Call system data
%% Y-bus calculation
NO_bus=bus_data(end,1);% Number of buses
NO_line=line_data(end,1);% Number of lines
Y=zeros(NO_bus,NO_bus);
for k=1:NO_line
    Y(line_data(k,2),line_data(k,3))=-1/line_data(k,4);
    Y(line_data(k,3),line_data(k,2))=-1/line_data(k,4);
    Y(line_data(k,2),line_data(k,2))=Y(line_data(k,2),line_data(k,2))+1/line_data(k,4)+0.5*line_data(k,6);
    Y(line_data(k,3),line_data(k,3))=Y(line_data(k,3),line_data(k,3))+1/line_data(k,4)+0.5*line_data(k,6);
end

%% 
P=bus_data(:,3)-bus_data(:,7);% Active power injection
Q=bus_data(:,4)-bus_data(:,8);% Reactive power injection
V=bus_data(:,9);% Initial voltage
V_data=V;
Vo=bus_data(:,9);
epsilon=0.0001;% Maximum acceptable error
error=1;
t=1;% Iteration
while error>epsilon
    t=t+1;
    for b=1:NO_bus
        %% P-|V| buses
        if bus_data(b,2)==2
            Q(b)=-imag(V(b)'*Y(b,:)*V);% Estimating reactive power injection
            if Q(b)+bus_data(b,8)>bus_data(b,5)% if QG>QGmax
                Q(b)=bus_data(b,5)-bus_data(b,8);
            elseif Q(b)+bus_data(b,8)<bus_data(b,6)% if QG<QGmin
                Q(b)=bus_data(b,6)-bus_data(b,8);
            else % if QGmin<= QG <= QGmax -> Bus Type: Voltage Controled
                Y1=Y(b,:);
                Y1(1,b)=[];
                V1=V;
                V1(b)=[];
                
                V(b)=(1/Y(b,b))*((((bus_data1(b,3)-bus_data1(b,7))-1j*Q(b))/(V(b)))-(Y1(b,:)*V1)); 
                V(b)=(V(b)/abs(V(b)))*abs(bus_data1(b,9));
            end
        end
        %% P-Q buses
        if bus_data(b,2)==3
          V(b)=((P(b)-Q(b)*i)/V(b)'-(Y(b,:)*V-Y(b,b)*V(b)))/Y(b,b);  
        end
    end
    error=max([max(abs(real(V-Vo))),max(abs(imag(V-Vo)))]);
    Vo=V;
    V_data(:,t)=V;
end
b=find(bus_data(:,2)==1);% Slack bus
P(b)=real(V(b)'*Y(b,:)*V);% Active power injection at slack bus
Q(b)=-imag(V(b)'*Y(b,:)*V);% Reactive power injection at slack bus
power_loss=sum(P)% Active power loss
%% Plot curves
b=2;
subplot(2,1,1);plot(abs(V_data(b,:)),'-o');xlabel('Iteration');ylabel('Voltage magnitude (p.u.)');
subplot(2,1,2);plot(angle(V_data(b,:))*180/pi,'-o');xlabel('Iteration');ylabel('Voltage angle (degree)');
