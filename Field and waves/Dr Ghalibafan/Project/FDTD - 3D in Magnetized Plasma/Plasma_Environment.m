function[f0,Ne,B0,ve,dt,Nx,Ny,Nz,x,y,z,dx,dy,dz,e0,u0,wpe,wce_x,wce_y,wce_z] =...
    Plasma_Environment()
    
    % Simulation Parameters
    n0  = 1e10;                     % [m^-3]   Background Plasma Density
    r0  = .5;                       % [m]      Radius of Meteor
    L0xz  = 15*r0;                  % [m]      Length Along X,Z Dimension
    L0y = 3*L0xz;                   % [m]      Length Along Y Dimension
    Nx  = 160;                      % [NoUnit] Number of Points Along X
    Ny  = Nx*L0y/L0xz-(L0y/L0xz-1); % [NoUnit] Number of Points Along Y
    Nz  = Nx;                       % [NoUnit] Number of Points Along z

    % Meteor Parameters
    ne  = 3e14;    % [m^3]    Electron Density
    Te  = 200;     % [K]      Electron Temperature 
    B0  = 0.35e-4; % [Tesla]  Backgroud Magnetic Field
    ui  = 16;      % [NoUnit] Ion Mass Number

    % Constants
    e0  = 8.8541878128e-12; % [F/m]    Permittivity Free Space
    u0  = 1.25663706212e-6; % [H/m]    Permeability Free Space
    c0  = (e0*u0)^-.5;      % [m/s]    Speed of Light
    q   = 1.602176634e-19;  % [Columb] Fundamental Charge
    me  = 9.10938356e-31;   % [kg]     Electron Mass
    mp  = 1.6726219e-27;    % [kg]     Proton Mass
    mi  = ui.*mp;           % [kg]     Ion Mass

    % Build Meteor and Plasma Space
    x   = linspace(-L0xz/2,L0xz/2,Nx);  % [m] X Dimension
    y   = linspace(-L0y/2,L0y/2,Ny);    % [m] Y Dimension
    z   = permute(x,[1 3 2]);           % [m] Z Dimension
    dx = abs(x(1)-x(2));                % [m] delta X
    dy = abs(y(1)-y(2));                % [m] delta Y
    dz = abs(z(1)-z(2));                % [m] delta Z

    % Gaussian Function for Meteor
    X   = exp(-(x/r0).^2)';           % [NoUnit] X Dimension 
    Y   = exp(-((y-L0y/4)/r0).^2);    % [NoUnit] Y Dimension 
    Z   = exp(-(z/r0).^2);            % [NoUnit] Z Dimension 
    Ne  = (ne-n0).*X.*Y.*Z;           % [m^-3] Build Meteor Density 
    Ne  = Ne+n0*ones(size(Ne));       % [m^-3] Add in Background Density

    % Plasma Parameters
    TeV = Te./11604.525;              % [eV]     Ele Temperature eV
    ven = 6e4;                        % [s^-1]   Ele Neu Collision Frequency
    vee = 6.6e-11*Ne/TeV^1.5;         % [s^-1]   Ele Ele Collision Frequency
    vei = vee*(mi/me)^.5;             % [s^-1]   Ele Ion Collision Frequency
    ve = ven+vei+vee;                 % [s^-1]   Tot Ele Collision Frequency

    % Plasma Frequencies
    wpe = ((q^2*Ne)./(e0*me)).^.5;    % [rad/s]  Ele Plasma Frequency
    wce = (q*B0)./(me);               % [rad/s]  Ele Cyclotron Frequency

    % Plasma Parameters (Ez nodes)
    ve    = ve(1:end-1,1:end-1,:);    % [s^-1]  Tot Ele Collision Frequency
    wpe   = wpe(1:end-1,1:end-1,:);   % [rad/s] Plasma Frequency
    wce_x = wce;                      % [rad/s] X Vector Ang Cycl Frequency
    wce_y = 0;                        % [rad/s] Y Vector Ang Cycl Frequency
    wce_z = 0;                        % [rad/s] Z Vector Ang Cycl Frequency

    % Simulation time Limit
    dt     = (dx^-2+dy^-2+dz^-2)^-.5/c0; % Courrant Condition 

    % Number of Points Per Shortest Wavelength
    %(Assumes Gaussian Pulse where center is at the plasma frequency)
    f0     = max(wpe/2/pi,[],"all");
    lambda = c0/(2*f0);    % [m] freespace wavelength
    P      = lambda/dx;    % [NoUnit] Points per wavelength
    
    % Display points per wavelength
    [strcat(num2str(P)," points per shortest wavelength");...
        strcat(num2str(f0/1e6),"[MHz] Max plasma frequency and center frequency of sin-modulated Gaussian pulse")]
end