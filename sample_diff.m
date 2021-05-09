stepx = 0.01;
stepy = 0.01;
Nx = 2/stepx +1;
Ny = 2/stepy +1;
[re,im] = meshgrid([-1:stepx:1], [-1:stepy:1]);
cplx = re + 1i*im;
z = cplx.^3;

f1 = diff(real(z),1,2)/stepx +1i* diff(imag(z),1,2)/stepx;
f2 = diff(imag(z),1,1)/stepy - 1i* diff(real(z),1,1)/stepy;

f1i = interp1(1 : Ny, f1, 1.5 : Ny);
f2i = interp1(1 : Nx, f2 .', 1.5 : Nx) .';