function R = myRouth(b)
%% ROUTH-HURWITZ Array
%
% Examples: 
%
% 1. P = s^4 + 10*s^3 + 35*s^2 + 50*s + 24 ;
%    R = myRouth( [1 10 35 50 24] )
%
% 2. syms a b c d s , P = s^4 + a*s^3 + b*s^2 + c*s + d ; 
%    R = myRouth( [1 a b c d] )
%
% 3. syms K , P = s^2 + (12-3*K)*s + 20+0.25*K ; 
%    R = myRouth( [1 12-3*K 20+0.25*K] )
% Ismail Ilker Delice 
% delice.i@neu.edu
%% Polynomial coefficients as input
if(nargin<1), warning('No Input Argument') ; return
end
%% Flip vector in left/right direction and find order of polynomial
b = fliplr(b) ;      
ord = size(b,2)-1 ; 
% It gives the index number of R11's row  
% ord = 6,7 --> rou_i = 7
rou_i = fix( fix(ord/2)*2 ) + 1 ;
rou_j = ceil((ord+1)/2) ;             % Round infinity
%% If order is even add one zero as a last element of matrix
Ri = [ b(ord+1:-2:1) ; 
       b(ord:-2:1)  zeros( fix(( rou_i-1 )/ord) ) ] ;
R = sym( zeros(ord+1,rou_j) )  ;  R(ord+1:-1:ord, : ) = Ri ;
%% All R's for Routh-Hurwitz [Main Algorithm]
for n = ord-1:-1:2
for j = 1:round(n/2)
R(n,j) = ( R(n+1,1)*R(n+2,j+1)-R(n+1,j+1)*R(n+2,1) )/R(n+1) ;
end
end
R(1,1) = R(rou_i,rou_j) ;
%% Simplify and Flip matrix in up/down direction.
R = simplify(R) ; R = flipud(R) ; 