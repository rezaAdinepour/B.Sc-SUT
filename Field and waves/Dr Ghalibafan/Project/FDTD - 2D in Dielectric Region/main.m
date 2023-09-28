clear; close all;

addpath('functions');
graphDefaults();

baseDirectory = 'C:\Users\r3z4\OneDrive\Desktop\Field and waves Project\';

% Simulation Performance
Single = 0; % 0 = Double Precision, 1 = Single Precision
GPU    = 1; % 0 = No Gpu          , 1 = Use Gpu

% Define Simulation Based on Source, Dielectric Wavelength (SI units)
f0   = 1e6;              % Frequency of Source              [Hertz]
Stn  = 6;                % Number of "Turn-on" Periods      [unitless]
Scw  = 1;                % Number of max amplitude periods  [unitless]
Stf  = 6;                % Number of "Turn off" periods     [unitless]
SO   = 8;                % Smoothstep Order                 [unitless]
Lf   = 20;               % Divisions per Wavelength         [unitless]
CF   = 0.5;              % CFL percentage                   [unitless]
nt   = 20000;            % Number of time steps             [unitless]
er_z = 6;                % Relative Permittivity (Z)        [unitless]
[Lx,Ly] = deal(10,40);   % Wavelengths in x,y direction     [unitless]

% Define Source Position Along Y Axis, Normalized from 0 to 1
SP   = .15;              % Source Position     1-0       
DP   = .7;               % Dielectric Position 1-0

% Define ADE PML Boundary Condition Parameters (X,Y)
[PnX,PnY]           = deal(30,30);     % PML Cells (X,Y)
[rho_X,rho_Y]       = deal(3.65,3.65); % Poly Order
[o_ratioX,o_ratioY] = deal(1,1);       % Sigma_Ratio
[kap_maxX,kap_maxY] = deal(2,2);       % Kappa_Max
[a_minX,a_minY]     = deal(0,0);       % Alpha_Min
[a_maxX,a_maxY]     = deal(4e-5,4e-5); % Alpha_Max

% Spatial and Temporal System (SI units)
e0 = 8.854*10^-12;    % Permittivity of Vacuum [farad/meter]
u0 = 4*pi*10^-7;      % Permeability of Vacuum [henry/meter]
c0 = 1/(e0*u0)^.5;    % Speed of Light         [meter/second]
L0 = c0/f0/(er_z^.5); % Freespace Wavelength   [meter]
t0 = 1/f0;            % Source Period          [second]
[Nx,Ny] = deal(Lx*Lf,Ly*Lf);      % Points in x,y,z   [unitless]
x       = linspace(0,Lx,Nx+1)*L0; % x Vector          [meter]
y       = linspace(0,Ly,Ny+1)*L0; % y Vector          [meter]
[dx,dy] = deal(x(2),y(2));        % x,y Increment     [meter]
dt = (dx^-2+dy^-2)^-.5/c0; % CFL Condition                    [second]
dt = dt*CF;                % CFL Condition Reduced            [second]
dt = t0/ceil(t0/dt);       % Time Step For Integer Time       [second]
T  = round(t0/dt);         % Integer Time Steps for 1 Cycle   [unitless]

% Define Dielectric Media
ez = ones(Nx+1,Ny+1)*er_z;
ez(:,1:round(Ny*DP)) = 1;

% Initialize Maxwell's Equations Variables
[Ez] = deal(zeros(Nx+1,Ny+1)); % Ez cells
[Hx] = deal(zeros(Nx+1,Ny));   % Hx cells
[Hy] = deal(zeros(Nx,Ny+1));   % Hy cells

% Calculate E&H Update Coefficients
[Cezhx,Cezhy,Czj,Chxez,Chyez] = HE_Coef_2D(e0,ez,u0,dx,dy,dt);

% Calculate ADE-PML Coefficients
[aex,bex,amx,bmx,CPsi_ezx,CPsi_hyx,Psi_ezx,Psi_hyx,Cezhy,Chyez] =...
    PML_X_2D(Cezhy,Chyez,Nx,Ny,e0,u0,dx,dt,... % X Boundary
    PnX,rho_X,o_ratioX,kap_maxX,a_minX,a_maxX);
[aey,bey,amy,bmy,CPsi_ezy,CPsi_hxy,Psi_ezy,Psi_hxy,Cezhx,Chxez] =...
    PML_Y_2D(Cezhx,Chxez,e0,u0,Nx,Ny,dy,dt,... % Y Boundary
    PnY,rho_Y,o_ratioY,kap_maxY,a_minY,a_maxY);

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
        % Magnetic Field Update
        Hx = Hx+Chxez.*diff(Ez,1,2);
        Hy = Hy+Chyez.*diff(Ez,1,1);
        
        % Magnetic Field ADE-PML Update
        Psi_hyx = bmx.*Psi_hyx +... % X Boundary
            amx.*cat(1,diff(Ez(1:PnX+1,:),1,1),diff(Ez(Nx-PnX+1:Nx+1,:),1,1));
        Hy([1:PnX,Nx-PnX+1:Nx],:) =...
            Hy([1:PnX,Nx-PnX+1:Nx],:) + CPsi_hyx.*Psi_hyx;
        
        Psi_hxy = bmy.*Psi_hxy +... % Y Boundary
            amy.*cat(2,diff(Ez(:,1:PnY+1),1,2),diff(Ez(:,Ny-PnY+1:Ny+1),1,2));
        Hx(:,[1:PnY,Ny-PnY+1:Ny]) =...
            Hx(:,[1:PnY,Ny-PnY+1:Ny]) + CPsi_hxy.*Psi_hxy;
            
        % Source Excited in Ez Field
        if t <= (Scw+Stn+Stf)*T
            Ez(round(Nx/2),round(Ny*SP)) = S(t+1).*sin(2*pi*f0*dt*t);
        elseif t > (Scw+Stn+Stf)*T && t < (Scw+Stn+Stf)*T+T
            Ez(round(Nx/2),round(Ny*SP)) = 0;
        end
        
        % Electric Field Update
        Ez(2:Nx,2:Ny) = Ez(2:Nx,2:Ny) + Cezhy.*diff(Hy(:,2:Ny),1,1) +...
            Cezhx.*diff(Hx(2:Nx,:),1,2);
        
        % Electric Field ADE-PML Update
        Psi_ezx = bex.*Psi_ezx+... % X Boundary
            aex.*cat(1,diff(Hy(1:PnX+1,:),1,1),diff(Hy(Nx-PnX:Nx,:),1,1));
        Ez([2:PnX+1,Nx-PnX+1:Nx],:) =...
            Ez([2:PnX+1,Nx-PnX+1:Nx],:) + CPsi_ezx.*Psi_ezx;
        
        Psi_ezy = bey.*Psi_ezy+... % Y Boundary
            aey.*cat(2,diff(Hx(:,1:PnY+1),1,2),diff(Hx(:,Ny-PnY:Ny),1,2));
        Ez(:,[2:PnY+1,Ny-PnY+1:Ny]) =...
            Ez(:,[2:PnY+1,Ny-PnY+1:Ny]) + CPsi_ezy.*Psi_ezy;
        
        % Plotting
        % a = figure(1);
        if t == 0
            [I1] = Initialize_Plot(Ez,x,y,Nx,Ny);
        else
            E = 10*log10(abs(Ez)); E(isinf(E)|isnan(E)) = 10*log10(eps);
            I1.CData = gather(E); drawnow;
        end
    
        t = t + 1; 
    toc
end
cd(baseDirectory);
% close(a);