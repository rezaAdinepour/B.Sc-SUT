function[] = graphDefaults()
    set(groot,'defaulttextinterpreter','latex');  
    set(groot, 'defaultAxesTickLabelInterpreter','latex');  
    set(groot, 'defaultLegendInterpreter','latex');
    set(groot,'DefaultFigureColormap',feval('turbo'));
    set(0,'defaultfigurecolor',[1 1 1])
end