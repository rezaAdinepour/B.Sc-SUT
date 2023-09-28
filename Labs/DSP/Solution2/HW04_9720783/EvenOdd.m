function [Xe,Xo,Sum,n1]=EvenOdd(x,n)
    %------------------------------
    x1=fliplr(x);        %Create x1=x(-n)
    n1=fliplr(-n);       %Create new axis          
    Xe=0.5*(x+x1);
    Xo=0.5*(x-x1);
    Sum=Xe+Xo;
    %------------------------------
    figure(1)
    subplot(2,1,1)
    stem(n1,Xe,'r','linewidth',2.2)
    title('X_E')
    xlabel('n')
    grid minor
    subplot(2,1,2)
    stem(n1,Xo,'b','linewidth',2.2)
    title('X_O')
    xlabel('n')
    grid minor
    %------------------------------
    figure(2)
    subplot(2,1,1)
    stem(n,x,'g','linewidth',2.2)
    title('X(n)')
    xlabel('n')
    grid minor
    subplot(2,1,2)
    stem(n,Sum,'k','linewidth',2.2)
    title('X_E+X_O')
    xlabel('n')
    grid minor
    %------------------------------   
end