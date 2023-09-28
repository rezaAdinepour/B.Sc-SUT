clear;
close all;

addpath('functions');
graphDefaults();

baseDirectory = 'C:\Users\r3z4\OneDrive\Desktop\Field and waves Project\';

% Simulation Performance
Single = 1; % 0 = Double Precision, 1 = Single Precision
GPU    = 1; % 0 = No Gpu          , 1 = Use Gpu

% Define Simulation Based on Source, Freespace, CFL percentage 
f0   = 1e6;                  % Frequency of Source              [Hertz]
Stn  = 4;                    % Number of "Turn-on" Periods      [unitless]
Scw  = 1;                    % Number of max amplitude periods  [unitless]
Stf  = 4;                    % Number of "Turn off" periods     [unitless]
SO   = 8;                    % Smoothstep Order                 [unitless]
Lf   = 10;                   % Divisions per Wavelength         [unitless]
CF   = 0.99;                 % CFL percentage                   [unitless]
nt   = 2000;                 % Number of time steps             [unitless]
er_x = 6;                    % Relative Permittivity (X)        [unitless]
er_y = 6;                    % Relative Permittivity (Y)        [unitless]
er_z = 6;                    % Relative Permittivity (Z)        [unitless]
[Lx,Ly,Lz] = deal(25,25,25); % Wavelengths in x,y,z direction   [unitless]

% Define ADE PML Boundary Condition Parameters (X,Y,Z)
[PnX,PnY,PnZ]                = deal(14,14,14);       % Each Side PML Cells
[rho_X,rho_Y,rho_Z]          = deal(3.65,3.65,3.65); % Poly Order
[o_ratioX,o_ratioY,o_ratioZ] = deal(1,1,1);          % sigma_Ratio
[kap_maxX,kap_maxY,kap_maxZ] = deal(1,1,1);          % kappa_Max
[a_minX,a_minY,a_minZ]       = deal(0,0,0);          % alpha_Min
[a_maxX,a_maxY,a_maxZ]       = deal(4e-5,4e-5,4e-5); % alpha_Max

% Spatial and Temporal System
e0 = 8.854*10^-12;  % Permittivity of vacuum [farad/meter]
u0 = 4*pi*10^-7;    % Permeability of vacuum [henry/meter]
c0 = 1/(e0*u0)^.5;  % Speed of light         [meter/second]
L0  = c0/f0;        % Freespace Wavelength   [meter]
t0  = 1/f0;         % Source Period          [second]
L0 = L0/max([er_x,er_y,er_z])^.5;     % Smallest Wavelength [meter]
[Nx,Ny,Nz] = deal(Lx*Lf,Ly*Lf,Lz*Lf); % Points in x,y,z     [unitless]
x  = linspace(0,Lx,Nx+1)*L0;          % x vector            [meter]
y  = linspace(0,Ly,Ny+1)*L0;          % y vector            [meter]
z  = linspace(0,Lz,Nz+1)*L0;          % z vector            [meter]
[dx,dy,dz] = deal(x(2),y(2),z(2));    % x,y,z increment     [meter]
dt = (dx^-2+dy^-2+dz^-2)^-.5/c0; % CFL condition                [second]
dt = dt*CF;                      % CFL condition reduced        [second]
T  = t0/dt;                      % Timesteps needs for 1 Cycle  [unitless]
dt = dt*T/ceil(T);               % Time step for Integer time   [second]
T  = round(t0/dt);               % Integer dt Steps for 1 Cycle [unitless]

% Define Dielectric Media
ex = ones(Nx,Ny+1,Nz+1)*er_x; % Relative Permittivity X
ey = ones(Nx+1,Ny,Nz+1)*er_y; % Relative Permittivity Y
ez = ones(Nx+1,Ny+1,Nz)*er_z; % Relative Permittivity Z

% Cut Out Free Space Area
ex(:,1:round(Ny*.8),:) = 1; % Relative Permittivity X 
ey(:,1:round(Ny*.8),:) = 1; % Relative Permittivity Y 
ez(:,1:round(Ny*.8),:) = 1; % Relative Permittivity Z 

% Initialize Maxwell's Equations Variables
[Ex] = zeros(Nx,Ny+1,Nz+1); % Ex cells
[Ey] = zeros(Nx+1,Ny,Nz+1); % Ey cells
[Ez] = zeros(Nx+1,Ny+1,Nz); % Ez cells
[Hx] = zeros(Nx+1,Ny,Nz);   % Hx cells
[Hy] = zeros(Nx,Ny+1,Nz);   % Hy cells
[Hz] = zeros(Nx,Ny,Nz+1);   % Hz cells

% E&H Field Coefficients
[Cexhy,Cexhz,Ceyhx,Ceyhz,Cezhx,Cezhy,...
    Chxey,Chxez,Chyex,Chyez,Chzex,Chzey] =...
    HE_Coef(e0,ex,ey,ez,u0,dx,dy,dz,dt);
 
% ADE-PML Boundaries
[aex,bex,amx,bmx,CPsi_eyx,CPsi_ezx,CPsi_hyx,CPsi_hzx,... % X Boundary
    Psi_eyx,Psi_hzx,Psi_ezx,Psi_hyx,Ceyhz,Cezhy,Chyez,Chzey] =...
    PML_X(Ceyhz,Cezhy,Chyez,Chzey,e0,u0,Nx,Ny,Nz,dx,dt,...
    PnX,rho_X,o_ratioX,kap_maxX,a_minX,a_maxX);
[aey,bey,amy,bmy,CPsi_exy,CPsi_ezy,CPsi_hxy,CPsi_hzy,... % Y Boundary
    Psi_exy,Psi_hzy,Psi_ezy,Psi_hxy,Cexhz,Cezhx,Chxez,Chzex] =...
    PML_Y(Cexhz,Cezhx,Chxez,Chzex,e0,u0,Nx,Ny,Nz,dy,dt,...
    PnY,rho_Y,o_ratioY,kap_maxY,a_minY,a_maxY);
[aez,bez,amz,bmz,CPsi_eyz,CPsi_exz,CPsi_hxz,CPsi_hyz,... % Z Boundary
    Psi_exz,Psi_hyz,Psi_eyz,Psi_hxz,Ceyhx,Cexhy,Chyex,Chxey] =...
    PML_Z(Ceyhx,Cexhy,Chyex,Chxey,e0,u0,Nx,Ny,Nz,dz,dt,...
    PnZ,rho_Z,o_ratioZ,kap_maxZ,a_minZ,a_maxZ);

% Generate Smoothed Signal Multiplier
[S] = RampSig(T,Stn,Scw,Stf,SO);

% Simulation Performance 
if Single == 1
    vars2Single();
end % Make variables single precision

if GPU == 1
    vars2GPU();
end % Load variables onto GPU

% Start Loop
t = 0;
while t < nt
    tic
        % Source Excited in E Field
        if t <= (Scw+Stn+Stf)*T
             Ez(round(Nx/2),round(Ny/2),round(Nz/2)) =...
                 S(t+1).*sin(2*pi*f0*dt*t); 
        end 
                        
        % Magnetic Field Update
        Hx = Hx+Chxey.*diff(Ey,1,3)+Chxez.*diff(Ez,1,2);
        Hy = Hy+Chyez.*diff(Ez,1,1)+Chyex.*diff(Ex,1,3);
        Hz = Hz+Chzex.*diff(Ex,1,2)+Chzey.*diff(Ey,1,1);
        
        % Magnetic Field PML Update
        Psi_hyx = bmx.*Psi_hyx+amx.*reshape(diff(reshape(Ez(... % X Boundary
            [1:PnX+1,Nx-PnX+1:Nx+1],:,:),PnX+1,2,Ny+1,Nz),1,1),2*PnX,Ny+1,Nz);
        Psi_hzx = bmx.*Psi_hzx+amx.*reshape(diff(reshape(Ey(...
            [1:PnX+1,Nx-PnX+1:Nx+1],:,:),PnX+1,2,Ny,Nz+1),1,1),2*PnX,Ny,Nz+1);
        Hy([1:PnX,Nx-PnX+1:Nx],:,:) = Hy([1:PnX,Nx-PnX+1:Nx],:,:)+...
            CPsi_hyx.*Psi_hyx;
        Hz([1:PnX,Nx-PnX+1:Nx],:,:) = Hz([1:PnX,Nx-PnX+1:Nx],:,:)+...
            CPsi_hzx.*Psi_hzx;
        
        Psi_hxy = bmy.*Psi_hxy+amy.*reshape(diff(reshape(Ez(... % Y Boundary
            :,[1:PnY+1,Ny-PnY+1:Ny+1],:),Nx+1,PnY+1,2,Nz),1,2),Nx+1,2*PnY,Nz);
        Psi_hzy = bmy.*Psi_hzy+amy.*reshape(diff(reshape(Ex(...
            :,[1:PnY+1,Ny-PnY+1:Ny+1],:),Nx,PnY+1,2,Nz+1),1,2),Nx,2*PnY,Nz+1);
        Hx(:,[1:PnY,Ny-PnY+1:Ny],:) = Hx(:,[1:PnY,Ny-PnY+1:Ny],:)+...
            CPsi_hxy.*Psi_hxy;
        Hz(:,[1:PnY,Ny-PnY+1:Ny],:) = Hz(:,[1:PnY,Ny-PnY+1:Ny],:)+...
            CPsi_hzy.*Psi_hzy;
        
        Psi_hxz = bmz.*Psi_hxz+amz.*reshape(diff(reshape(Ey(... % Z Boundary
            :,:,[1:PnZ+1,Nz-PnZ+1:Nz+1]),Nx+1,Ny,PnZ+1,2),1,3),Nx+1,Ny,2*PnZ);
        Psi_hyz = bmz.*Psi_hyz+amz.*reshape(diff(reshape(Ex(...
            :,:,[1:PnZ+1,Nz-PnZ+1:Nz+1]),Nx,Ny+1,PnZ+1,2),1,3),Nx,Ny+1,2*PnZ);
        Hx(:,:,[1:PnZ,Nz-PnZ+1:Nz]) = Hx(:,:,[1:PnZ,Nz-PnZ+1:Nz])+...
            CPsi_hxz.*Psi_hxz;
        Hy(:,:,[1:PnZ,Nz-PnZ+1:Nz]) = Hy(:,:,[1:PnZ,Nz-PnZ+1:Nz])+...
            CPsi_hyz.*Psi_hyz;
       
        % Electric Field Update        
        Ex(:,2:Ny,2:Nz) = Ex(:,2:Ny,2:Nz)+Cexhz.*diff(Hz(:,:,2:Nz),1,2)+...
            Cexhy.*diff(Hy(:,2:Ny,:),1,3);
        Ey(2:Nx,:,2:Nz) = Ey(2:Nx,:,2:Nz)+Ceyhx.*diff(Hx(2:Nx,:,:),1,3)+...
            Ceyhz.*diff(Hz(:,:,2:Nz),1,1);
        Ez(2:Nx,2:Ny,:) = Ez(2:Nx,2:Ny,:)+Cezhy.*diff(Hy(:,2:Ny,:),1,1)+...
            Cezhx.*diff(Hx(2:Nx,:,:),1,2);
            
        % Electric Field PML Update
        Psi_eyx = bex.*Psi_eyx+aex.*reshape(diff(reshape(Hz(... % X Boundary
            [1:PnX+1,Nx-PnX:Nx],:,:),PnX+1,2,Ny,Nz+1),1,1),2*PnX,Ny,Nz+1);
        Ey([2:PnX+1,Nx-PnX+1:Nx],:,:) = Ey([2:PnX+1,Nx-PnX+1:Nx],:,:)+...
            CPsi_eyx.*Psi_eyx;
        Psi_ezx = bex.*Psi_ezx+aex.*reshape(diff(reshape(Hy(...
            [1:PnX+1,Nx-PnX:Nx],:,:),PnX+1,2,Ny+1,Nz),1,1),2*PnX,Ny+1,Nz);
        Ez([2:PnX+1,Nx-PnX+1:Nx],:,:) = Ez([2:PnX+1,Nx-PnX+1:Nx],:,:)+...
            CPsi_ezx.*Psi_ezx;
        
        Psi_exy = bey.*Psi_exy+aey.*reshape(diff(reshape(Hz(... % Y Boundary
            :,[1:PnY+1,Ny-PnY:Ny],:),Nx,PnY+1,2,Nz+1),1,2),Nx,2*PnY,Nz+1);
        Ex(:,[2:PnY+1,Ny-PnY+1:Ny],:) = Ex(:,[2:PnY+1,Ny-PnY+1:Ny],:)+...
            CPsi_exy.*Psi_exy;
        Psi_ezy = bey.*Psi_ezy+aey.*reshape(diff(reshape(Hx(...
            :,[1:PnY+1,Ny-PnY:Ny],:),Nx+1,PnY+1,2,Nz),1,2),Nx+1,2*PnY,Nz);
        Ez(:,[2:PnY+1,Ny-PnY+1:Ny],:) = Ez(:,[2:PnY+1,Ny-PnY+1:Ny],:)+...
            CPsi_ezy.*Psi_ezy;
        
        Psi_eyz = bez.*Psi_eyz+aez.*reshape(diff(reshape(Hx(... % Z Boundary
            :,:,[1:PnZ+1,Nz-PnZ:Nz]),Nx+1,Ny,PnZ+1,2),1,3),Nx+1,Ny,2*PnZ);
        Ey(:,:,[2:PnZ+1,Nz-PnZ+1:Nz]) = Ey(:,:,[2:PnZ+1,Nz-PnZ+1:Nz])+...
            CPsi_eyz.*Psi_eyz;
        Psi_exz = bez.*Psi_exz+aez.*reshape(diff(reshape(Hy(...
            :,:,[1:PnZ+1,Nz-PnZ:Nz]),Nx,Ny+1,PnZ+1,2),1,3),Nx,Ny+1,2*PnZ);
        Ex(:,:,[2:PnZ+1,Nz-PnZ+1:Nz]) = Ex(:,:,[2:PnZ+1,Nz-PnZ+1:Nz])+...
            CPsi_exz.*Psi_exz;
            
        % Plotting
        % a = figure(1);
        if t == 0
            [I1,I2,I3] = Initialize_Plots(Ez,x,y,z,Nx,Ny,Nz);
        else
            E = 10*log10(abs(Ez)); E(isinf(E)|isnan(E)) = 10*log10(eps);
            I1.CData = gather(E(:,:,round(Nz/2)));
            I2.CData = gather(squeeze(E(:,round(Ny/2),:)));
            I3.CData = gather(squeeze(E(round(Nx/2),:,:)));
            drawnow;
        end
        t = t+1;
    toc
end
cd(baseDirectory);
% close(a);