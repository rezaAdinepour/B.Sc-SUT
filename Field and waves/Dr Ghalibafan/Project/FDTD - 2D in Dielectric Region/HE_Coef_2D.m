function[Cezhx,Cezhy,Czj,Chxez,Chyez] = HE_Coef_2D(e0,ez,u0,dx,dy,dt)
    Chxez = -2*dt/(2*u0*dy);     % Hx
    Chyez =  2*dt/(2*u0*dx);     % Hy
    Cezhx = -2*dt./(2*e0*ez*dy);  % Ez
    Cezhy =  2*dt./(2*e0*ez*dx);  % Ez
    Czj   = -2*dt/(2*e0);        % Ez
end