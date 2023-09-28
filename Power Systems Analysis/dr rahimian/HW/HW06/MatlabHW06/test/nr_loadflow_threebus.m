
% ==========Power flow program using Newton-Raphson Method========= %
% By:                                                               %
% Abdul Wahab Korai @ University of Duisburg-Essen                  %                                             
%                                                                   %
% Date: 01/04/2015                                                  %                                        
% ================================================================= %   
%%
%------------------Important----------------------%
% load flow equations are non-linear in nature. To find the solution of such equations, it is assumed that 
% 1. solution exists thats is (f(x)=0)
% 2. equation are continuous and diffrentiable.
% How to solve these non-linear equations of power (P,Q) ?. 
% one can solve these equations by considering assumptions 1 and 2 and using linear
% approximation method (also known as newton-raphson method). also to be
% noted here is that the taylor series expnasion is the basis of the newton-raphson method.
% so if we have one equation whose solution we assume exists and is
% continuous and diffretiable then according to the newton-raphson 
%  f(x0)=-(x-x0)*f'(x0)   ----(1)
%  where x0 is our initial guess.Equation 1 here gives the linear approximation of the function f(x) at point x0.
%  this equation will always result in straight line (Tagent line of f(x) at the x0)
%  thus our solution in this case  by manipulating equation 1 will be 
%  x = x0-f(x0)/f'(x0) ------ (2) (updated value of x0)
% It should be noted that the equation 1 is linear equation , and higher order derivatives (higher than 1) are
% neglected. hence for the solution of f(x) (non- linear equation), an
% iterative method is required to match the solution we are looking for (because we have truncted the non-linear
% equation after first derivative, so obivously the solution will not be exact, so iterations are required to get the 
% exact solution). 
% Equation 1 can be used in matrix form, in that case, f'(x0), will be our
% Jacobian which is a  matrix of a first order partial derivatives of the non-linear 
% function (P,Q) evaluated at x0. 
%___________________________________________________________________________
%---------------Bascis-----------------%
% When applied to power flow problem, the newton raphson is used to solve
% for a vector of bus voltage magnitudes and angles i.e.
% x = [angle;abs(V)]
% Things to note  :
% 1) the voltage and angle at the swing bus is specified and therefore not part of the the solution vector
% 2) the bus voltage magnitudes at PV buses are specified and therefore not
% part of abs (V). Only the bus voltage magnitudes of PQ buses are included
% 3) angle includes all PQ and PV buses
% therefore vector x is an m*1 vector with 
% m = 2*n_pq+n_pv   ; Where n_pq are number of PQ buses and n_pv are number
% of PV buses
% __________________________________________________________________________
%------------------Start of load flow program--------------%
% Three bus system . Bus 1 = Slack, Bus 2 = PV and bus 3 = PQ
clear all
clc
j = sqrt(-1);
V = zeros(3,1);
S = zeros(3,1);
Mismatch = zeros(3,1);
%------------------ Base values----------------%
kVLL=345; 
MVA3Ph=100; 
Zbase=kVLL^2/MVA3Ph;
%%%%%%%---------- line parameters in ohms/km----------%
XL_km=0.376; 
RL_km= 0.037; B_km=4.5; 
%---------Line Susceptances--------%
B13_Micro_Mho=4.5*200; %200 km long
B12_Micro_Mho=4.5*150; %150 km long
B23_Micro_Mho=4.5*150; %150 km long
%---------Line impedances------------%
Z13_ohm=(RL_km+j*XL_km)*200; %200 km long
Z12_ohm=(RL_km+j*XL_km)*150; %150 km long
Z23_ohm=(RL_km+j*XL_km)*150; %150 km long
%------- line impedances in per unit--------%
Z13=Z13_ohm/Zbase;
Z12=Z12_ohm/Zbase;
Z23=Z23_ohm/Zbase; 
%-------- susceptances in per unit----------%
B13=B13_Micro_Mho*Zbase*10^-6;
B12=B12_Micro_Mho*Zbase*10^-6; 
B23=B23_Micro_Mho*Zbase*10^-6; 
%---------- YBUS Creation-------------%
Y(1,1)=1/Z12 + 1/Z13; 
Y(1,2)=-1/Z12; 
Y(1,3)=-1/Z13;
Y(2,1)=-1/Z12; 
Y(2,2)=1/Z12 + 1/Z23;
Y(2,3)=-1/Z23;
Y(3,1)=-1/Z13;
Y(3,2)=-1/Z23;
Y(3,3)=1/Z13 + 1/Z23;
Y;  % Print Y=G+jB Admittance Matrix
%----------Conductance Values------------%
G(1,1)=real(Y(1,1)); 
G(1,2)=real(Y(1,2)); 
G(1,3)=real(Y(1,3)); 
G(2,1)=real(Y(2,1)); 
G(2,2)=real(Y(2,2)); 
G(2,3)=real(Y(2,3)); 
G(3,1)=real(Y(3,1)); 
G(3,2)=real(Y(3,2)); 
G(3,3)=real(Y(3,3));
%--------Susceptance Values----------%
B(1,1)=imag(Y(1,1)); 
B(1,2)=imag(Y(1,2)); 
B(1,3)=imag(Y(1,3));
B(2,1)=imag(Y(2,1));
B(2,2)=imag(Y(2,2));
B(2,3)=imag(Y(2,3));
B(3,1)=imag(Y(3,1));
B(3,2)=imag(Y(3,2)); 
B(3,3)=imag(Y(3,3));
%--------- Given Specifications in pu (Known)----------%
V1MAG=1.0;   
ANG1=0;    
V2MAG=1.05;  
P2sp=1.0;   
P3sp=-0.9; 
Q3sp=-0.6;
% -------------Calulate ANG2, V3MAG and ANG3---------------%
% ----Solution Parameters----%
Tolerance= 0.001; 
Iter_Max=25;
%----- Initialization-------%
Iter=0; 
i=0;
ConvFlag=1; 
delANG2=0; 
delANG3=0; 
delMAG3=0;
%-------------- to be determined (Flat start)-----------%%%%%%%%
ANG2=0; 
ANG3=0; 
V3MAG=1.0;
%------------------ Start Iteration Process for N-R-----------------%
 while( ConvFlag==1 && Iter < Iter_Max)
 Iter=Iter+1;
 i=i+1;
 %%----------- update the Voltage and Angles to calculate new jacobian---%
ANG2=ANG2+delANG2; 
ANG3=ANG3+delANG3;
V3MAG=V3MAG+delMAG3;
%------- Creation of Jacobian J--------%
% ------ delP2/delANG2=J(1,1)
J(1,1) = V2MAG*(V1MAG*(B(2,1)*cos(ANG2-ANG1)-G(2,1)*sin(ANG2-ANG1))+V3MAG*(B(2,3)*cos(ANG2-ANG3)-G(2,3)*sin(ANG2-ANG3)));
%%%%--------- delP2/delANG3 = J(1,2)------------%
J(1,2)=V2MAG*V3MAG*(G(2,3)*sin(ANG2-ANG3)-B(2,3)*cos(ANG2-ANG3));
%%%%%%%------ delP2/delV3Mag = J(1,3)--------%
J(1,3) = V2MAG*(G(2,3)*cos(ANG2-ANG3)+B(2,3)*sin(ANG2-ANG3));
%%%%%%%%%%%--- delP3/delANG2 = J(2,1)---------%%%
J(2,1) = V3MAG*V2MAG*(G(3,2)*sin(ANG3-ANG2)-B(3,2)*cos(ANG3-ANG2));
%%%%%%%%%%%-------delP3/delANG3 = J(2,2)-----------------%%
J(2,2)= V3MAG*(V1MAG*(B(3,1)*cos(ANG3-ANG1)-G(3,1)*sin(ANG3-ANG1))+V2MAG*(B(3,2)*cos(ANG3-ANG2)-G(3,2)*sin(ANG3-ANG2)));
%%%%%%%%%%%----------delP3/delV3MAG = J(2,3)------%
J(2,3) = 2*G(3,3)*V3MAG+V1MAG*(G(3,1)*cos(ANG3-ANG1)+B(3,1)*sin(ANG3-ANG1)+V2MAG*(G(3,2)*cos(ANG3-ANG2)+B(3,2)*sin(ANG3-ANG2)));
%%%%%%%%%--------------delQ3/delANG2 = J(3,1)--------%
J (3,1)= -V3MAG*V2MAG*(G(3,2)*cos(ANG3-ANG2)+B(3,2)*sin(ANG3-ANG2));
%%%%%%%%%% ----------------delQ3/delANG3 = J(3,2)--------%
J(3,2) =  V3MAG*(V1MAG*(B(3,1)*cos(ANG3-ANG1)+G(3,1)*sin(ANG3-ANG1))+V2MAG*(B(3,2)*cos(ANG3-ANG2)+G(3,2)*sin(ANG3-ANG2)));
%%%%%%%%%%-------------delQ3/delV3MAG = J(3,3)------%
J(3,3) = -2*B(3,3)*V3MAG+V1MAG*(G(3,1)*cos(ANG3-ANG1)-B(3,1)*sin(ANG3-ANG1)+V2MAG*(G(3,2)*cos(ANG3-ANG2)-B(3,2)*sin(ANG3-ANG2)));
J = [J(1,1) J(1,2) J(1,3);J(2,1) J(2,2) J(2,3); J(3,1) J(3,2) J(3,3)];
%%%%%%% calculation of updated voltages with angles %%%%%%%%%%%%
V(1) = V1MAG*exp(1i*ANG1);
V(2)= V2MAG*exp(1i*ANG2);
V(3) = V3MAG*exp(1i*ANG3);
%%%%%%%----------- Current injections at each bus based on updated voltages and angles----------%%%%%%%%%
I = Y*V;
%%%%%%%%%----------calculation of P and Q-----------%%%%%%%%%%%
S(1) = V(1)*conj(I(1));
S(2) = V(2)*conj(I(2));
S(3) = V(3)*conj(I(3));
%%%%%%%%%%%------------- Mistmatches--------------%%%%%%%%%%
Mismatch(1) = P2sp-real(S(2));
Mismatch(2) = P3sp-real(S(3));
Mismatch(3) = Q3sp-imag(S(3));
%%%%%%%-------- calculate the deltaANG and deltaVMAG-----------%%%%%%%
del=inv(J)*Mismatch;  % for large matrices, this mathod is bad. 
% Always use LU factorization to solve this linear equation. 
delANG2 = del(1);
delANG3 = del(2);
delMAG3 = del(3);
%%%%%%%%%%%----------- Calculate power flow on transmission line-------%%
P12 = real(V(1))*conj((V(1)-V(2))/Z12);
P13 = real(V(1))*conj((V(1)-V(3))/Z13);
P21 = real(V(2))*conj((V(2)-V(1))/Z12);
P23 = real(V(2))*conj((V(2)-V(3))/Z23);
P31 = real(V(3))*conj((V(3)-V(1))/Z13);
P32 = real(V(3))*conj((V(3)-V(2))/Z23);
Q12 = imag(V(1))*conj((V(1)-V(2))/Z12);
Q13 = imag(V(1))*conj((V(1)-V(3))/Z13);
Q21 = imag(V(2))*conj((V(2)-V(1))/Z12);
Q23 = imag(V(2))*conj((V(2)-V(3))/Z23);
Q31 = imag(V(3))*conj((V(3)-V(1))/Z13);
Q32 = imag(V(3))*conj((V(3)-V(2))/Z23);
P1 = real(S(1));
Q1 = imag(S(1));
P2 = real(S(2));
Q2 = imag(S(2));
P3 = real(S(3));
Q3 = imag(S(3));
%%%%%%%%%%-----------Display the results -----------%%%%%%%%%%%%%%%%
fprintf('\n %s %2d %s \n', 'Iter ',Iter, ' Mismatch 1 Mismatch 2 Mismatch 3 ')
fprintf(' %7.4f %7.4f %7.4f \n', Mismatch(1),Mismatch(2), Mismatch(3) );
if max(abs(Mismatch)> Tolerance)
    
ConvFlag = 1;
else
    ConvFlag = 0;
end
 end
 J;
%radians into degrees
ANG2DEG=ANG2*180/pi
ANG3DEG=ANG3*180/pi 
V3MAG
