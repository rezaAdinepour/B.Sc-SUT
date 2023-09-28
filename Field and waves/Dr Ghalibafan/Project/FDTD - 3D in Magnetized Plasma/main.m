clear;
close all;

addpath('functions');
graphDefaults();

baseDirectory = 'C:\Users\r3z4\OneDrive\Desktop\Field and waves Project\';

% Simulation Performance
Single = 1; % 0 = Double Precision, 1 = Single Precision
GPU    = 1; % 0 = No Gpu          , 1 = Use Gpu

% Load Plasma Parameters - Ref [1 & 2]
[f0,Ne,B0,ve,dt,Nx,Ny,Nz,x,y,z,dx,dy,dz,e0,u0,wpe,wce_x,wce_y,wce_z] =...
    Plasma_Environment();

% Time Parameters
nt    = 5000;    % [NoUnit] Number of time steps 
dt    = dt*0.99; % [s] CFL condition reduced 

% Generate Electromagnetic Source - Ref [3] pg148-151
BW    = .95;     % [NoUnit] Bandwidth percentage from 0 to 2*f0             
[S]   = Generate_Waveform(f0,BW,nt,dt);

% Define ADE PML Boundary Condition Parameters - Ref [3] pg229-275
[PnX,PnY,PnZ]                = deal(30,30,30);       % Each Side PML Cells
[rho_X,rho_Y,rho_Z]          = deal(4.5,4.5,4.5);    % Poly order
[o_ratioX,o_ratioY,o_ratioZ] = deal(3,3,3);          % sigma_ratio
[kap_maxX,kap_maxY,kap_maxZ] = deal(3,3,3);          % kappa_max
[a_minX,a_minY,a_minZ]       = deal(0,0,0);          % alpha_min
[a_maxX,a_maxY,a_maxZ]       = deal(1e-3,1e-3,1e-3); % alpha_max

% Initialize Variables of Maxwell's Equations
[Hx]         = zeros(Nx+1,Ny,Nz);         % Hx cells
[Hy]         = zeros(Nx,Ny+1,Nz);         % Hy cells
[Hz]         = zeros(Nx,Ny,Nz+1);         % Hz cells
[Ex]         = zeros(Nx,Ny+1,Nz+1);       % Ex cells
[Ey]         = zeros(Nx+1,Ny,Nz+1);       % Ey cells
[Ex0,Ey0]    = deal(zeros(Nx-1,Ny-1,Nz)); % Ex,Ey Averaged into Ez cells
[Ez,Jx,Jy]   = deal(zeros(Nx+1,Ny+1,Nz)); % Ez cells
[Jx0]        = zeros(Nx,Ny-1,Nz-1);       % Jx Averaged into Ex cells
[Jy0]        = zeros(Nx-1,Ny,Nz-1);       % Jy Averaged into Ey cells
[Jz0]        = zeros(Nx-1,Ny-1,Nz);       % Jz cells
JzS          = Jz0;                       % Source Space (excited in Jz)

% E & H Field Coefficients - Ref [3] pg13-21
[Cexhy,Cexhz,Cxj,Ceyhx,Ceyhz,Cyj,Cezhx,Cezhy,Czj,...
    Chxey,Chxez,Chyex,Chyez,Chzex,Chzey] =...
    HE_Coef(e0,u0,dx,dy,dz,dt);

% J Update Coefficients - Ref [4] 
[Jxjx,Jxjy,Jxjz,Jyjx,Jyjy,Jyjz,Jzjx,Jzjy,Jzjz,...
 Jxex,Jxey,Jxez,Jyex,Jyey,Jyez,Jzex,Jzey,Jzez] =...
    JE_Coef_elec(e0,ve,dt,wpe,wce_x,wce_y,wce_z);

% ADE-CPML Boundary Coefficients - Ref [3] pg229-275
[aex,bex,amx,bmx,CPsi_eyx,CPsi_ezx,CPsi_hyx,CPsi_hzx,...
    Psi_eyx,Psi_hzx,Psi_ezx,Psi_hyx,Ceyhz,Cezhy,Chyez,Chzey] =...
    PML_X(Ceyhz,Cezhy,Chyez,Chzey,Nx,e0,u0,dx,dt,...
    PnX,rho_X,o_ratioX,kap_maxX,a_minX,a_maxX);
[aey,bey,amy,bmy,CPsi_exy,CPsi_ezy,CPsi_hxy,CPsi_hzy,...
    Psi_exy,Psi_hzy,Psi_ezy,Psi_hxy,Cexhz,Cezhx,Chxez,Chzex] =...
    PML_Y(Cexhz,Cezhx,Chxez,Chzex,e0,u0,Ny,dy,dt,...
    PnY,rho_Y,o_ratioY,kap_maxY,a_minY,a_maxY);
[aez,bez,amz,bmz,CPsi_eyz,CPsi_exz,CPsi_hxz,CPsi_hyz,...
    Psi_exz,Psi_hyz,Psi_eyz,Psi_hxz,Ceyhx,Cexhy,Chyex,Chxey] =...
    PML_Z(Ceyhx,Cexhy,Chyex,Chxey,e0,u0,Nz,dz,dt,...
    PnZ,rho_Z,o_ratioZ,kap_maxZ,a_minZ,a_maxZ);

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
        % Magnetic Field Update - Ref [3 & 4]
        Hx = Hx+Chxey.*diff(Ey,1,3)+Chxez.*diff(Ez,1,2); 
        Hy = Hy+Chyez.*diff(Ez,1,1)+Chyex.*diff(Ex,1,3);
        Hz = Hz+Chzex.*diff(Ex,1,2)+Chzey.*diff(Ey,1,1);
            
        % Magnetic Field PML Update - Ref [3] pg229-275
        Psi_hyx = bmx.*Psi_hyx+amx.*reshape(diff(reshape(Ez(... %Hx Component
            [1:PnX+1,Nx-PnX+1:Nx+1],:,:),PnX+1,2,Ny+1,Nz),1,1),2*PnX,Ny+1,Nz);
        Psi_hzx = bmx.*Psi_hzx+amx.*reshape(diff(reshape(Ey(...
            [1:PnX+1,Nx-PnX+1:Nx+1],:,:),PnX+1,2,Ny,Nz+1),1,1),2*PnX,Ny,Nz+1);
        Hy([1:PnX,Nx-PnX+1:Nx],:,:) = Hy([1:PnX,Nx-PnX+1:Nx],:,:)+...
            CPsi_hyx.*Psi_hyx;
        Hz([1:PnX,Nx-PnX+1:Nx],:,:) = Hz([1:PnX,Nx-PnX+1:Nx],:,:)+...
            CPsi_hzx.*Psi_hzx;
        
        Psi_hxy = bmy.*Psi_hxy+amy.*reshape(diff(reshape(Ez(... %Hy Component
            :,[1:PnY+1,Ny-PnY+1:Ny+1],:),Nx+1,PnY+1,2,Nz),1,2),Nx+1,2*PnY,Nz);
        Psi_hzy = bmy.*Psi_hzy+amy.*reshape(diff(reshape(Ex(...
            :,[1:PnY+1,Ny-PnY+1:Ny+1],:),Nx,PnY+1,2,Nz+1),1,2),Nx,2*PnY,Nz+1);
        Hx(:,[1:PnY,Ny-PnY+1:Ny],:) = Hx(:,[1:PnY,Ny-PnY+1:Ny],:)+...
            CPsi_hxy.*Psi_hxy;
        Hz(:,[1:PnY,Ny-PnY+1:Ny],:) = Hz(:,[1:PnY,Ny-PnY+1:Ny],:)+...
            CPsi_hzy.*Psi_hzy;
        
        Psi_hxz = bmz.*Psi_hxz+amz.*reshape(diff(reshape(Ey(... %Hz Component
            :,:,[1:PnZ+1,Nz-PnZ+1:Nz+1]),Nx+1,Ny,PnZ+1,2),1,3),Nx+1,Ny,2*PnZ);
        Psi_hyz = bmz.*Psi_hyz+amz.*reshape(diff(reshape(Ex(...
            :,:,[1:PnZ+1,Nz-PnZ+1:Nz+1]),Nx,Ny+1,PnZ+1,2),1,3),Nx,Ny+1,2*PnZ);
        Hx(:,:,[1:PnZ,Nz-PnZ+1:Nz]) = Hx(:,:,[1:PnZ,Nz-PnZ+1:Nz])+...
            CPsi_hxz.*Psi_hxz;
        Hy(:,:,[1:PnZ,Nz-PnZ+1:Nz]) = Hy(:,:,[1:PnZ,Nz-PnZ+1:Nz])+...
            CPsi_hyz.*Psi_hyz;
        % Source Excited in Ez Field
        if t < length(S)
            JzS(round(Nx/2),PnY*2,round(Nz/2)) = S(t+1)*1e-1;
        end
        % Electric Field Update     
        Hx0 = Hx(2:Nx,:,:); 
        Hy0 = Hy(:,2:Ny,:);
        Hz0 = Hz(:,:,2:Nz);
        Ex(:,2:Ny,2:Nz) = Ex(:,2:Ny,2:Nz)+Cexhz.*diff(Hz0,1,2)+...
            Cexhy.*diff(Hy0,1,3)+Cxj.*Jx0;  clear Jx0
        
        Ey(2:Nx,:,2:Nz) = Ey(2:Nx,:,2:Nz)+Ceyhx.*diff(Hx0,1,3)+...
            Ceyhz.*diff(Hz0,1,1)+Cyj.*Jy0;  clear Jy0 Hz0 
        
        Ez(2:Nx,2:Ny,:) = Ez(2:Nx,2:Ny,:)+Cezhy.*diff(Hy0,1,1)+...
            Cezhx.*diff(Hx0,1,2)+Czj.*(Jz0+JzS); clear Hx0 Hy0 
        % Electric Field PML Update - Ref [3] pg229-275
        Psi_eyx = bex.*Psi_eyx+aex.*reshape(diff(reshape(Hz(... %X Boundary
            [1:PnX+1,Nx-PnX:Nx],:,:),PnX+1,2,Ny,Nz+1),1,1),2*PnX,Ny,Nz+1);
        Psi_ezx = bex.*Psi_ezx+aex.*reshape(diff(reshape(Hy(...
            [1:PnX+1,Nx-PnX:Nx],:,:),PnX+1,2,Ny+1,Nz),1,1),2*PnX,Ny+1,Nz);
        Ey([2:PnX+1,Nx-PnX+1:Nx],:,:) = Ey([2:PnX+1,Nx-PnX+1:Nx],:,:)+...
            CPsi_eyx.*Psi_eyx;
        Ez([2:PnX+1,Nx-PnX+1:Nx],:,:) = Ez([2:PnX+1,Nx-PnX+1:Nx],:,:)+...
            CPsi_ezx.*Psi_ezx;
        
        Psi_exy = bey.*Psi_exy+aey.*reshape(diff(reshape(Hz(... %Y Boundary
            :,[1:PnY+1,Ny-PnY:Ny],:),Nx,PnY+1,2,Nz+1),1,2),Nx,2*PnY,Nz+1);
        Psi_ezy = bey.*Psi_ezy+aey.*reshape(diff(reshape(Hx(...
            :,[1:PnY+1,Ny-PnY:Ny],:),Nx+1,PnY+1,2,Nz),1,2),Nx+1,2*PnY,Nz);
        Ex(:,[2:PnY+1,Ny-PnY+1:Ny],:) = Ex(:,[2:PnY+1,Ny-PnY+1:Ny],:)+...
            CPsi_exy.*Psi_exy;
        Ez(:,[2:PnY+1,Ny-PnY+1:Ny],:) = Ez(:,[2:PnY+1,Ny-PnY+1:Ny],:)+...
            CPsi_ezy.*Psi_ezy;
        
        Psi_eyz = bez.*Psi_eyz+aez.*reshape(diff(reshape(Hx(... %Z Boundary
            :,:,[1:PnZ+1,Nz-PnZ:Nz]),Nx+1,Ny,PnZ+1,2),1,3),Nx+1,Ny,2*PnZ);
        Psi_exz = bez.*Psi_exz+aez.*reshape(diff(reshape(Hy(...
            :,:,[1:PnZ+1,Nz-PnZ:Nz]),Nx,Ny+1,PnZ+1,2),1,3),Nx,Ny+1,2*PnZ);
        Ey(:,:,[2:PnZ+1,Nz-PnZ+1:Nz]) = Ey(:,:,[2:PnZ+1,Nz-PnZ+1:Nz])+...
            CPsi_eyz.*Psi_eyz;
        Ex(:,:,[2:PnZ+1,Nz-PnZ+1:Nz]) = Ex(:,:,[2:PnZ+1,Nz-PnZ+1:Nz])+...
            CPsi_exz.*Psi_exz;
        
        % Average Electric Field for Current Update - Ref [4]
        Ex0 = movsum(movsum(Ex,2,3),2,1)*0.25;
        Ex0 = Ex0(2:Nx,2:Ny,2:Nz+1);
        Ey0 = movsum(movsum(Ey,2,3),2,2)*0.25;
        Ey0 = Ey0(2:Nx,2:Ny,2:Nz+1);
        
        % Current Field Update - Ref [4]
        Jx1 = Jx(2:Nx,2:Ny,:);
        Jy1 = Jy(2:Nx,2:Ny,:);
        Ez1 = Ez(2:Nx,2:Ny,:);
        Jx(2:Nx,2:Ny,:) = Jxjx.*Jx1+Jxjy.*Jy1+Jxjz.*Jz0+...
                          Jxex.*Ex0+Jxey.*Ey0+Jxez.*Ez1;
        Jx0 = movsum(movsum(Jx,2,3),2,1)*0.25; % average into Ex
        Jx0 = Jx0(2:Nx+1,2:Ny,2:Nz);
        
        Jy(2:Nx,2:Ny,:) = Jyjx.*Jx1+Jyjy.*Jy1+Jyjz.*Jz0+...
                          Jyex.*Ex0+Jyey.*Ey0+Jyez.*Ez1;
        Jy0 = movsum(movsum(Jy,2,3),2,2)*0.25; % average into Ey
        Jy0 = Jy0(2:Nx,2:Ny+1,2:Nz);
        Jz0 = Jzjx.*Jx1+Jzjy.*Jy1+Jzjz.*Jz0+...
              Jzex.*Ex0+Jzey.*Ey0+Jzez.*Ez1; clear Ex0 Ey0 Jx1 Jy1 Ez1
        
        % Plotting    
        %a = figure(1);
        if t == 0
            [I1] = SetupPlot(Ez,Ne,x,y,dx,dy);
        elseif mod(t,1) == 0
            E = abs(Ez(:,:,round(Nz/2))); E = 10*log10(E); 
            E(isinf(E)|isnan(E)) = 10*log10(eps(1+Single));
            I1.CData = gather(E); 
            drawnow;
        end    
        t = t+1; 
    toc
end
cd(baseDirectory);
% close(a);