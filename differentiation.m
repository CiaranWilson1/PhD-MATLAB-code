syms VGS VGD VDS
%VGD = VGS - VDS;
VDS = VGS - VGD;
VGS = VDS + VGD;
syms Cpgs C1 Vbi m C2 aq Vto C3 lambdaq
Cgs = Cpgs + C1/(1-(VGS/Vbi))^m + C2*(1+tanh(aq*(VGS - Vto))) + C3*(sech(aq*(VGS - Vto)) + tanh(lambdaq*(VDS - Vto)));
dCgs = diff(Cgs, 1, 'VGD') 
dCgd = diff(Cgs, 1, 'VGS')

isequal(dCgs,dCgs)