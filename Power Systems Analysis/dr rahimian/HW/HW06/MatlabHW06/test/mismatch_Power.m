
function [mismatch_PQ]=mismatch_Power(P_neta,Q_neta,P_cal,Q_cal,nodes,PQ,nPQ)    
% Mismatch Power
    dP=P_neta-P_cal; 
    dQ=Q_neta-Q_cal;
    l=1;
    mismatch_Q=zeros(nPQ,1);%Build the  mismatch Q vector
    for k=1:nPQ
        n=PQ(k);
        mismatch_Q(l,1)=dQ(n);
        l=l+1;
    end
    mismatch_P=dP(2:nodes); %Build the  mismatch P vector non including the slack bus
    mismatch_PQ=[mismatch_P;mismatch_Q]; % Mismatch vector  [dP;dQ]
end
