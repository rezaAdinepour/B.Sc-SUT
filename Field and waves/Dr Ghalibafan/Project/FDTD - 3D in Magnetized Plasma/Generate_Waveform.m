function[S] = Generate_Waveform(f0,BW,nt,dt)
    % Sin-Modulated Gaussian
    t    = (0:nt)*dt;          % Time Steps in dt
    tau  = 0.966/(BW*f0);      % Gaussian Waveform Variable
    t0   = 4.5*tau;            % Gaussian Waveform Offset
    S    = sin(2*pi*f0*(t-t0)).*exp(-((t-t0)/tau).^2);
end
