function[aex,bex,amx,bmx,CPsi_ezx,CPsi_hyx,...
    Psi_ezx,Psi_hyx,Cezhy,Chyez] =...
    PML_X_2D(Cezhy,Chyez,Nx,Ny,e0,u0,dx,dt,...
    PnX,rho_orderX,o_ratioX,kappa_maxX,a_minX,a_maxX)

    % ADE Conditions
    rho_e    = [((PnX:-1:1)-0.25)/PnX,((1:PnX)-0.25)/PnX];
    rho_m    = [((PnX:-1:1)+0.25)/PnX,((1:PnX)+0.25)/PnX];
    o_max    = o_ratioX*(rho_orderX+1)./(150*pi*dx);
    o_pex    = o_max*rho_e.^rho_orderX;
    o_pmx    = (u0/e0)*o_max*rho_m.^rho_orderX;
    kappa_e  = 1+(kappa_maxX-1)*rho_e.^rho_orderX;
    kappa_m  = 1+(kappa_maxX-1)*rho_m.^rho_orderX;
    alpha_e  = a_minX+(a_maxX-a_minX).*(1-rho_e);
    alpha_m  = (u0/e0)*(a_minX+(a_maxX-a_minX).*(1-rho_m));
    bex = (e0*kappa_e)./(e0*kappa_e+dt.*(o_pex+alpha_e.*kappa_e));
    aex = (-dt*o_pex)./(dx*kappa_e.*(e0*kappa_e+dt.*(o_pex+alpha_e.*kappa_e)));
    bmx = (u0*kappa_m)./(u0*kappa_m+dt.*(o_pmx+alpha_m.*kappa_m));
    amx = (-dt*o_pmx)./(dx*kappa_m.*(u0*kappa_m+dt.*(o_pmx+alpha_m.*kappa_m)));
    bex = bex.';
    aex = aex.';
    bmx = bmx.';
    amx = amx.';
    
    %  Begin Making ADE-PML
    Psi_ezx  = zeros(2*PnX,1);
    CPsi_ezx = Cezhy([2:PnX+1,Nx-PnX+1:Nx],:)*dx; 
    Cezhy([2:PnX+1,Nx-PnX+1:Nx],:) = Cezhy([2:PnX+1,Nx-PnX+1:Nx],:)./kappa_e.';
    Cezhy = Cezhy(2:Nx,2:Ny);
    Psi_hyx  = zeros(2*PnX,1);
    CPsi_hyx = Chyez*dx; 
    Chyez    = Chyez.*ones(Nx,1);
    Chyez([1:PnX,Nx-PnX+1:Nx],:)   = Chyez([1:PnX,Nx-PnX+1:Nx],:)./kappa_m.';
end