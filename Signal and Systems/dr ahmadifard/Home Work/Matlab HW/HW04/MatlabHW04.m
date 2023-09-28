clear;clc;close all;
N=3;
N1=5;
N2=10;
period=10;
W0=2*pi/period;
n=-17:17;
f=[0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0];
x=zeros(1,length(n));
x1=zeros(1,length(n));
x2=zeros(1,length(n));
X=fft(fftshift(f));
ak=X/period;
for k=0:N
    x=x+ak(k+1).*exp(j*k*W0*n);
end
for k=0:N1
    x1=x1+ak(k+1).*exp(j*k*W0*n);
end
for k=0:N2
    x2=x2+ak(k+1).*exp(j*k*W0*n);
end
subplot(4,2,[1 2])
stem(n,abs(ak))
title('fourier series coefficients (ak)');
subplot(4,2,3)
stem(n, f);
title('main signal');
subplot(4,2,4)
stem(n, abs(x));
title('synthesized signal with N=3');
subplot(4,2,5)
stem(n, f);
title('main signal');
subplot(4,2,6)
stem(n, abs(x1));
title('synthesized signal with N=5');
subplot(4,2,7)
stem(n, f);
title('main signal');
subplot(4,2,8)
stem(n, abs(x2));
title('synthesized signal with N=10');