
%   Power flow solution by Newton-Raphson method
%   Copyright (c) 1998 by  H. Saadat
clear all;clc;
%format short;
basemva=100; 
%[b(: ,1),b(: ,2),b(: ,3),b(: ,4),b(: ,5),b(:,6)]=textread('linedata30.txt',' %f %f %f %f %f %f');
%linedata=b;
%[a(: ,1),a(: ,2),a(: ,3),a(: ,4),a(: ,5),a(: ,6),a(: ,7),a(: ,8),a(: ,9),a(: ,10),a(: ,11)]=textread('busdata30.txt','%f %f %f %f %f %f %f %f %f %f %f');
%busdata=a;
linedata=[1   2   0.0192   0.0575   0.02640    1;
          1   3   0.0452   0.1852   0.02040    1;
          2   4   0.0570   0.1737   0.01840    1;
          3   4   0.0132   0.0379   0.00420    1;
          2   5   0.0472   0.1983   0.02090    1;
          2   6   0.0581   0.1763   0.01870    1;
          4   6   0.0119   0.0414   0.00450    1;
          5   7   0.0460   0.1160   0.01020    1;
          6   7   0.0267   0.0820   0.00850    1;
          6   8   0.0120   0.0420   0.00450    1;
          6   9   0.0      0.2080   0.0    0.978;
          6  10   0         .5560   0      0.969;
          9  11   0         .2080   0          1;
          9  10   0         .1100   0          1;
          4  12   0         .2560   0      0.932;
         12  13   0         .1400   0          1;
         12  14    .1231    .2559   0          1;
         12  15    .0662    .1304   0          1;
         12  16    .0945    .1987   0          1;
         14  15    .2210    .1997   0          1;
         16  17    .0824    .1923   0          1;
         15  18    .1073    .2185   0          1;
         18  19    .0639    .1292   0          1;
         19  20    .0340    .0680   0          1;
         10  20    .0936    .2090   0          1;
         10  17    .0324    .0845   0          1;
         10  21    .0348    .0749   0          1;
         10  22    .0727    .1499   0          1;
         21  22    .0116    .0236   0          1;
         15  23    .1000    .2020   0          1;
         22  24    .1150    .1790   0          1;
         23  24    .1320    .2700   0          1;
         24  25    .1885    .3292   0          1;
         25  26    .2544    .3800   0          1;
         25  27    .1093    .2087   0          1;
         28  27     0       .3960   0      0.968;
         27  29    .2198    .4153   0          1;
         27  30    .3202    .6027   0          1;
         29  30    .2399    .4533   0          1;
          8  28    .0636    .2000   0.0214     1;
          6  28    .0169    .0599   0.065      1];
      
   %   Busdata   
busdata=[1   1    1.06    0.0     0.0   0.0    0.0  0.0   0   0       0;
         2   2    1.043   0.0   21.70  12.7   40.0  0.0 -40  50       0;
         3   0    1.0     0.0     2.4   1.2    0.0  0.0   0   0       0;
         4   0    1.06    0.0     7.6   160   0.0  0.0   0   0       0;
         5   2    1.01    0.0    94.2  19.0    0.0  0.0 -40  40       0;
         6   0    1.0     0.0     0.0   0.0    0.0  0.0   0   0       0;
         7   0    1.0     0.0    22.8  10.9    0.0  0.0   0   0       0;
         8   2    1.01    0.0    30.0  30.0    0.0  0.0 -10  60       0;
         9   0    1.0     0.0     0.0   0.0    0.0  0.0   0   0       0;
        10   0    1.0     0.0     5.8   2.0    0.0  0.0   0   0      19;
        11   2    1.082   0.0     0.0   0.0    0.0  0.0  -6  24       0;
        12   0    1.0     0       11.2  7.5    0    0     0   0       0;
        13   2    1.071   0        0    0.0    0    0    -6  24       0;
        14   0    1       0       6.2   1.6    0    0     0   0       0;
        15   0    1       0       8.2   2.5    0    0     0   0       0;
        16   0    1       0       3.5   1.8    0    0     0   0       0;
        17   0    1       0       9.0   5.8    0    0     0   0       0;
        18   0    1       0       3.2   0.9    0    0     0   0       0;
        19   0    1       0       9.5   3.4    0    0     0   0       0;
        20   0    1       0       2.2   0.7    0    0     0   0       0;
        21   0    1       0      17.5  11.2    0    0     0   0       0;
        22   0    1       0       0     0.0    0    0     0   0       0;
        23   0    1       0       3.2   1.6    0    0     0   0       0;
        24   0    1       0       8.7   6.7    0    0     0   0      4.3;
        25   0    1       0       0     0.0    0    0     0   0       0;
        26   0    1       0       3.5   2.3    0    0     0   0       0;
        27   0    1       0       0     0.0    0    0     0   0       0;
        28   0    1       0       0     0.0    0    0     0   0       0;
        29   0    1       0       2.4   0.9    0    0     0   0       0;
        30   0    1       0      10.6   1.9    0    0     0   0       0 ] ;
      %=============&&&&&&================%  
nbus = length(busdata(:,1)); % s? l??ng nút
nbr = length(linedata(:,1));   % s? l??ng nhánh
nl=linedata(:,1);%  Véc t? s? nút ??u
nr=linedata(:,2); % véc t? s? nút cu?i
kb=busdata(:,2); % mã nút
Vm=busdata(:,3);% Biên ?? ?i?n áp nút
delta=busdata(:, 4);% Góc pha ban ??u c?a ?i?n áp nut 
Pd=busdata(:,5);     % Công su?t P t?i 
Qd=busdata(:,6);    % Công su?t Q t?i
Pg=busdata(:,7);    % Công su?t P máy phát bom vào nút
Qg = busdata(:,8);  % Công su?t Q máy phát b?m vào nút
Qmin=busdata(:, 9)/basemva;  % Gi?i h?n Qmin máy phát
Qmax=busdata(:, 10)/basemva;  % Gi?i h?n Qmax máy phát
Qsh=busdata(:, 11);  % Giá tr? Qbù b?m vào nút
             %  =======TINH CONG SUAT BAN DAU=====
P=(Pg-Pd)/basemva;
Q=(Qg-Qd+ Qsh)/basemva;
S=P+j*Q;
                %=========&&&&&&=============%
     % CHUONG TRINH TINH Ybus
     %=============&&&&&&================%
      R=linedata(:,3);
      X=linedata(:,4);
      Z=R+j*X;
      B = j*linedata(:,5);
      y=ones(nbr,1)./Z;
      a = linedata(:, 6);
               % TAO MATRAN Ybus
Ybus=zeros(nbus,nbus);     % Tao ma tran Ybus bang zero
               % Tao duong cheo phu cuar Ybus
   for k=1:nbr;
       Ybus(nl(k),nr(k))=-y(k)/a(k);
       Ybus(nr(k),nl(k))=Ybus(nl(k),nr(k));
   end
              % tao duong cheo chinh cua Ybus
for  n=1:nbus
     for k=1:nbr
         if nl(k)==n
         Ybus(n,n) = Ybus(n,n)+y(k)/(a(k))^2+B(k);
         elseif nr(k)==n
         Ybus(n,n) = Ybus(n,n)+y(k) + B(k);
        end
     end
end
Ym=abs(Ybus);
t = angle(Ybus);
maxerror = 1; iter = 0;converge=1;accuracy=1e-4; maxiter=100; 
while maxerror > accuracy & iter < maxiter
p0=find(kb==2);
sl=find(kb==1);
p2=find(kb==0);
iter=iter+1;
Ps=zeros(nbus,1);
Qs=zeros(nbus,1);
P=(Pg-Pd)/basemva;
Q=(Qg-Qd+ Qsh)/basemva;
S=P+j*Q;
for k=1:nbus
    if kb(k)~=1
        for m=1:nbus
          Ps(k)=Ps(k)+Vm(k)*Vm(m)*Ym(k,m)*cos(t(k,m)-delta(k)+delta(m));
          Qs(k)=Qs(k)-Vm(k)*Vm(m)*Ym(k,m)*sin(t(k,m)-delta(k)+delta(m));
        end
    end
    if kb(k)==1
        Qs(k)=0;
    end
end 
dP=P-Ps;
dP(sl)=[];
dQ=Q-Qs;
for i=length(dQ):-1:1
    if kb(i)==2 | kb(i)==1
        dQ(i)=[];
    end
end
dPdQ=[dP;dQ];
maxerror=max(abs(dPdQ));
    %   TAO MA TRAN JACOBI
J1=zeros(nbus,nbus);J2_1=zeros(nbus,nbus);J2=zeros(nbus,nbus);
J3=zeros(nbus,nbus);J4_1=zeros(nbus,nbus);J4=zeros(nbus,nbus);
 for i=1:nbus
      J2_1(i,i)=2*Vm(i)*Ym(i,i)*cos(t(i,i));
      J4_1(i,i)=-2*Vm(i)*Ym(i,i)*sin(t(i,i));
    for j=1:nbus
        if j~=i
        J1(i,i)=J1(i,i)+Vm(i)*Vm(j)*Ym(i,j)*sin(t(i,j)-delta(i)+delta(j));     
        J1(i,j)=-Vm(i)*Vm(j)*Ym(i,j)*sin(t(i,j)-delta(i)+delta(j));
        J3(i,i)=J3(i,i)+Vm(i)*Vm(j)*Ym(i,j)*cos(t(i,j)-delta(i)+delta(j));     
        J3(i,j)=-Vm(i)*Vm(j)*Ym(i,j)*cos(t(i,j)-delta(i)+delta(j));
        J2_1(i,i)=J2_1(i,i)+Vm(j)*Ym(i,j)*cos(t(i,j)-delta(i)+delta(j));     
        J2(i,j)=Vm(i)*Ym(i,j)*cos(t(i,j)-delta(i)+delta(j));
        J4_1(i,i)=J4_1(i,i)-Vm(j)*Ym(i,j)*sin(t(i,j)-delta(i)+delta(j));     
        J4(i,j)=-Vm(i)*Ym(i,j)*sin(t(i,j)-delta(i)+delta(j));
        end
    end
 end
 J2=J2+J2_1;
 J4=J4+J4_1;
for i=length(p0):-1:1
    J2(:,p0(i))=[];
    J3(p0(i),:)=[];
    J4(p0(i),:)=[];
    J4(:,p0(i))=[];
end
J1(sl,:)=[];J1(:,sl)=[];
J2(sl,:)=[];J2(:,sl)=[];
J3(sl,:)=[];J3(:,sl)=[];
J4(sl,:)=[];J4(:,sl)=[];     
J=[J1 J2;J3 J4];
VABK2=J\dPdQ;
D_gocpha=VABK2(1:nbus-1);
D_gocpha(sl+1:nbus)=D_gocpha(sl:end);
D_gocpha(sl)=0;
delta=delta+D_gocpha;
Vk=VABK2(length(J2(:,1))+1:end);
dV=zeros(nbus,1);
f=1;
for i=1:nbus
    for j=1:length(p2)
      if i==p2(j)
        dV(i)=Vk(f);
        f=f+1;
      end
    end
end
Vm=Vm+dV;
%%%%%==== TINH GIOI HAN Q MAY PHAT=====
if maxerror<1e-4 
    for i=length(p0):-1:1
        if Qmin(p0(i))~=0 | Qmax(p0(i))~=0
          if Qs(p0(i))<Qmin(p0(i))
           Qg(p0(i))=Qmin(p0(i))*basemva;
           kb(p0(i))=0;maxerror=1;
          elseif Qs(p0(i)) > Qmax(p0(i))
           Qg(p0(i))=Qmax(p0(i))*basemva;
           kb(p0(i))=0;maxerror=1;
          end
        end
    end
    
end
%%%%%==== HET TINH GIOI HAN Q MAY PHAT
end
%%%%===========&&&&==========STAR
% GAN LAI GIA TRI
%for n=1:nbus
 % nn=n-nss(n);
 % lm=nbus+n-ngs(n)-nss(n)-ns;
  %  if kb(n) ~= 1
   % delta(n) = delta(n)+DX(nn); end
   % if kb(n) == 0
   % Vm(n)=Vm(n)+DX(lm); end
 %end
 %============END
            % =====  Phan tinh toan hien thi   =======
               %  -------------------------------  % 
P=zeros(1,nbus);
Q=zeros(1,nbus);
p1=find(kb==2|kb==1);
for i=1:nbus
    for j=1:nbus
        P(i)=P(i)+Vm(i)*Vm(j)*Ym(i,j)*cos(t(i,j)-delta(i)+delta(j));
        Q(i)=Q(i)+Vm(i)*Vm(j)*Ym(i,j)*sin(t(i,j)-delta(i)+delta(j));
    end
end
P=P'*100;
Q=Q'*100;
Pg(sl)=P(sl);
for i=1:length(p1)
    Qg(p1(i))=-Q(p1(i))-Qsh(p1(i))+Qd(p1(i));
end
j=sqrt(-1);
V=Vm.*cos(delta)+j*Vm.*sin(delta);
delta=delta*180/pi;
Pdt=sum(Pd);Pgt=sum(Pg);
Qdt=sum(Qd);Qgt=sum(Qg);
Qsht=sum(Qsh);
tech= ('                      ITERATIVE SOLUTION DID NOT CONVERGE');
disp(tech)
fprintf('                      Maximum Power Mismatch = %g \n', maxerror)
fprintf('                             No. of Iterations = %g \n\n', iter)
head =['    Bus  Voltage  Angle    ------Load------    ---Generation---   Injected'
       '    No.  Mag.     Degree     MW       Mvar       MW       Mvar       Mvar '
       '                                                                          '];
disp(head)
for n=1:nbus
     fprintf(' %5g', n), fprintf(' %7.3f', Vm(n)),
     fprintf(' %8.3f', delta(n)), fprintf(' %9.3f', Pd(n)),
     fprintf(' %9.3f', Qd(n)),  fprintf(' %9.3f', Pg(n)),
     fprintf(' %9.3f ', Qg(n)), fprintf(' %8.3f\n', Qsh(n))
end
    fprintf('      \n'), fprintf('    Tong              ')
    fprintf(' %9.3f', Pdt), fprintf(' %9.3f', Qdt),
    fprintf(' %9.3f', Pgt), fprintf(' %9.3f', Qgt), fprintf(' %9.3f\n\n', Qsht)
    
    
   %%%  =========== PHAN BO CONG SUAT =======  %%%
   SLT = 0;
fprintf('\n')
fprintf('                             Line Flow and Losses \n\n')
fprintf('    --Line--    Power at bus & line flow            --Line loss--  Transformer\n')
fprintf('    from  to      MW        Mvar        MVA         MW      Mvar      tap\n')
format bank;
for n = 1:nbus
busprt = 0;
   for L = 1:nbr;
       if busprt == 0
       fprintf('   \n'), fprintf('%6g', n), fprintf('      %12f', P(n))
       fprintf('%12f', -Q(n)), fprintf('%9.4f\n', abs(S(n)*basemva))
       busprt = 1;
       else, end
       if nl(L)==n      
       k = nr(L);
       In = (V(n) - a(L)*V(k))*y(L)/a(L)^2 + B(L)/a(L)^2*V(n);
       Ik = (V(k) - V(n)/a(L))*y(L) + B(L)*V(k);
       Snk = V(n)*conj(In)*basemva;
       Skn = V(k)*conj(Ik)*basemva;
       SL  = Snk + Skn;
       SLT = SLT + SL;
       elseif nr(L)==n  
       k = nl(L);
       In = (V(n) - V(k)/a(L))*y(L) + B(L)*V(n);
       Ik = (V(k) - a(L)*V(n))*y(L)/a(L)^2 + B(L)/a(L)^2*V(k);
       Snk = V(n)*conj(In)*basemva;
       Skn = V(k)*conj(Ik)*basemva;
       SL  = Snk + Skn;
       SLT = SLT + SL;
       else, end
         if nl(L)==n | nr(L)==n
         fprintf('%11g', k),
        if real(Snk)>0
         Sk(L)=Snk(1);
         dS(L)=SL(1);
        end
         fprintf('%13f', real(Snk)), fprintf('%12f', imag(Snk))
         fprintf('%11f', abs(Snk)),
         fprintf('%11f', real(SL)),
         if real(Snk)>0
         end
         % Skk(nl(L),1)=Snk;
             if nl(L) ==n & a(L) ~= 1
             fprintf('%9.4f', imag(SL)), fprintf('%9.4f\n', a(L))
             else, fprintf('%9.4f\n', imag(SL))
             end
             else, end 
            
   end
 
end
SLT = SLT/2;
fprintf('   \n'), fprintf('    Total loss                         ')
fprintf('%19f', real(SLT)), fprintf('%11f\n', imag(SLT))
p_N=real(Sk)-real(dS);
Skk=Sk-dS;
q_N=imag(Sk)-imag(dS);
deltap_N=real(dS);
deltaq_N=imag(dS);
clear Ik In SL SLT Skn Snk