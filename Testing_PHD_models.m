clear all;
filename = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\b21_full_test.txt';

fp1 = fopen(filename);

C = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','imagz');

phase = C{1}(:);
mag = C{2}(:);
mag1 = C{3}(:);
mag1=mag1(~isnan(mag1));
phase1 = C{4}(:);

phase1 = [phase1];
mag1 = [mag1];
b21=mag1.*exp(1j*(pi/180).*phase1);

filename = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\a11.txt';

fp1 = fopen(filename);

C = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','imagz');


jj=1;
phase = C{1}(:);
mag = C{2}(:);
mag1 = C{3}(:);
mag1=mag1(~isnan(mag1));
phase1 = C{4}(:);

phase1 = [phase1];
mag1 = [mag1];
a11=mag1.*exp(1j*(pi/180).*phase1);

filename = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\a21_full_test.txt';

fp1 = fopen(filename);

C = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','imagz');


jj=1;
phase = C{1}(:);
mag = C{2}(:);
mag1 = C{3}(:);
mag1=mag1(~isnan(mag1));
phase1 = C{4}(:);

phase1 = [phase1];
mag1 = [mag1];
a21=mag1.*exp(1j*(pi/180).*phase1);

Coeff_struct = load('Model_coefficients.mat');
XQPHD = Coeff_struct.XQPHD;
Xx = Coeff_struct.Xx;
XF = Coeff_struct.XF;
a21_lsop = Coeff_struct.a21_lsop;

%XF = -0.7154711 + 1j*0.7841832;
%XF = b21(end/2);
%XF = b21(round(end/2)); %if numbers are uneven

%a21_lsop = a21(end/2);
%a21_lsop = a21(round(end/2)); %if numbers are uneven

% Create delta versions of incident and scattered waves
a21d = a21 - a21_lsop;
b21d = b21 - XF;

% Create design matrix
designXA21 = @(x) [x conj(x)];
designQPHDA21 = @(x) [x conj(x) x.^2 conj(x).^2 abs(x).^2];

%b21_model = XF + designQPHDA21(a21d)*XQPHD;
b21_model = XF + designQPHDA21(a21)*XQPHD; %just a test
numPts = sqrt(length(b21_model));
B21_model = reshape(b21_model, numPts, numPts);
A21 = reshape(a21, numPts, numPts); 
B21 = reshape(b21, numPts, numPts); 

b21_model = XF + designXA21(a21d)*Xx;
B21_modelX = reshape(b21_model, numPts, numPts);

Pout = abs(B21_model).^2 -abs(A21).^2;
%Pout1 = abs(B21).^2 -abs(A21).^2;
PoutdBm = 10*log10(Pout) + 30;
PoutX = abs(B21_modelX).^2 -abs(A21).^2;
%Pout1 = abs(B21).^2 -abs(A21).^2;
PoutdBmX = 10*log10(PoutX) + 30;

filename1 = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\Pdel.txt';
% filename1 = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\Pdel_Pade.txt';

fp2 = fopen(filename1);
C1 = textscan(fp2,'%f %f %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','X1');

imag_gammaQ = C1{1}(:);
real_gammaQ = C1{2}(:);
Pdel_meas = C1{3}(:);

Pdel_measV1 = reshape(Pdel_meas, 20, 20);
imag_gammaQ1 = reshape(imag_gammaQ, 20, 20);
real_gammaQ1 = reshape(real_gammaQ, 20, 20);

gammaL=A21./B21;
figure
mesh(real(gammaL), imag(gammaL), abs(PoutdBm)); hold on;
mesh(real_gammaQ1, imag_gammaQ1, Pdel_measV1, 'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o', 'FaceAlpha', 0); hold off;
xlabel('real(gammaL)')
ylabel('imag(gammaL)')
zlabel('Pdel(dBm)')
title('QPHD vs "Measurement" results versus load')

figure
mesh(real(gammaL), imag(gammaL), abs(PoutdBmX)); hold on;
mesh(real_gammaQ1, imag_gammaQ1, Pdel_measV1, 'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o', 'FaceAlpha', 0); hold off;
xlabel('real(gammaL)')
ylabel('imag(gammaL)')
zlabel('Pdel(dBm)')
title('X param vs "Measurement" results versus load')

Err_QPHD = sum(sum(abs(abs(PoutdBm)-Pdel_measV1)));
Err_X = sum(sum(abs(abs(PoutdBmX)-Pdel_measV1)));

kk=1;