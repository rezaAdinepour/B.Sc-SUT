
function [J]=Jacobian(G,B,V,Tetha,nodes,PQ,nPQ)
% Build submatrixes
J1 = zeros(nodes-1,nodes-1);
J2 = zeros(nodes-1,nPQ);
J3 = zeros(nPQ,nodes-1);
J4 = zeros(nPQ,nPQ);
%%
%J1 [dPk/dTethaj]
for k=2:nodes% k, position of the row, slack bar is not included so the for is initialized from 2
    for j=2:nodes %j, column position
        if (j==k)  % Element of the diagonal, the normal summation is made but the diagonal term is subtracted
        for m=1:nodes % Sum of each element
            J1(k-1,j-1)=J1(k-1,j-1)+(V(k)*V(m))*(-G(k,m)*sin(Tetha(k)-Tetha(m))+B(k,m)*cos(Tetha(k)-Tetha(m)));
        end
            J1(k-1,j-1)=J1(k-1,j-1)-(V(k)^2)*B(k,k);% subtracts the element when m = k, since its derivative is zero
        else% non digonal element
            J1(k-1,j-1)=V(k)*V(j)*(G(k,j)*sin(Tetha(k)-Tetha(j))-B(k,j)*cos(Tetha(k)-Tetha(j)));
        end
    end
end
%%
%J2 [dPk/dV_j]
for k=2:nodes % k, position of the row, slack bar is not included so the for is initialized from 2
    for j=1:nPQ %j, column position
        m=PQ(j);
        if (m==k) % Element of the diagonal, the normal summation is made but the diagonal term is subtracted
        for m=1:nodes% Sum of each element
            J2(k-1,j)=J2(k-1,j)+V(m)*(G(k,m)*cos(Tetha(k)-Tetha(m))+B(k,m)*sin(Tetha(k)-Tetha(m)));
        end
            J2(k-1,j)=J2(k-1,j)+(V(k))*G(k,k);% add an element when m = k, when m=k its derivate contains a term of 2V(k)
        else% non diagonal element
            J2(k-1,j)=V(k)*(G(k,m)*cos(Tetha(k)-Tetha(m))+B(k,m)*sin(Tetha(k)-Tetha(m)));
        end
    end
end
%%
%J3 [dQk/dTeth_j]
for k=1:nPQ% k, position of the row, slack bar is not included so the for is initialized from 2
    n=PQ(k);
    for j=2:nodes  %j, column position
        if (j==n)  % Element of the diagonal, the normal summation is made but the diagonal term is subtracted
        for m=1:nodes% Sum of each element
            J3(k,j-1)=J3(k,j-1)+(V(n)*V(m))*(G(n,m)*cos(Tetha(n)-Tetha(m))+B(n,m)*sin(Tetha(n)-Tetha(m)));
        end
            J3(k,j-1)=J3(k,j-1)-(V(n)^2)*G(n,n); % add an element when m = k, when m=k its derivate contains a term of 2V(k)
        else% a non diagonal element, just has one term
            J3(k,j-1)=V(n)*V(j)*(-G(n,j)*cos(Tetha(n)-Tetha(j))-B(n,j)*sin(Tetha(n)-Tetha(j)));
        end
    end
end
%%
%J4 [dQk/dV_j]
for k=1:nPQ% k, position of the row, slack bar is not included so the for is initialized from 2
    n=PQ(k);
    for j=1:nPQ %j, column position
        m=PQ(j);
        if (m==n)  % Element of the diagonal, the normal summation is made but the diagonal term is subtracted
        for m=1:nodes% Sum of each element
            J4(k,j) = J4(k,j) + V(m)*(G(n,m)*sin(Tetha(n)-Tetha(m)) - B(n,m)*cos(Tetha(n)-Tetha(m)));
        end
            J4(k,j)=J4(k,j)-V(n)*B(n,n);% add an element when m = k, when m=k its derivate contains a term of 2V(k)
        else% a non diagonal element, just has one term
            J4(k,j)=V(n)*(G(n,m)*sin(Tetha(n)-Tetha(m))- B(n,m)*cos(Tetha(n)-Tetha(m)));
        end
    end
end
%%
J=[J1 J2;J3 J4];
end
