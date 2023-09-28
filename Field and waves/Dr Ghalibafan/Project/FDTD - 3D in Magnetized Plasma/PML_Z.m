function[aez,bez,amz,bmz,CPsi_eyz,CPsi_exz,CPsi_hxz,CPsi_hyz,...
    Psi_exz,Psi_hyz,Psi_eyz,Psi_hxz,Ceyhx,Cexhy,Chyex,Chxey] =...
    PML_Z(Ceyhx,Cexhy,Chyex,Chxey,e0,u0,Nz,dz,dt,...
    PnZ,rho_orderZ,o_ratioZ,kappa_maxZ,a_minZ,a_maxZ)

    % ADE Conditions
    rho_e    = [((PnZ:-1:1)-0.50)/PnZ,((1:PnZ)-0.50)/PnZ];
    rho_m    = [((PnZ:-1:1)+0.00)/PnZ,((1:PnZ)+0.00)/PnZ];
    o_max    = o_ratioZ*(rho_orderZ+1)/(150*pi*dz);
    o_pez    = o_max*rho_e.^rho_orderZ;
    o_pmz    = (u0/e0)*o_max*rho_m.^rho_orderZ;
    kappa_e  = 1+(kappa_maxZ-1)*rho_e.^rho_orderZ;
    kappa_m  = 1+(kappa_maxZ-1)*rho_m.^rho_orderZ;
    alpha_e  = a_minZ+(a_maxZ-a_minZ).*(1-rho_e);
    alpha_m  = (u0/e0)*(a_minZ+(a_maxZ-a_minZ).*(1-rho_m));
    bez = (e0*kappa_e)./(e0*kappa_e+dt.*(o_pez+alpha_e.*kappa_e));
    aez = (-dt*o_pez)./(dz*kappa_e.*(e0*kappa_e+dt.*(o_pez+alpha_e.*kappa_e)));
    bmz = (u0*kappa_m)./(u0*kappa_m+dt.*(o_pmz+alpha_m.*kappa_m));
    amz = (-dt*o_pmz)./(dz*kappa_m.*(u0*kappa_m+dt.*(o_pmz+alpha_m.*kappa_m)));

    % Hy & Ey CPML
    bez = permute(bez,[1 3 2]);
    aez = permute(aez,[1 3 2]);
    bmz = permute(bmz,[1 3 2]);
    amz = permute(amz,[1 3 2]);
    [Psi_exz,Psi_hyz] = deal(zeros(1,1,2*PnZ));
    [Psi_eyz,Psi_hxz] = deal(zeros(1,1,2*PnZ));
    CPsi_eyz = Ceyhx*dz;
    CPsi_exz = Cexhy*dz;
    CPsi_hyz = Chyex*dz;
    CPsi_hxz = Chxey*dz;
    kappa_e = permute(kappa_e,[1 3 2]);
    kappa_m = permute(kappa_m,[1 3 2]);
    Cexhy = Cexhy.*ones(1,1,Nz);
    Ceyhx = Ceyhx.*ones(1,1,Nz);
    Chxey = Chxey.*ones(1,1,Nz);
    Chyex = Chyex.*ones(1,1,Nz);
    Ceyhx(:,:,[2:PnZ+1,Nz-PnZ+1:Nz]) =...
        Ceyhx(:,:,[2:PnZ+1,Nz-PnZ+1:Nz])./kappa_e;
    Cexhy(:,:,[2:PnZ+1,Nz-PnZ+1:Nz]) =...
        Cexhy(:,:,[2:PnZ+1,Nz-PnZ+1:Nz])./kappa_e;
    Chyex(:,:,[1:PnZ,Nz-PnZ+1:Nz]) =...
        Chyex(:,:,[1:PnZ,Nz-PnZ+1:Nz])./kappa_m;
    Chxey(:,:,[1:PnZ,Nz-PnZ+1:Nz]) =...
        Chxey(:,:,[1:PnZ,Nz-PnZ+1:Nz])./kappa_m;
    Cexhy = Cexhy(1,1,2:Nz);
    Ceyhx = Ceyhx(1,1,2:Nz);

    % Reduce Matrix
    [CPsi_exz] = Reduce_Matrix(CPsi_exz);
    [CPsi_eyz] = Reduce_Matrix(CPsi_eyz);
    [CPsi_hyz] = Reduce_Matrix(CPsi_hyz);
    [CPsi_hxz] = Reduce_Matrix(CPsi_hxz);
    [Cexhy] = Reduce_Matrix(Cexhy);
    [Ceyhx] = Reduce_Matrix(Ceyhx);
    [Chxey] = Reduce_Matrix(Chxey);
    [Chyex] = Reduce_Matrix(Chyex);
end