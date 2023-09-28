clear;clc;close all;
delx=0.2;
x=0.1:delx:1.1;
y=[1.710 1.713 1.724 1.748 1.789 1.849];
n=6;
for i=1:n
    diff(i,1)=y(i);
end
for j=2:n
    for i=1:n-j+1
        diff(i,j)=diff(i+1,j-1)-diff(i,j-1);
    end
end
fprintf('\n******forward difference formula table****');
fprintf('\n\tx\t     y\t        del1\t    del2\t    del3\t    del4');
for i=1:n
    fprintf('\nx%d=%1.1f',i-1, x(i));
    for j=1:n-i+1
        fprintf('\t   %.4f',diff(i,j));
    end
end