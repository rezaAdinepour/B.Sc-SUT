function[Cexhy,Cexhz,Cxj,Ceyhx,Ceyhz,Cyj,Cezhx,Cezhy,Czj,...
    Chxey,Chxez,Chyex,Chyez,Chzex,Chzey] =...
    HE_Coef(e0,u0,dx,dy,dz,dt)

    % Coefficients Needed for E and H Update Equations
    Chxey =  2*dt/(2*u0*dz);  % Hx
    Chxez = -2*dt/(2*u0*dy);  % Hx
    Cexhy = -2*dt/(2*e0*dz);  % Ex
    Cexhz =  2*dt/(2*e0*dy);  % Ex
    Cxj   = -2*dt/(2*e0);     % Ex
    Chyex = -2*dt/(2*u0*dz);  % Hy
    Chyez =  2*dt/(2*u0*dx);  % Hy
    Ceyhx =  2*dt/(2*e0*dz);  % Ey
    Ceyhz = -2*dt/(2*e0*dx);  % Ey
    Cyj   = -2*dt/(2*e0);     % Ey
    Chzex =  2*dt/(2*u0*dy);  % Hz
    Chzey = -2*dt/(2*u0*dx);  % Hz
    Cezhx = -2*dt/(2*e0*dy);  % Ez
    Cezhy =  2*dt/(2*e0*dx);  % Ez
    Czj   = -2*dt/(2*e0);     % Ez
end