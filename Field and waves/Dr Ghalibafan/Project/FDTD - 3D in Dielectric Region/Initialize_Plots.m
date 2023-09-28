function[I1,I2,I3] = Initialize_Plots(Ez,x,y,z,Nx,Ny,Nz)
    E = abs(Ez);
    E = 10*log10(E);
    E(isinf(E)|isnan(E)) = 10*log10(eps);
    Ez_XY = E(:,:,round(Nz/2));
    Ez_XZ = squeeze(E(:,round(Ny/2),:));
    Ez_YZ = squeeze(E(round(Nx/2),:,:));
    figure(1)
    set(gcf,'units','normalized','position',[0.08 0.1 .8 .8])
    ax  = gobjects(1,3);   
    tlo = tiledlayout(1,3); 

    % XY Plot
    ax(1) = nexttile(tlo);
    I1    = imagesc(y,x,Ez_XY);
    title('10log$$_{10}$$($$\left|E_z\right|$$)','fontsize',16);
    xlabel('Y - [meters]'); 
    ylabel('X - [meters]')
    ax(1).XAxis.FontSize = 16;
    ax(1).YAxis.FontSize = 16;
    c1 = colorbar(ax(1));
    c1.Title.String = "dB";
    c1.Title.Interpreter = 'latex';
    c1.Label.Interpreter = 'latex';
    c1.TickLabelInterpreter = 'latex';
    c1.FontSize = 14;
    caxis([-80 0]);
    axis square;

    % XZ Plot
    ax(2) = nexttile(tlo);
    I2 = imagesc(z,x,Ez_XZ);
    title('10log$$_{10}$$($$\left|E_z\right|$$)','fontsize',16);
    xlabel('Z - [meters]'); 
    ylabel('X - [meters]')
    ax(2).XAxis.FontSize = 16;
    ax(2).YAxis.FontSize = 16;
    c2 = colorbar(ax(2));
    c2.Title.String = "dB";
    c2.Title.Interpreter = 'latex';
    c2.Label.Interpreter = 'latex';
    c2.TickLabelInterpreter = 'latex';
    c2.FontSize = 14;
    caxis([-80 0]);
    axis square;

    % YZ Plot
    ax(3) = nexttile(tlo);
    I3 = imagesc(z,y,Ez_YZ);
    title('10log$$_{10}$$($$\left|E_z\right|$$)','fontsize',16);
    xlabel('Z - [meters]'); 
    ylabel('Y - [meters]')
    ax(3).XAxis.FontSize = 16;
    ax(3).YAxis.FontSize = 16;
    c3 = colorbar(ax(3));
    c3.Title.String = "dB";
    c3.Title.Interpreter = 'latex';
    c3.Label.Interpreter = 'latex';
    c3.TickLabelInterpreter = 'latex';
    c3.FontSize = 14;
    caxis([-80 0]);
    axis square;
    drawnow;
end