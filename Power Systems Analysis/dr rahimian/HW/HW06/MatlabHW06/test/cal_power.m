function [P_cal,Q_cal]=cal_power(G,B,nodes,Tetha,V)
    % The function gets the power of all buses non including the slack
    P_cal=zeros(nodes,1);
    Q_cal=zeros(nodes,1);
    for k = 1:nodes
        for m = 1:nodes
            P_cal(k) = P_cal(k) + V(k)*V(m)*( G(k,m)*cos(Tetha(k)-Tetha(m)) + B(k,m)*sin(Tetha(k)-Tetha(m)));
            Q_cal(k) = Q_cal(k) + V(k)*V(m)*( G(k,m)*sin(Tetha(k)-Tetha(m)) - B(k,m)*cos(Tetha(k)-Tetha(m)));
        end
    end
end