clear;clc;close all;

MVA_base=100.0; %Defining the Base-MVA
[linedata,busdata,tolerence,nPV,nLB,lPV] = data(); %Calling the function containing the input data

fb=linedata(:,1);  % Storing the from-bus numbers
tb=linedata(:,2);  % Storing the to-bus numbers
r=linedata(:,3);   % Storing the resistance(s)
x=linedata(:,4);   % Storing the reactance(s)
b=linedata(:,5);   % Storing the half-line charging(shunt-admittance)
a=linedata(:,6);   % Storing the off-nominal trans-ratio

bus_type=(busdata(:,2)); % Storing the bus-type(s)
v_bus_initial=(busdata(:,3)); % Storing the initial bus-voltage(s) in (p.u.)
P_gen=((busdata(:,5))*(MVA_base)); % Storing the active power generated at bus(s)
Q_gen=((busdata(:,6))*(MVA_base)); % Storing the reactive power generated at bus(s)
S_gen=((P_gen)+(1i)*(Q_gen)); % Storing the complex power generated at bus(s)
P_load=((busdata(:,7))*(MVA_base)); % Storing the active power at load(s) at bus(s)
Q_load=((busdata(:,8))*(MVA_base)); % Storing the reactive power at load(s) at bus(s)
S_load=((P_load)+(1i)*(Q_load)); % Storing the complex power at load(s) at bus(s)
Q_min=((busdata(:,9))*(MVA_base)); % Storing the minimum Q-range of the PV-bus(s)
Q_max=((busdata(:,10))*(MVA_base)); % Storing the maximum Q-range of the PV-bus(s)
B_shunt=((busdata(:,11))); % Storing the data corresponding to the static shunt capacitance
z_elementary=((r)+(1i)*(x)); % Calculating the 'z'
b_elementary=((1i)*(b)); % Calculating the 'b'
nbus = max(max(fb),max(tb));    % no. of buses
nbranch = length(fb);           % no. of branches
z=zeros(nbus,nbus); % Initialising the elementary [z]
b=zeros(nbus,nbus); % Initialising the elementary [b]
Ybus=zeros(nbus,nbus); % Initialising the elementary [Y] (Bus-admittance matrix)
tolerence_checker=1; % Initialising the 'tolerence_checker' as '1'
iteration=0; % Initialising the 'iteration' as '0'
V_new=v_bus_initial; % Initialising the 'V_new[]' as 'V_initial[]'
v_scheduled=v_bus_initial; % Initialising the 'v_scheduled[]' as 'V_initial[]' (to get the scheduled voltages at the PV-bus(s))
V_new_accelerated=zeros(1,nbus); % Initialising the 'V_new_accelerated[]'
V_new_del=zeros(1,nbus); % Initialising the 'v_new_del[]' (to get the difference(s) of bus-voltage(s) of two(02) consecutive iteration(s))
difference=zeros(1,nbus); % Iniialising the 'difference[]'
real_diff=zeros(1,nbus); % Initialising the 'real_diff[]' (to store the real part of the difference)
imag_diff=zeros(1,nbus); % Initialising the 'imag_diff[]' (to store the imaginary part of the difference)
delta=zeros(1,nbus); % Initialising the 'delta[]' (for getting the angle at PV-bus(s))
E_new=zeros(1,nbus); % Initialising the 'E_new[]' (to store the real part of the voltage at PV-bus)
F_new=zeros(1,nbus); % Initialising the 'F_new[]' (to store the imaginary part of the voltage at PV-bus)
Q_intermediate=zeros(1,nbus); % Initialising the 'Q_intermediate'
Q_final=zeros(1,nbus); % Initialising 'Q_final[]'
complex_flow_line=zeros(1,nbranch); % Initialising 'complex_flow_line[]'
line_flows=zeros(nbus,nbus); % Initialising 'line_flows[]'
active_flow_line=zeros(1,nbranch); % Initialising 'active_flow_line[]'
reactive_flow_line=zeros(1,nbranch); % Initialising 'reactive_flow_line[]'
bus_power_injection=zeros(1,nbus); % Initialising 'bus_power_injection[]'
bus_power_mismatch=zeros(1,nbus); % Initialising 'bus_power_mismatch[]'
line_loss=zeros(nbus,nbus); % Initialising 'line_loss[]'
flow_count=1; % Initialising the 'flow_count' as (1) //(for tracking the total no. of lines)
sum_line_loss=((0.0)+(1i)*(0.0)); % Initialising 'sum_line_loss' as '0'
sum=zeros(1,nbus); % Initialising the 'sum' (used in calculating the digaonal [Ybus] elements)
shunt_fb_onr=zeros(1,nbranch); % storing the ((a^2)/(1-a)) as seen from the FB(From Bus)
shunt_tb_onr=zeros(1,nbranch); % storing the ((a)/(a-1)) as seen from the TB(To Bus)
P_injected_sum=zeros(nbus,1); % Initialising 'P_injected_sum[]' for intermediate calculation(s) of injected (P)
Q_injected_sum=zeros(nbus,1); % Initialising 'Q_injected_sum[]' for intermediate calculation(s) of injected (Q)
P_injected_bus=zeros(nbus,1); % for storing the intermediate 'active power injection(s)' at different bus(s)
Q_injected_bus=zeros(nbus,1); % for storing the intermediate 'reactive power injection(s)' at different bus(s)
partial_P_delta=zeros(nbus-1,nbus-1); % Initialsing 'partial_P_delta[]'corresponding to the [J11]
partial_Q_delta=zeros(nbus-nPV-1,nbus-1); % Initialsing 'partial_Q_delta[]'corresponding to the [J21]
partial_P_vol_mag=zeros(nbus-1,nbus-nPV-1); % Initialising 'partial_P_vol_mag[]'corresponding to the [J12]
partial_Q_vol_mag=zeros(nbus-nPV-1,nbus-nPV-1); % Initialising 'partial_Q_vol_mag[]'corresponding to the [J12]
J=zeros(((2*(nbus-1))-nPV),((2*(nbus-1))-nPV)); % Initialising 'J[]' i.e. THE COMPLETE JACOBIAN MATRIX
inj_active_pow_mismatch_vector=zeros(nbus-1,1); % Initialising the 'inj_active_pow_mismatch_vector[]'
inj_reactive_pow_mismatch_vector=zeros(nbus-nPV-1,1); % Initialising the 'inj_reactive_pow_mismatch_vector[]'
inj_pow_mismatch_vector=zeros(((2*(nbus-1))-nPV),1); % Initialising the 'inj_pow_mismatch_vector[]'
correction_vector=zeros(((2*(nbus-1))-nPV),1); % Initialising the 'correction_vector[]'
correction_voltage_angle=zeros((nbus-1),1); % Initialising the 'correction_voltage_angle[]'
correction_voltage_magnitude=zeros((nbus-1-nPV),1); % Initialising the 'correction_voltage_magnitude[]'
mismatch_active_vector_element_count=1; % Initialising the 'mismatch_active_vector_element_count' as (1)
mismatch_reactive_vector_element_count=1; % Initialising the 'mismatch_reactive_vector_element_count' as (1)
mismatch_vector_element_count=0;% Initialising the 'mismatch_active_vector_element_count' as (0)
real_mismatch=zeros(nbus-1,1); 
imag_mismatch=zeros(nbus-1-nPV,1); 

for u=1:((2*(nbus-1))-nPV)
    correction_vector(u)=1.0; % Initialising the correction vector element(s) as (1.0); so that loop can be started
end

% Forming the elementary z-matrix & b-matrix
for u=1:nbranch
    z(fb(u),tb(u))=z_elementary(u); % Storing the mutual element(s) (Z(i,j))
    z(tb(u),fb(u))=z(fb(u),tb(u)); % Storing the similar element(s) in (Z(j,i))
    b(fb(u),tb(u))=b_elementary(u); % Storing the mutual element(s) (B(i,j))
    b(tb(u),fb(u))=b(fb(u),tb(u)); % Storing the similar element(s) in (B(j,i))
end

% Modification(s) in the element(s) of 'z' & 'b' due to OFF-NOMINAL TRANS RATIO
for u=1:nbranch
    if((a(u,1))~=1.0)
        shunt_fb_onr(1,u)=(((a(u,1))^(2))/(1-(a(u,1)))); % Calculating the (a^2/(1-a))
        b(fb(u),tb(u))=(1/((shunt_fb_onr(1,u))*(z(fb(u),tb(u)))))+(b(fb(u),tb(u))); % Modifying the element 'b' matrix w.r.t. 'fb'
        shunt_tb_onr(1,u)=((a(u,1))/((a(u,1))-1)); % Calculating the (a/(a-1))
        b(tb(u),fb(u))=(1/((shunt_tb_onr(1,u))*(z(fb(u),tb(u))))); % Modifying the element 'b' matrix w.r.t. 'tb'
        z(fb(u),tb(u))=z(fb(u),tb(u))*(a(u,1)); % Modifying the 'z' matrix
        z(tb(u),fb(u))=z(fb(u),tb(u)); % Storing the similar element(s) in (Z(j,i))        
    end
end

% Including the effect(s) of static shunt-capacitance
for u=1:nbus
    if(B_shunt(u)~=0.0)
        sum(1,u)=B_shunt(u); % Updating the 'sum(1,u)' with the data for static shunt capacitance
    end
end

%%  -------------------------- STEP-1 - CALCULATION OF BUS-ADMITTANCE MATRIX --------------------------
for u=1:nbus
    for j=1:nbus
      if(z(u,j)==0.0)
          Ybus(u,j)=0.0; % No connection between (u) & (j)
      else
          Ybus(u,j)=-(1/z(u,j)); % Calculating the mutual-admittances
      end
    end
end

for u=1:nbus
    for j=1:nbus
      sum(1,u)=sum(1,u)+b(u,j)-Ybus(u,j);
      if(j==nbus)
          Ybus(u,u)=sum(1,u); % Calculating the self-admittances
      end
    end
end

fprintf('THE BUS-ADMITTANCE IS GIVEN BELOW\n'); %DISPLAYING THE RESULTS GOT FROM STEP-1
disp(Ybus);
Gbus=real(Ybus); % Generating the conducatance matrix[G] by taking the real part of the [Ybus] element(s); (y=g+jb)
Bbus=imag((+1)*(Ybus)); % Generating the susceptance matrix[B] by taking the imaginary part of the [Ybus] element(s); (y=g+jb)

% ----------------------------------------------END OF STEP-1-------------------------------------------
%%
while((tolerence_checker>0)&&(iteration<10))   
    mismatch_vector_element_count=0;% Resetting the 'mismatch_active_vector_element_count' as (0)
    mismatch_active_vector_element_count=1; % Resetting the 'mismatch_active_vector_element_count' as (1)
    mismatch_reactive_vector_element_count=1; % Resetting the 'mismatch_reactive_vector_element_count' as (1)
    P_injected_sum=zeros(nbus,1); % Resetting 'P_injected_sum[]' for intermediate calculation(s) of injected (P)
    Q_injected_sum=zeros(nbus,1); % Resetting 'Q_injected_sum[]' for intermediate calculation(s) of injected (Q)
    tolerence_checker=0; % resetting the 'tolerence_checker' to (0)
    
    %% --------------------------------------------STARTING OF STEP-2----------------------------------------
    % CALCULATING THE ACTIVE POWER INJECTION(s) AND REACTIVE POWER INJECTION(s) AT DIFFEENT BUS(s) AND
    % THE MISMATCH VECTOR FOR THE ACTIVE POWER INJECTION(s) & REACTIVE POWER INJECTION(s) 
    % (ACTIVE POWER INJECTION MISMATCH=(SCHEDULED ACTIVE POWER INJECTION-CALCULATED ACTIVE POWER INJECTION))
    % (REACTIVE POWER INJECTION MISMATCH=(SCHEDULED REACTIVE POWER INJECTION-CALCULATED REACTIVE POWER INJECTION))
    %--------------------------------------------------------------------------------------------------------
    P_injected_scheduled=((P_gen-P_load)/(MVA_base)); % calculating the scheduled injected active power at each bus
    Q_injected_scheduled=((Q_gen-Q_load)/(MVA_base)); % calculating the scheduled injected reactive power at each bus

    for u=1:nbus
        for j=1:nbus
            if((u~=j)&&(abs(Ybus(u,j)))~=0.0)
                P_injected_sum(u,1)=((P_injected_sum(u,1))+(((abs((V_new(u,1))*(V_new(j,1))*(Ybus(u,j))))*(cos((angle(Ybus(u,j)))+(angle(V_new(j,1)))-(angle(V_new(u,1)))))))); % calculating the mutual sumation part
            end
            if((u~=j)&&((abs(Ybus(u,j)))~=0.0)&&(bus_type(u)~=2))
                Q_injected_sum(u,1)=((Q_injected_sum(u,1))+(((abs((V_new(u,1))*(V_new(j,1))*(Ybus(u,j))))*(sin((angle(Ybus(u,j)))+(angle(V_new(j,1)))-(angle(V_new(u,1)))))))); % calculating the mutual sumation part
            end
            if(j==nbus)
                P_injected_bus(u,1)=((((abs(V_new(u,1)))^(2))*(Gbus(u,u)))+(P_injected_sum(u,1))); % calculating the injecetd 'P' at bus-(u)
            end
            if((j==nbus)&&(bus_type(u)~=2))
                Q_injected_bus(u,1)=(-((((abs(V_new(u,1)))^(2))*(Bbus(u,u)))+(Q_injected_sum(u,1)))); % calculating the injecetd 'Q' at bus-(u)
            end
        end
    end
    
    for u=1:nbus
        if(bus_type(u)~=1)
            inj_active_pow_mismatch_vector(mismatch_active_vector_element_count,1)=((P_injected_scheduled(u,1))-(P_injected_bus(u,1))); % calculating the mismatch vector for active power injecttion
            mismatch_active_vector_element_count=mismatch_active_vector_element_count+1; % updating the value of 'mismatch_vector_element_count'
        end
        if((bus_type(u)~=1)&&(bus_type(u)~=2))
            inj_reactive_pow_mismatch_vector(mismatch_reactive_vector_element_count,1)=((Q_injected_scheduled(u,1))-(Q_injected_bus(u,1))); % calculating the mismatch vector for reactive power injecttion
            mismatch_reactive_vector_element_count=mismatch_reactive_vector_element_count+1; % updating the value of 'mismatch_vector_element_count'
        end
    end
    
    for u=2:nbus
        if(mismatch_vector_element_count<=((mismatch_active_vector_element_count-1)+(mismatch_reactive_vector_element_count-1)))
            inj_pow_mismatch_vector((u-1),1)=inj_active_pow_mismatch_vector(u-1,1); % storing the mismatch in the active power
            mismatch_vector_element_count=mismatch_vector_element_count+1; % updating the 'mismatch_vector_element_count'
        end
        if((mismatch_vector_element_count<((mismatch_active_vector_element_count-1)+(mismatch_reactive_vector_element_count-1)))&&((u-1)<=(nbus-1-nPV)))
            inj_pow_mismatch_vector((u+nbus-2),1)=inj_reactive_pow_mismatch_vector(u-1,1); % storing the mismatch in the reactive power
            mismatch_vector_element_count=mismatch_vector_element_count+1; % updating the 'mismatch_vector_element_count'
        end
    end
    fprintf('\nThe mismatch-vector is :\n');
    disp(inj_pow_mismatch_vector); % displaying the 'inj_pow_mismatch_vector[]'
    
    for u=1:nbus-1
        real_mismatch(u,1)=inj_pow_mismatch_vector(u,1); % storing the real-power mismatch(s)
        if((u+nbus-1)<=((2*(nbus-1))-nPV))
            imag_mismatch(u,1)=inj_pow_mismatch_vector(u+nbus-1,1); % storing the imaginary-power mismatch(s)
        end
    end
    
    for u=1:((2*(nbus-1))-nPV)
        if((abs(inj_pow_mismatch_vector(u,1)))>(tolerence))
            tolerence_checker=tolerence_checker+1;
        end
    end
    %----------------------------------------------END OF STEP-2-------------------------------------------
    
    %% --------------------------------------------STARTING OF STEP-3----------------------------------------
    % STEP-3: CALCULATES THE [J] OR THE JACOBIAN MATRIX ([J]=[[J11] [J12] : [J21] [J22]])
    % UNDER THIS STEP SUB-STEP HAS BEEN PRFORMED FOR CALCULATING THE [J11], [J12], [J21], [J22] IN INDIVIDUAL
    %--------------------------------------------------------------------------------------------------------
    % STEP-(3.a): CALCULATING THE [J11]
    %--------------------------------------------------------------------------------------------------------
    sum_pv=0; % initialising 'sum_pv' for getting the [J] elements dependent on PV-bus (Q)
    for u=1:nbus-1
        for j=1:nbus-1
            if((u+1)~=(j+1))
                partial_P_delta(u,j)=(-((abs((V_new(u+1,1))*(V_new(j+1,1))*(Ybus(u+1,j+1))))*(sin((angle(Ybus(u+1,j+1)))+(angle(V_new(j+1,1)))-(angle(V_new(u+1,1))))))); % calculating the off-diagonal element(s)
            else
                if((bus_type(u+1))~=2)
                    partial_P_delta(u,j)=(-((((abs(V_new(u+1,1)))^(2))*(Bbus(u+1,u+1)))+(Q_injected_bus(u+1,1)))); % calculating the diagonal element(s)
                else
                    for k=1:nbus
                        if(((u+1)~=(k))&&(abs(Ybus(u+1,k))~=0.0))
                            %sum_pv=sum_pv-partial_P_delta(u-1,k-1);
                            sum_pv=sum_pv+((abs((V_new(u+1,1))*(V_new(k,1))*(Ybus(u+1,k)))*(sin((angle(Ybus(u+1,k))+(angle(V_new(k,1)))-(angle(V_new(u+1,1))))))));
                        end
                    end
                    partial_P_delta(u,j)=sum_pv; % calculating the (partial_P_delta(3,3)) for the PV-bus
                    sum_pv=0; % resetting the 'sum_pv' to (0)
                end
            end
        end
    end
    fprintf('\n The [J11] is : \n');
    disp(partial_P_delta); % diplaying the [J11]
    %--------------------------------------------------------------------------------------------------------
    % STEP-(3.b): CALCULATING THE [J21]
    %--------------------------------------------------------------------------------------------------------
    m=1;n=1;element_count=0;
    for u=2:nbus
        for j=2:nbus
            if((m~=n)&&((bus_type(u))~=2)&&(u~=j))
                partial_Q_delta(m,n)=(-((abs((V_new(u,1))*(V_new(j,1))*(Ybus(u,j))))*(cos((angle(Ybus(u,j)))+(angle(V_new(j,1)))-(angle(V_new(u,1))))))); % calculating the off-diagonal element(s)
                n=n+1;
                element_count=element_count+1;
            elseif((m~=n)&&((bus_type(u))~=2)&&(u==j))
                partial_Q_delta(m,n)=((P_injected_bus(u,1))-(((abs(V_new(u,1)))^(2))*(Gbus(u,u))));
                n=n+1;
                element_count=element_count+1;
            elseif((m==n)&&((bus_type(u))~=2)&&(u~=j))
                partial_Q_delta(m,n)=(-((abs((V_new(u,1))*(V_new(j,1))*(Ybus(u,j))))*(cos((angle(Ybus(u,j)))+(angle(V_new(j,1)))-(angle(V_new(u,1))))))); % calculating the off-diagonal element(s)
                n=n+1;
                element_count=element_count+1;
            elseif((m==n)&&((bus_type(u))~=2)&&(u==j))
                partial_Q_delta(m,n)=((P_injected_bus(u,1))-(((abs(V_new(u,1)))^(2))*(Gbus(u,u))));
                n=n+1;
                element_count=element_count+1;
            end
        end
        if((j==nbus)&&(element_count>0))
            m=m+1;n=1;element_count=0;
        end
    end
    fprintf('\n The [J21] is : \n');
    disp(partial_Q_delta); % diplaying the [J21]
    %--------------------------------------------------------------------------------------------------------
    % STEP-(3.c): CALCULATING THE [J12]
    %--------------------------------------------------------------------------------------------------------
    m=1;n=1;element_count=0;
    for u=2:nbus
        for j=2:nbus
            if((m==n)&&(bus_type(j)~=2)&&(u~=j)&&(bus_type(u)~=2))
                %partial_P_vol_mag(m,n)=(-(partial_Q_delta(u-nPV-1,j-1))); % calculating the off-diagonal element(s)
                partial_P_vol_mag(m,n)=((abs((V_new(u,1))*(V_new(j,1))*(Ybus(u,j))))*(cos((angle(Ybus(u,j)))+(angle(V_new(j,1)))-(angle(V_new(u,1))))));
                n=n+1;
                element_count=element_count+1;
            elseif((m==n)&&(bus_type(j)~=2)&&(u==j)&&(bus_type(u)~=2))
                partial_P_vol_mag(m,n)=((P_injected_bus(u,1))+(((abs(V_new(u,1)))^(2))*(Gbus(u,u))));
                n=n+1;
                element_count=element_count+1;
            elseif((m==n)&&(bus_type(j)~=2)&&(u~=j)&&(bus_type(u)==2))
                partial_P_vol_mag(m,n)=((abs((V_new(u,1))*(V_new(j,1))*(Ybus(u,j))))*(cos((angle(Ybus(u,j)))+(angle(V_new(j,1)))-(angle(V_new(u,1))))));
                n=n+1;
                element_count=element_count+1;
            elseif((m~=n)&&(bus_type(j)~=2)&&(u~=j)&&(bus_type(u)~=2))
                partial_P_vol_mag(m,n)=((abs((V_new(u,1))*(V_new(j,1))*(Ybus(u,j))))*(cos((angle(Ybus(u,j)))+(angle(V_new(j,1)))-(angle(V_new(u,1))))));
                n=n+1;
                element_count=element_count+1;
            elseif((m~=n)&&(bus_type(j)~=2)&&(u==j)&&(bus_type(u)~=2))
                partial_P_vol_mag(m,n)=((P_injected_bus(u,1))+(((abs(V_new(u,1)))^(2))*(Gbus(u,u))));
                n=n+1;
                element_count=element_count+1;
            elseif((m~=n)&&(bus_type(j)~=2)&&(u~=j)&&(bus_type(u)==2))
                partial_P_vol_mag(m,n)=((abs((V_new(u,1))*(V_new(j,1))*(Ybus(u,j))))*(cos((angle(Ybus(u,j)))+(angle(V_new(j,1)))-(angle(V_new(u,1))))));
                n=n+1;
                element_count=element_count+1;
            end
        end
        if((j==nbus)&&(element_count>0))
            m=m+1;n=1;element_count=0;
        end
    end
    fprintf('\n The [J12] is : \n');
    disp(partial_P_vol_mag); % diplaying the [J12]
    %--------------------------------------------------------------------------------------------------------
    % STEP-(3.d): CALCULATING THE [J22]
    %--------------------------------------------------------------------------------------------------------
    m=1;n=1;element_count=0;
    for u=2:nbus
        for j=2:nbus
            if((m~=n)&&(u~=j)&&((bus_type(u))~=2)&&((bus_type(j))~=2))
                partial_Q_vol_mag(m,n)=(-((abs((V_new(u,1))*(V_new(j,1))*(Ybus(u,j))))*(sin((angle(Ybus(u,j)))+(angle(V_new(j,1)))-(angle(V_new(u,1))))))); 
                n=n+1;
                element_count=element_count+1;
            elseif((m~=n)&&(u==j)&&((bus_type(u))~=2)&&((bus_type(j))~=2))
                partial_Q_vol_mag(m,n)=((Q_injected_bus(u,1))-(((abs(V_new(u,1)))^(2))*(Bbus(u,u))));
                n=n+1;
                element_count=element_count+1;
            elseif((m==n)&&(u~=j)&&((bus_type(u))~=2)&&((bus_type(j))~=2))
                %partial_Q_vol_mag(m,n)=partial_P_delta(u-nPV-1,j-nPV-1);
                partial_Q_vol_mag(m,n)=(-((abs((V_new(u,1))*(V_new(j,1))*(Ybus(u,j))))*(sin((angle(Ybus(u,j)))+(angle(V_new(j,1)))-(angle(V_new(u,1))))))); 
                n=n+1;
                element_count=element_count+1;
            elseif((m==n)&&(u==j)&&((bus_type(u))~=2)&&((bus_type(j))~=2))
                partial_Q_vol_mag(m,n)=((Q_injected_bus(u,1))-(((abs(V_new(u,1)))^(2))*(Bbus(u,u)))); 
                n=n+1;
                element_count=element_count+1;
            end
        end
        if((j==nbus)&&(element_count>0))
            m=m+1;n=1;element_count=0;
        end
    end
    fprintf('\n The [J22] is : \n');
    disp(partial_Q_vol_mag); % diplaying the [J22]
    %--------------------------------------------------------------------------------------------------------
    % STEP-(3.e): CALCULATING THE COMPLETE [J]
    %--------------------------------------------------------------------------------------------------------
    J=[partial_P_delta partial_P_vol_mag ; partial_Q_delta partial_Q_vol_mag];
    fprintf('\nThe complete JACOBIAN matrix is : \n');
    disp(J);
    %----------------------------------------------END OF STEP-3-------------------------------------------
    
    %% --------------------------------------------STARTING OF STEP-4----------------------------------------
    % STEP-4: CALCULATING THE CORRECTION VECTOR BY ((inv(J))*(MISMATCH-VECTOR)) & THE UPDATED VALUES OF THE
    % STATE VARIABLES i.e. (|v_i|,DELTA_i)
    %--------------------------------------------------------------------------------------------------------
    for u=1:(2*(nbus-1))
        correction_vector(u,1)=0.0; % Initialising the 'correction_vector' as (0.0)
    end
    correction_vector=(inv(J))*(inj_pow_mismatch_vector); % calculating the 'correction_vector[]'
    fprintf('\n Inverse of the [J] matrix : \n');
    disp(inv(J)); % displaying the inverse of the [J] matrix
    for u=1:(nbus-1)
        correction_voltage_angle(u,1)=correction_vector(u,1); % storing the correction(s) in the voltage angle(s)
        if(u<=(nbus-1-nPV))
            correction_voltage_magnitude(u,1)=correction_vector((u+nbus-1),1); % storing the correction(s) in the voltage angle(s)
        end
    end
    correction_voltage_magnitude_count=1; % initialising the 'correction_voltage_magnitude_count' as (1)
    for u=1:(nbus-1)
        voltage_angle_updated=angle((V_new(u+1,1)))+(correction_voltage_angle(u,1));  % calculating the updated voltage-angle
        if(bus_type(u+1)~=2)
            voltage_magnitude_updated=abs((V_new(u+1,1)))+((correction_voltage_magnitude(correction_voltage_magnitude_count,1))*(abs((V_new(u+1,1))))); % calculating the updated voltage-magnitude
            correction_voltage_magnitude_count=correction_voltage_magnitude_count+1; % updating 'correction_voltage_magnitude_count' by (1)
        end
        if(bus_type(u+1)~=2)
            V_new(u+1,1)=voltage_magnitude_updated*((cos(voltage_angle_updated))+(sin(voltage_angle_updated)*(1i))); % calculating the updated voltage
        end
        if(bus_type(u+1)==2)
            V_new(u+1,1)=abs(V_new(u+1,1))*((cos(voltage_angle_updated))+(sin(voltage_angle_updated)*(1i))); % calculating the updated voltage
        end
    end
    %--------------------------------------------------------------------------------------------------------
    iteration=iteration+1; % updating the value of iteration-count by (1)
    fprintf('\n The updated state variables after the (%d)-th iteration is :\n',iteration);
    fprintf('    BUS        RECTANGULAR-FORM                   POLAR-FORM\n');
    fprintf('------------------------------------------------------------------------\n');
    for u=1:nbus
        fprintf('    %d      (%f)+j(%f)      (%f)at an angle(%f)deg.\n',u,real(V_new(u,:)),imag(V_new(u,:)),abs(V_new(u,:)),((180/pi)*(angle(V_new(u,:)))));

%         figure(u);
%         subplot(2,1,1);
%         plot(abs(V_new(u,:)), '-o');
%         xlabel('Iteration');
%         ylabel('Voltage amplitude (p.u.)');
% 
%         subplot(2,1,2);
%         plot(((180/pi)*(angle(V_new(u,:)))), '-o r');
%         xlabel('Iteration');
%         ylabel('Voltage angle (degree)'); 
    end
end

%% STEP-4 - CALCULATING THE LINE-FLOW(s) & THE BUS-INJECTION(s) & THE BUS-POWER  MISMATCH(s) & THE LINE-LOSS(s)
%------------------------------------------------------------------------------------------------------------
fprintf('The Line-flows are as follows : \n');
fprintf('Line-code      Active-flow(p.u.)      Reactive-flow(p.u.)\n');
fprintf('------------------------------------------------------------\n');
for u=1:nbus
   for j=1:nbus
       if((u~=j)&&(Ybus(u,j))~=0.0)
           complex_flow_line(1,flow_count)=((conj(V_new(u,1))*((V_new(u,1))-(V_new(j,1))))*(-Ybus(u,j)))+(conj(V_new(u,1))*(V_new(u,1))*(b(u,j))); % Calculating the line-flows
           line_flows(u,j)=conj(complex_flow_line(1,flow_count)); % Storing the power flow in the line-flow matrix
           active_flow_line(1,flow_count)=real(complex_flow_line(1,flow_count)); % P.U. active power flow from (u->j)
           reactive_flow_line(1,flow_count)=(-(imag(complex_flow_line(1,flow_count)))); % P.U. reactive power flow from (u->j)
           fprintf('  %d->%d',u,j); % Printing the line-code
           fprintf('            %f               %f\n',active_flow_line(1,flow_count),reactive_flow_line(1,flow_count)); % Printing the active & reactive power flows
           bus_power_injection(1,u)=bus_power_injection(1,u)+conj(complex_flow_line(1,flow_count)); % Calculating the bus-power-injection(s)
           bus_power_mismatch(1,u)=((S_gen(u,1)-S_load(u,1))/MVA_base)-(bus_power_injection(1,u)); % Calculating the bus-power-mismach
           flow_count=flow_count+1; % Updating the flow_count by (1)
       end
   end
end
fprintf('The bus-power injection(s) are :\n');
fprintf('Bus-code        Power-injection(p.u.)\n');
fprintf('----------------------------------------\n');
for u=1:nbus
    fprintf('  %d             (%f)+j(%f)\n',u,real(bus_power_injection(u)),imag(bus_power_injection(u))); % Displaying the bus-power injections
end
fprintf('The bus-power mismatch(s) are :\n');
fprintf('Bus-code        Bus-power-mismatch(p.u.)\n');
fprintf('----------------------------------------\n');
for u=2:nbus
    fprintf('  %d             (%f)+j(%f)\n',u,real(bus_power_mismatch(u)),imag(bus_power_mismatch(u))); % Displaying the bus-power injections
end
for u=1:nbus
    for j=1:nbus
        if((u<j)&&(abs(line_flows(u,j))~=0.0))
            line_loss(u,j)=line_flows(u,j)+line_flows(j,u); % Calculating the individual line-loss
            real_line_loss=abs(real(line_loss(u,j))); % Absolute value of the active-line-loss
            imag_line_loss=abs(imag(line_loss(u,j))); % Absolute value of the reactive-line-loss
            line_loss(u,j)=(real_line_loss)+(imag_line_loss)*(1i);
            sum_line_loss=sum_line_loss+line_loss(u,j); % Calculating the total line-loss
        end
    end
end
fprintf('Individual line-loss is as follows = \n');
fprintf('Line-code            Line-loss  \n');
fprintf('-----------------------------------\n');
for u=1:nbus
    for j=1:nbus
        if((u<j)&&(abs(line_flows(u,j))~=0.0))
            fprintf('  %d->%d      (%f)+j(%f)\n',u,j,real(line_loss(u,j)),imag(line_loss(u,j)));
        end
    end
end
fprintf('Summation of all the losses = (%f)+j(%f)\n',real(sum_line_loss),imag(sum_line_loss)); % Displaying the summation of all the line-losses