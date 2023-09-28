function[V] = Reduce_Matrix(V)
    % Reduce Repetitive Matrix
    
    [Nx,Ny,Nz] = size(V);
    if all(V == V(1,:,:))
      A = 1;
    else
      A = Nx;
    end
    if all(V == V(:,1,:))
      B = 1;
    else
      B = Ny;
    end
    if all(V == V(:,:,1))
      C = 1;
    else
      C = Nz;
    end
    V = V(1:A,1:B,1:C);
end