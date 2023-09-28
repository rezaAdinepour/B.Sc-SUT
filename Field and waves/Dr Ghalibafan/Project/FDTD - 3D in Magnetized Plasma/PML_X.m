function[aex,bex,amx,bmx,CPsi_eyx,CPsi_ezx,CPsi_hyx,CPsi_hzx,...
    Psi_eyx,Psi_hzx,Psi_ezx,Psi_hyx,Ceyhz,Cezhy,Chyez,Chzey] =...
    PML_X(Ceyhz,Cezhy,Chyez,Chzey,Nx,e0,u0,dx,dt,...
    PnX,rho_orderX,o_ratioX,kappa_maxX,a_minX,a_maxX)

    % ADE Conditions
    rho_e    = [((PnX:-1:1)-0.50)/PnX,((1:PnX)-0.50)/PnX];
    rho_m    = [((PnX:-1:1)+0.00)/PnX,((1:PnX)+0.00)/PnX];
    o_max    = o_ratioX*(rho_orderX+1)/(150*pi*dx);
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

    % Hx & Ex CPML
    bex = bex.';
    aex = aex.';
    bmx = bmx.';
    amx = amx.';
    [Psi_eyx,Psi_hzx] = deal(zeros(2*PnX,1));
    [Psi_ezx,Psi_hyx] = deal(zeros(2*PnX,1));
    CPsi_eyx = Ceyhz*dx;
    CPsi_ezx = Cezhy*dx;
    CPsi_hyx = Chyez*dx;
    CPsi_hzx = Chzey*dx;
    Ceyhz = Ceyhz.*ones(Nx,1);
    Cezhy = Cezhy.*ones(Nx,1);
    Chyez = Chyez.*ones(Nx,1);
    Chzey = Chzey.*ones(Nx,1);
    Ceyhz([2:PnX+1,Nx-PnX+1:Nx],:) = Ceyhz([2:PnX+1,Nx-PnX+1:Nx],:)./kappa_e.';
    Cezhy([2:PnX+1,Nx-PnX+1:Nx],:) = Cezhy([2:PnX+1,Nx-PnX+1:Nx],:)./kappa_e.';
    Chyez([1:PnX,Nx-PnX+1:Nx],:)   = Chyez([1:PnX,Nx-PnX+1:Nx],:)./kappa_m.';
    Chzey([1:PnX,Nx-PnX+1:Nx],:)   = Chzey([1:PnX,Nx-PnX+1:Nx],:)./kappa_m.';
     
    Ceyhz = Ceyhz(2:Nx,1);
    Cezhy = Cezhy(2:Nx,1);
    
    % Reduce Matrix
    [CPsi_eyx] = Reduce_Matrix(CPsi_eyx);
    [CPsi_ezx] = Reduce_Matrix(CPsi_ezx);
    [CPsi_hzx] = Reduce_Matrix(CPsi_hzx);
    [CPsi_hyx] = Reduce_Matrix(CPsi_hyx);
    [Ceyhz] = Reduce_Matrix(Ceyhz);
    [Cezhy] = Reduce_Matrix(Cezhy);
    [Chyez] = Reduce_Matrix(Chyez);
    [Chzey] = Reduce_Matrix(Chzey);
end
