clear; close all;

baseDirectory = 'C:\Users\r3z4\OneDrive\Desktop\Field and waves Project\';

% Define Simulation Based off Source and Wavelength
f0         = 1e6;             % Frequency of Source        [Hertz]
Lf         = 10;              % Divisions per Wavelength   [unitless]
[Lx,Ly,Lz] = deal(8,8,8);     % Wavelengths x,y,z          [unitless]
nt         = 500;            % Number of time steps       [unitless]

% Simulation Performance
single = 1;  % Use Single Precision | 1 = yes , 0 = no | 
usegpu = 0;  % Use gpuArray         | 1 = yes , 0 = no | 

% Spatial and Temporal System
e0 = 8.854*10^-12;  % Permittivity of vacuum [farad/meter]
u0 = 4*pi*10^-7;    % Permeability of vacuum [henry/meter]
c0 = 1/(e0*u0)^.5;  % Speed of light         [meter/second]
L0  = c0/f0;        % Freespace Wavelength   [meter]
t0  = 1/f0;         % Source Period          [second]
[Nx,Ny,Nz] = deal(Lx*Lf,Ly*Lf,Lz*Lf); % Points in x,y,z         [unitless]
x  = linspace(0,Lx,Nx+1)*L0;          % x vector                [meter]
y  = linspace(0,Ly,Ny+1)*L0;          % y vector                [meter]
z  = linspace(0,Lz,Nz+1)*L0;          % z vector                [meter]
[dx,dy,dz] = deal(x(2),y(2),z(2));    % x,y,z increment         [meter]
dt = (dx^-2+dy^-2+dz^-2)^-.5/c0*.99;  % Time step CFL condition [second]

% Initialize Magnetic and Electric Field Vectors and Coefficients
[Ex] = deal(zeros(Nx,Ny+1,Nz+1)); % Ex cells
[Ey] = deal(zeros(Nx+1,Ny,Nz+1)); % Ey cells
[Ez] = deal(zeros(Nx+1,Ny+1,Nz)); % Ez cells
[Hx] = deal(zeros(Nx+1,Ny,Nz));   % Hx cells
[Hy] = deal(zeros(Nx,Ny+1,Nz));   % Hy cells
[Hz] = deal(zeros(Nx,Ny,Nz+1));   % Hz cells
[udx,udy,udz] = deal(dt/(u0*dx),dt/(u0*dy),dt/(u0*dz)); % H Coeffcients
[edx,edy,edz] = deal(dt/(e0*dx),dt/(e0*dy),dt/(e0*dz)); % E Coeffcients

% Performance Enchancement
if single == 1
    vars2Single();
end

if usegpu == 1
    gpu2Single();  
end

% Start loop
for t = 1:nt
    tic
        % Magnetic Field Update
        Hx = Hx+udz.*diff(Ey,1,3)-udy.*diff(Ez,1,2);
        Hy = Hy+udz.*diff(Ez,1,1)-udx.*diff(Ex,1,3);
        Hz = Hz+udy.*diff(Ex,1,2)-udx.*diff(Ey,1,1);
        
        % Electric Field Update        
        Ex(:,2:end-1,2:end-1) = Ex(:,2:end-1,2:end-1)+...
            edy.*diff(Hz(:,:,2:end-1),1,2)-...
            edz.*diff(Hy(:,2:end-1,:),1,3);
        
        Ey(2:end-1,:,2:end-1) = Ey(2:end-1,:,2:end-1)+...
            edz.*diff(Hx(2:end-1,:,:),1,3)-...
            edx.*diff(Hz(:,:,2:end-1),1,1);
        
        Ez(2:end-1,2:end-1,:) = Ez(2:end-1,2:end-1,:)+...
            edx.*diff(Hy(:,2:end-1,:),1,1)-...
            edy.*diff(Hx(2:end-1,:,:),1,2);    
        
        % Point Source
        Ez(round(Nx/2)+1,round(Ny/2)+1,round(Nz/2)) =...
            sin(2*pi*f0*dt*t)./(1+exp(-.2*(t-60)));
        
        % Plotting
        a = figure(1);
        if t == 1
            [X,Y,Z] = meshgrid(y,x,z(1:end-1)); % for plotting Ez
        end
        
        slice(X,Y,Z,Ez,y(end)/2,x(end)/2,z(end)/2);
        axis([0 y(end) 0 x(end) 0 z(end)]);
        view([1 1 1]); caxis([-.001 .001]); shading interp; drawnow;
    toc
end
cd(baseDirectory);
close(a);