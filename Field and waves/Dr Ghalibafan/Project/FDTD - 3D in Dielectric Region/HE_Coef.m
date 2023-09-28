function[Cexhy,Cexhz,Ceyhx,Ceyhz,Cezhx,Cezhy,Chxey,Chxez,Chyex,Chyez,Chzex,Chzey] =...
    HE_Coef(e0,ex,ey,ez,u0,dx,dy,dz,dt)
    Chxey =  2*dt/(2*u0*dz);      % Hx
    Chxez = -2*dt/(2*u0*dy);      % Hx
    Cexhy = -2*dt./(2*e0*ex*dz);  % Ex
    Cexhz =  2*dt./(2*e0*ex*dy);  % Ex
    Chyex = -2*dt/(2*u0*dz);      % Hy
    Chyez =  2*dt/(2*u0*dx);      % Hy
    Ceyhx =  2*dt./(2*e0*ey*dz);  % Ey
    Ceyhz = -2*dt./(2*e0*ey*dx);  % Ey
    Chzex =  2*dt/(2*u0*dy);      % Hz
    Chzey = -2*dt/(2*u0*dx);      % Hz
    Cezhx = -2*dt./(2*e0*ez*dy);  % Ez
    Cezhy =  2*dt./(2*e0*ez*dx);  % Ez
end