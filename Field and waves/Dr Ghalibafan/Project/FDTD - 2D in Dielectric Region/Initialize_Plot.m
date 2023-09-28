function[I1] = Initialize_Plot(Ez,x,y,Nx,Ny)
    E = abs(Ez);
    E = 10*log10(E);
    E(isinf(E)|isnan(E)) = 10*log10(eps);
    figure(2)
    set(gcf,'units','normalized','position',[0.08 0.1 .8 .8])
    ax  = gobjects(1,1);   %gobjects(1,2);
    tlo = tiledlayout(1,1); %tiledlayout(2,1);
    ax(1) = nexttile(tlo);
    I1 = imagesc(y,x,E);
    title('10log$$_{10}$$($$\left|E_z\right|$$)','fontsize',18)
    xlabel('Y - [meters]'); ylabel('X - [meters]')
    ax(1).XAxis.FontSize = 16;
    ax(1).YAxis.FontSize = 16;
    c = colorbar(ax(1));
    c.Title.String = "dB";
    c.Title.Interpreter = 'latex';
    c.Label.Interpreter = 'latex';
    c.TickLabelInterpreter = 'latex';
    c.FontSize = 14;
    caxis([-80 0]);
    pbaspect([Ny/Nx 1 1])
    drawnow;
end