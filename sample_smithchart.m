clc;clear all;format long; 
Z0=100;sm1=smithchart;
ZL1=150-1j*200;f0=3e9; % Hz
gamma_L=(ZL1-Z0)/(ZL1+Z0);

if imag(ZL1)<0
sign1='-';
else
    sign1='+';
end

hold all;plot(real(gamma_L),imag(gamma_L),'ro','LineWidth',1.5);