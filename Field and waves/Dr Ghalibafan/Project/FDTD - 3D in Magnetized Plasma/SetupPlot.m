function[I1] = SetupPlot(Ez,Ne,x,y,dx,dy)
    % ImageSC Plot
    E  = abs(Ez(:,:,end/2)); 
    E  = 10*log10(E); 
    E(isinf(E)|isnan(E)) = 10*log10(eps);
    ne = cat(1,Ne,Ne(end,:,:));
    ne = cat(2,ne,ne(:,end,:));
    ne = ne(:,:,end/2);
    y = cat(2,y,y(end)+dy);
    x = cat(2,x,x(end)+dx);
    figure(2)
    set(gcf,'units','normalized','position',[0.01 0.1 .98 .55])

    % Create two axes
    ax1 = axes;
    I1 = imagesc(ax1,y,x,E);
    title(['3D FDTD - Meteor $$\mid$$ ',...
        '$$\mid$$ 10log$$_{10}$$($$\left|E_z\right|$$)'],'fontsize',18)
    xlabel('X - [meters]'); ylabel('Y - [meters]')
    caxis([-80 0])
    ax2 = axes;
    contour(ax2,y,x,ne,40,'linewidth',1)

    % Link them together
    linkaxes([ax1,ax2])

    % Hide the top axes
    ax2.Visible = 'off';
    ax2.XTick = [];
    ax2.YTick = [];

    % Give each one its own colormap
    colormap(ax2,'bone')
    colormap(ax1,'turbo')

    % alpha(ax2,.5)
    % Then add colorbars and get everything lined up
    set([ax1,ax2],'Position',[.17 .11 .685 .815]);
    cb1 = colorbar(ax1,'Position',[.1 .11 .0275 .815]);
    cb2 = colorbar(ax2,'Position',[.88 .11 .0275 .815]);
    cb1.Title.String = "dB";
    cb1.Title.Interpreter = 'latex';
    cb1.Label.Interpreter = 'latex';
    cb1.TickLabelInterpreter = 'latex';
    cb1.FontSize = 14;
    cb2.Title.String = "$$n_e$$";
    cb2.Title.Interpreter = 'latex';
    cb2.Label.Interpreter = 'latex';
    cb2.TickLabelInterpreter = 'latex';
    cb2.FontSize = 14;
    drawnow
end