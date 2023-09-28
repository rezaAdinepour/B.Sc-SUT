clear;

baseDirectory = 'C:\Users\r3z4\OneDrive\Desktop\Field and waves Project\';

% Define Simulation Based off Source and Wavelength
f0 = 1e6;   % Frequency of Source        [Hertz]
Lf = 10;    % Divisions per Wavelength   [unitless]
Lx = 20;    % Wavelengths x,y            [unitless]
nt = 500;  % Number of time steps       [unitless]

% Spatial and Temporal System
e0 = 8.854*10^-12;  % Permittivity of vacuum [farad/meter]
u0 = 4*pi*10^-7;    % Permeability of vacuum [henry/meter]
c0 = 1/(e0*u0)^.5;  % Speed of light         [meter/second]
L0  = c0/f0;        % Freespace Wavelength   [meter]
t0  = 1/f0;         % Source Period          [second]
Nx = Lx*Lf;                     % Points in x             [unitless]
x  = linspace(0,Lx,Nx+1)*L0;    % x vector                [meter]
dx = x(2);                      % x increment             [meter]
dt = dx/c0*.99;                 % Time step CFL condition [second]

% Initialize Electric and Magnetic Field Vectors
Ex = zeros(1,Nx); % Electric Field   [volt/meter]
Hy = zeros(1,Nx); % Magnetic Field   [Tesla/meter]

% Start loop
for t=1:nt
    % H field loop
    Hy(1:Nx-1) = Hy(1:Nx-1)+dt/(e0*dx)*diff(Ex);
        
    % E field loop
    Ex(2:Nx-1) = Ex(2:Nx-1)+dt/(u0*dx)*diff(Hy(1:Nx-1));
    % Source
    Ex(round(Nx/2)) = Ex(round(Nx/2))+sin(2*pi*f0*dt*t).*exp(-.5*((t-20)/8)^2);
    % Plot
    a = figure(1);
    plot(Ex); axis([1 Nx -2 2]); drawnow;
end
cd(baseDirectory);
close(a)