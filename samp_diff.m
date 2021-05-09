% h=0.01;
% a21real = repmat(0:h:2,length(0:h:2),1);
% a21imag = repmat((-2:h:0)',1,length(-2:h:0));
% a21 = a21real + j*a21imag;
% Y = diff(f)/h;
h=0.01;
x = -10:h:10;
f = 3*x.^2 + 6*x;

Y = diff(f)/h;
numb=0;
idx = find(Y <= numb, 1, 'last');

a21real = repmat(0:h:2,length(0:h:2),1);
a21imag = repmat((-2:h:0)',1,length(-2:h:0));
a21 = a21real + 1j*a21imag;
Xf = -0.80671 + 1j*0.87793;
Xs = -0.74218 + 1j*0.01777;
Xt = 0.04178 - 1j*0.00382;
f100 = ((Xf + Xs*a21 + Xt*conj(a21))*(conj(Xf) + conj(Xs)*conj(a21) + conj(Xt)*a21)) - a21*conj(a21);
f102 = abs((Xf + Xs*a21 + Xt*conj(a21))*(conj(Xf) + conj(Xs)*conj(a21) + conj(Xt)*a21))^2 - abs(a21*conj(a21))^2;
f101 = (Xf + Xs*a21 + Xt*conj(a21))^2 - a21*conj(a21);
Y100 = diff(f100)/h;
Y101 = diff(f101)/h;
Y102 = diff(f102)/h;