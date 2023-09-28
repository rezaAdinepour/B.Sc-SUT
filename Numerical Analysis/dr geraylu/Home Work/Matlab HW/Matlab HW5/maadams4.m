function [x y]=maadams4(dyfun,xspan,y0,h)
% use four-step Adams predictor-corrector method to solve an ODE y'=f(x,y), y(x0)=y0
% inputs: dyfun -- the function f(x,y), as an inline
% xspan -- the interval [x0,xn]
% y0 -- the initial value
% h -- the step size
% output: x, y -- the node and the value of y
x=xspan(1):h:xspan(2);
% use Runge-Kutta method to get four initial values
[xx,yy]=marunge(dyfun,[x(1),x(4)],y0,h);
y(1)=yy(1);y(2)=yy(2);
y(3)=yy(3);y(4)=yy(4);
for n=4:(length(x)-1)
p=y(n)+h/24*(55*feval(dyfun,x(n),y(n))-59*feval(dyfun,x(n-1),y(n-1))+37*feval(dyfun,x(n-2),y(n-2))-9*feval(dyfun,x(n-3),y(n-3)));
y(n+1)=y(n)+h/24*(9*feval(dyfun,x(n+1),p)+19*feval(dyfun,x(n),y(n))-5*feval(dyfun,x(n-1),y(n-1))+feval(dyfun,x(n-2),y(n-2)));
end
x=x';y=y';