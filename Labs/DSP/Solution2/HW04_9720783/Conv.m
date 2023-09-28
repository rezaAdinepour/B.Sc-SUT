function Y = Conv(X,H)

z = [];
for i = 1:length(X)
    g = H.*X(i);
    z = [z;g];
end

[r c]=size(z);
k=r+c;
t=2;
Y=[];
cd=0;

while(t<=k)
    for i=1:r
        for j=1:c
            if((i+j)==t)
                cd = cd + z(i,j);
            end
        end
    end
    
t=t+1;
Y=[Y cd];
cd=0;

end

end