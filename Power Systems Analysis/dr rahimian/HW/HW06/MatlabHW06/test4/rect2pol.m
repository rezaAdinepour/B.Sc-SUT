% Polar to Rectangular Conversion
% Praviraj P G, MTech I Year, EE Dept., IIT Roorkee, India, Email :pravirajpg@gmail.com
% [RHO THETA] = RECT2POL(X)
% X - Complex matrix or number, X = A + jB
% RHO - Magnitude
% THETA - Angle in radians
function [rho theta] = rect2pol(x)
rho = abs(x);
theta = angle(x);
