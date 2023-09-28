function[aey,bey,amy,bmy,CPsi_exy,CPsi_ezy,CPsi_hxy,CPsi_hzy,...
    Psi_exy,Psi_hzy,Psi_ezy,Psi_hxy,Cexhz,Cezhx,Chxez,Chzex] =...
    PML_Y(Cexhz,Cezhx,Chxez,Chzex,e0,u0,Nx,Ny,Nz,dy,dt,...
    PnY,rho_orderY,o_ratioY,kappa_maxY,a_minY,a_maxY)

    % ADE Conditions
    rho_e    = [((PnY:-1:1)-0.25)/PnY,((1:PnY)-0.25)/PnY];
    rho_m    = [((PnY:-1:1)+0.25)/PnY,((1:PnY)+0.25)/PnY];
    o_max    = o_ratioY*(rho_orderY +1)/(150*pi*dy);
    o_pey    = o_max*rho_e.^rho_orderY;
    o_pmy    = (u0/e0)*o_max*rho_m.^rho_orderY;
    kappa_e  = 1+(kappa_maxY-1)*rho_e.^rho_orderY;
    kappa_m  = 1+(kappa_maxY-1)*rho_m.^rho_orderY;
    alpha_e  = a_minY+(a_maxY-a_minY).*(1-rho_e);
    alpha_m  = (u0/e0)*(a_minY+(a_maxY-a_minY).*(1-rho_m));
    bey = (e0*kappa_e)./(e0*kappa_e+dt.*(o_pey+alpha_e.*kappa_e));
    aey = (-dt*o_pey)./(dy*kappa_e.*(e0*kappa_e+dt.*(o_pey+alpha_e.*kappa_e)));
    bmy = (u0*kappa_m)./(u0*kappa_m+dt.*(o_pmy+alpha_m.*kappa_m));
    amy = (-dt*o_pmy)./(dy*kappa_m.*(u0*kappa_m+dt.*(o_pmy+alpha_m.*kappa_m)));

    % Y Boundary ADE-PML
    [Psi_exy,Psi_hzy] = deal(zeros(1,2*PnY));
    [Psi_ezy,Psi_hxy] = deal(zeros(1,2*PnY));
    CPsi_exy = Cexhz(:,[2:PnY+1,Ny-PnY+1:Ny],:).*dy;
    CPsi_ezy = Cezhx(:,[2:PnY+1,Ny-PnY+1:Ny],:).*dy;
    Cexhz(:,[2:PnY+1,Ny-PnY+1:Ny],:) = Cexhz(:,[2:PnY+1,Ny-PnY+1:Ny],:)./kappa_e;
    Cezhx(:,[2:PnY+1,Ny-PnY+1:Ny],:) = Cezhx(:,[2:PnY+1,Ny-PnY+1:Ny],:)./kappa_e;
    CPsi_hxy = Chxez*dy;
    CPsi_hzy = Chzex*dy;
    Chxez = Chxez.*ones(1,Ny);
    Chzex = Chzex.*ones(1,Ny);
    Chxez(:,[1:PnY,Ny-PnY+1:Ny],:) = Chxez(:,[1:PnY,Ny-PnY+1:Ny])./kappa_m;
    Chzex(:,[1:PnY,Ny-PnY+1:Ny],:) = Chzex(:,[1:PnY,Ny-PnY+1:Ny])./kappa_m;
    Cexhz = Cexhz(:,2:Ny,2:Nz);
    Cezhx = Cezhx(2:Nx,2:Ny,:);

    % Reduce Repetitive Matrix
    [CPsi_exy] = Reduce_Matrix(CPsi_exy);
    [CPsi_ezy] = Reduce_Matrix(CPsi_ezy);
    [CPsi_hxy] = Reduce_Matrix(CPsi_hxy);
    [CPsi_hzy] = Reduce_Matrix(CPsi_hzy);
    [Cexhz] = Reduce_Matrix(Cexhz);
    [Cezhx] = Reduce_Matrix(Cezhx);
    [Chxez] = Reduce_Matrix(Chxez);
    [Chzex] = Reduce_Matrix(Chzex);
end