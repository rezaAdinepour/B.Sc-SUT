function [x,n]=step(n0,n1,n2)
    n=n1:n2;
    x=(n-n0)>=0;     %Output(x) is Logical      
    stem(n,x,'b','linewidth',1.5)
    title('Step')
    ylabel('X(n-n0)')
    xlabel('n')
    xlim([n1-2 n2+3])
    ylim([-0.5 1.5])
    grid on 
end