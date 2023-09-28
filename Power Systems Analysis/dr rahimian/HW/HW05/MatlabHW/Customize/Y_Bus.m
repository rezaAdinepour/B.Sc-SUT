% determine Y-Bus
clear;clc;close all;
data; % Call system data

%% Y-bus calculation
NO_bus=bus_data(end,1); % Number of buses
NO_line=line_data(end,1); % Number of lines
Y_bus=zeros(NO_bus, NO_bus);
for k=1:NO_line
    Y_bus(line_data(k,2),line_data(k,3))=-1/line_data(k,4);
    Y_bus(line_data(k,3),line_data(k,2))=-1/line_data(k,4);
    Y_bus(line_data(k,2),line_data(k,2))=Y_bus(line_data(k,2),line_data(k,2))+1/line_data(k,4)+0.5*line_data(k,6);
    Y_bus(line_data(k,3),line_data(k,3))=Y_bus(line_data(k,3),line_data(k,3))+1/line_data(k,4)+0.5*line_data(k,6);
end

Y_bus_Amplitude=zeros(NO_bus,NO_bus);
Y_bus_Phase=zeros(NO_bus,NO_bus);
for i=1:length(Y_bus(:,1))
    for j=1:length(Y_bus(1,:))
        Y_bus_Amplitude(i,j)=abs(Y_bus(i,j));
        Y_bus_Phase(i,j)=angle(Y_bus(i,j))*180/pi;
    end
end

disp('Y-Bus:');
disp(Y_bus);
disp('-------------------------------')
disp('Y-Bus Amplitude:');
disp(Y_bus_Amplitude)
disp('-------------------------------')
disp('Y-Bus Phase:');
disp(Y_bus_Phase)