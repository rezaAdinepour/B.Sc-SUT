function[S] = RampSig(T,Stn,Scw,Stf,N)
    T = round(T);

    % Begin Ramp Up
    R0  = 0;
    x = (0:(Stn*T-1))/(Stn*T-1);

    for n = 0:N
        R0 = R0+ nchoosek(N+n,n).*nchoosek(2*N+1,N-n).*(-x).^n;
    end

    XL = R0.*x.^(N+1);

    % Maximum Amplitude
    XM = ones(1,T*Scw);

    % Begin Ramp Down
    R0 = 0;
    x = (0:(Stf*T))/(Stf*T);
    
    for n = 0:N
        R0 = R0+ nchoosek(N+n,n).*nchoosek(2*N+1,N-n).*(-x).^n;
    end

    XR = 1 - R0.*x.^(N+1);

    % Put all three parts together
    S = cat(2,XL,XM,XR);
end