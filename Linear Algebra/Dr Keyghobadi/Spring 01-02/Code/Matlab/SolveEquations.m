clear; clc; close all;


mat = input('enter matrix equations: ');
constMat = input('enter constant matrix: ');
X = sum(inv(mat).*(constMat), 2);

for i=1:length(constMat)
    fprintf('X%d = %f\n', i, X(i));
end