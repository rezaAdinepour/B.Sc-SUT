clear;clc;close all;

n = input('enter number of vector: ');
u = zeros(n);
innerVec = zeros(1, n*(n-1));
for i=1:n
    u(i, :) = input('enter your vector: ');
end

for i=1:n*(n-1)
    innerVec(i) = sum(conj(u(i, :)).*(u(i+1, :)))
end