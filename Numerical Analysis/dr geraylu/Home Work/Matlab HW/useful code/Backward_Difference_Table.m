x1=input('Enter starting value of x:  ');
h= input('Intervel:  ');
x2=input('Ending value of x:  ');
x=x1:h:x2;
[c,n]=size(x); % counting the number of elements using SIZE command %
for i=1:n
    y(i,1)=input('Enter corresponding values of y:  ');
end
for j=2:n
    for i=j:n
        y(i,j)=y(i,j-1)-y(i-1,j-1); % formula to calculate backward difference
    end
end 
% print backward difference table
fprintf('\n******backward difference formula table****');
fprintf('\n\tx\t    y\t');
for i=1:n
    fprintf('\n   %.f',x(i));
    for j=1:i
        fprintf('\t   %.4f',y(i,j));
    end
end
