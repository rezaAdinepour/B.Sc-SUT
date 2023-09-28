function[Jxjx,Jxjy,Jxjz,Jyjx,Jyjy,Jyjz,...
         Jzjx,Jzjy,Jzjz,Jxex,Jxey,Jxez,...
         Jyex,Jyey,Jyez,Jzex,Jzey,Jzez] =...
         JE_Coef_elec(e0,ve,dtc,wpe,wce_x,wce_y,wce_z)

    % Coeffcients Needed for J Update Equation
    % Assign Matrix Components     
    x11 = 1+ve*dtc/2;
    x12 = -dtc/2*wce_z;
    x13 = dtc/2*wce_y;
    x21 = dtc/2*wce_z;
    x22 = 1+ve*dtc/2;
    x23 = -dtc/2*wce_x;
    x31 = -dtc/2*wce_y;
    x32 =  dtc/2*wce_x;
    x33 = 1+ve*dtc/2;
    y11 = 1-ve*dtc/2;
    y12 = dtc/2*wce_z;
    y13 = -dtc/2*wce_y;
    y21 = -dtc/2*wce_z;
    y22 = 1-ve*dtc/2;
    y23 = dtc/2*wce_x;
    y31 = dtc/2*wce_y;
    y32 = -dtc/2*wce_x;
    y33 = 1-ve*dtc/2;
         
    % Current Coefficients
    d = x11.*(x22.*x33-x23.*x32)-...  % Matrix A Determinate
        x12.*(x21.*x33-x23.*x31)+...
        x13.*(x21.*x32-x22.*x31);
    dEi = dtc.*e0.*wpe.^2./d;         % Constant for Matrix dtc*e0*wpe.^2.*A^-1

    % Jx
    Jxjx = (y11.*(x22.*x33-x23.*x32)+...
            y21.*(x21.*x33-x23.*x31)+...
            y31.*(x21.*x32-x22.*x31))./d;
    Jxjy = (y12.*(x22.*x33-x23.*x32)+...
            y22.*(x21.*x33-x23.*x31)+...
            y32.*(x21.*x32-x22.*x31))./d;
    Jxjz = (y13.*(x22.*x33-x23.*x32)+...
            y23.*(x21.*x33-x23.*x31)+...
            y33.*(x21.*x32-x22.*x31))./d;
    % Jy
    Jyjx = (y11.*(x12.*x33-x13.*x32)+...
            y21.*(x11.*x33-x13.*x31)+...
            y31.*(x11.*x32-x12.*x31))./d;
    Jyjy = (y12.*(x12.*x33-x13.*x32)+...
            y22.*(x11.*x33-x13.*x31)+...
            y32.*(x11.*x32-x12.*x31))./d;
    Jyjz = (y13.*(x12.*x33-x13.*x32)+...
            y23.*(x11.*x33-x13.*x31)+...
            y33.*(x11.*x32-x12.*x31))./d;
        
    % Jz
    Jzjx = (y11.*(x12.*x23-x13.*x22)+...
            y21.*(x11.*x23-x13.*x21)+...
            y31.*(x11.*x22-x12.*x21))./d;
    Jzjy = (y12.*(x12.*x23-x13.*x22)+...
            y22.*(x11.*x23-x13.*x21)+...
            y32.*(x11.*x22-x12.*x21))./d;
    Jzjz = (y13.*(x12.*x23-x13.*x22)+...
            y23.*(x11.*x23-x13.*x21)+...
            y33.*(x11.*x22-x12.*x21))./d;
    % JxE
    Jxex = dEi.*(x22.*x33-x23.*x32);
    Jxey = dEi.*(x21.*x33-x23.*x31);
    Jxez = dEi.*(x21.*x32-x22.*x31);

    % JyE
    Jyex = dEi.*(x12.*x33-x13.*x32);
    Jyey = dEi.*(x11.*x33-x13.*x31);
    Jyez = dEi.*(x11.*x32-x12.*x31);

    % JzE
    Jzex = dEi.*(x12.*x23-x13.*x22);
    Jzey = dEi.*(x11.*x23-x13.*x21);
    Jzez = dEi.*(x11.*x22-x12.*x21);

    % Reduce Redundent Dimensions
    [Jxjx] = Reduce_Matrix(Jxjx);
    [Jxjy] = Reduce_Matrix(Jxjy);
    [Jxjz] = Reduce_Matrix(Jxjz);
    [Jyjx] = Reduce_Matrix(Jyjx);
    [Jyjy] = Reduce_Matrix(Jyjy);
    [Jyjz] = Reduce_Matrix(Jyjz);
    [Jzjx] = Reduce_Matrix(Jzjx);
    [Jzjy] = Reduce_Matrix(Jzjy);
    [Jzjz] = Reduce_Matrix(Jzjz);
    [Jxex] = Reduce_Matrix(Jxex);
    [Jxey] = Reduce_Matrix(Jxey);
    [Jxez] = Reduce_Matrix(Jxez);
    [Jyex] = Reduce_Matrix(Jyex);
    [Jyey] = Reduce_Matrix(Jyey);
    [Jyez] = Reduce_Matrix(Jyez);
    [Jzex] = Reduce_Matrix(Jzex);
    [Jzey] = Reduce_Matrix(Jzey);
    [Jzez] = Reduce_Matrix(Jzez);
end