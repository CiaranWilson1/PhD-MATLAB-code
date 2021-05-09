clear all;
close all;
Is = 3.7E-9;
n=2;
qe=1.6E-19;
V=0:0.01:1;
k = 1.38E-23;
T = 300;
I = Is*exp((qe*V)/(n*k*T));
plot(V,I,'o')
hold on;
Vd = [0.345 0.451 0.48 0.508 0.521 0.53 0.543 0.549 0.555 0.561 0.571 0.578 0.585 0.591 0.596 0.6 0.605 0.608 0.612 0.616 0.619 0.622 0.625 0.627 0.63 0.632 0.634 0.637 0.639 0.641 0.642 0.644 0.646 0.648 0.649];
Id = [0.01 0.04 0.06 0.1 0.14 0.164 0.21 0.24 0.27 0.3 0.37 0.43 0.49 0.56 0.62 0.68 0.74 0.8 0.87 0.93 1 1.1 1.2 1.25 1.3 1.37 1.45 1.5 1.58 1.65 1.7 1.78 1.84 1.9 2];
plot(Vd,Id)
xlabel('Voltage(V)')
ylabel('Current(mA)')
title('Pre Lab and In-Lab Diode Characteristic')
legend('Pre-Lab', 'In-Lab')
Vin = [0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];
figure
plot(Vin,Id)
xlabel('Voltage(V) in')
ylabel('Current(mA)')
title('Measure diode current versus Vin')
figure
plot(Vd,log(Id))
xlabel('Voltage(V)')
ylabel('ln|Current(mA)|')
title('Natural log of diode current versus Vd')