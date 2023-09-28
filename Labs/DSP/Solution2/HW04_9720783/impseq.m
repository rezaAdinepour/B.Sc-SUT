function [x,n]=impseq(n0,n1,n2)
    n=n1:n2;
    x=[(n-n0)==0];      %Output(x) is Logical
    stem(n,x,'r','linewidth',1.5)
    xlim([n1-1 n2+1])
    ylim([-0.2 1.2])
    grid on 
    
end