% %clear all;
% filename = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\b21.txt';
% 
% fp1 = fopen(filename);
% 
% C = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
% 'TreatAsEmpty',{'NA','na'},'CommentStyle','phasez');
% 
% jj=1;
% phase = C{1}(:);
% mag = C{2}(:);
% mag1 = C{3}(:);
% mag1=mag1(~isnan(mag1));
% phase1 = C{4}(:);
% 
% phase1 = [phase1];
% mag1 = [mag1];
% b21=mag1.*exp(1j*(pi/180).*phase1);
% 
% filename = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\a11.txt';
% 
% fp1 = fopen(filename);
% 
% C = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
% 'TreatAsEmpty',{'NA','na'},'CommentStyle','phasez');
% 
% 
% jj=1;
% phase = C{1}(:);
% mag = C{2}(:);
% mag1 = C{3}(:);
% mag1=mag1(~isnan(mag1));
% phase1 = C{4}(:);
% 
% phase1 = [phase1];
% mag1 = [mag1];
% a11=mag1.*exp(1j*(pi/180).*phase1);
% 
% 
% filename = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\a21.txt';
% 
% fp1 = fopen(filename);
% 
% C = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
% 'TreatAsEmpty',{'NA','na'},'CommentStyle','phasez');
% 
% 
% jj=1;
% phase = C{1}(:);
% mag = C{2}(:);
% mag1 = C{3}(:);
% mag1=mag1(~isnan(mag1));
% phase1 = C{4}(:);
% 
% phase1 = [phase1];
% mag1 = [mag1];
% a21=mag1.*exp(1j*(pi/180).*phase1);
% 
% inp1 = imag(a11)./real(a11);
% 
% 
% a11=[a11];
% a21=[a21];
% a21_samp = [a21(1); a21(2:2:end)];
% b21=[b21];
% b21_samp = [b21(1); b21(2:2:end)];
% P=1;
% Pa21=P.*a21;
% Pa21conj=conj(P).*conj(a21);
% Pa21_samp=P.*a21_samp;
% Pa21conj_samp=conj(P).*conj(a21_samp);
% 
% %XF=-0.717162403625494 + 0.781343504711223i;
% 
% 
% 
% %completeA21 = [ones(size(Pa21)) Pa21 Pa21conj Pa21.^2 Pa21conj.^2 abs(Pa21).^2];
% completeA21 = [Pa21 Pa21conj Pa21.^2 Pa21conj.^2 abs(Pa21).^2];
%completeA21_samp = [ones(size(Pa21_samp)) Pa21_samp Pa21conj_samp Pa21_samp.^2 Pa21conj_samp.^2 abs(Pa21_samp).^2];

%% New extration code
% Choose points to be XF
XF=-0.586689002649106 + 0.119498151170060i;
%XF=3.4340 + 1.2343i;
%XA=-1.1104 + 0.5091i;
%XF=-3.3787 + 0.4349i;
%XF=-4.4502 + 0.4315i;
%XF=-2.0466 + 0.3289i;
%XF=-4.450241047673360 + 0.431544745343981i;
%XY_F = ID_1rst(1);
%XF = b21(end/2);
%XF = b21(round(end/2)); %if numbers are uneven
b21 = b21_samp_meas(:);
a21 = a21_samp_meas(:);
%b11 = b11_samp_meas(:);
%ID = ID_samp_meas(:);
%VD = VD_samp_meas(:);
% Choose corresponding a21_lsop
%a21_lsop = -0.0215 - 0.0056i;
a21_lsop = -0.003219043848685 + 0.015442218497099i;
%a21_lsop=-0.0324 - 0.0499i;
%a21_lsop = 0.0121 + 0.0135i;
%a21_lsop = 0.0536 + 0.0118i;
%a21_lsop = 0.0018 + 0.0159i;
%a21_lsop = 0.053562975146475 + 0.011816209553015i;
%VD_lsop = VD_1rst(1);
%VD_lsop = -31.0892 + 3.1350i;
%a21_lsop = a21(end/2);
%a21_lsop = a21(round(end/2)); %if numbers are uneven

% Create delta versions of incident and scattered waves
a21d = a21 - a21_lsop;
b21d = b21 - XF;
%b11d = b11 - XA;
%b21d = b21;
%IDd = ID - XY_F;
%VDd = VD-VD_lsop;

% Create design matrix
designXA21 = @(x) [x conj(x)];
designQPHDA21 = @(x) [x conj(x) x.^2 conj(x).^2 abs(x).^2];
designqCPHDA21 = @(x) [x conj(x) x.^2 conj(x).^2 abs(x).^2 x.^3];

designQPHDVD = @(x) [x conj(x) x.^2 conj(x).^2 abs(x).^2];
%designQPHDA21 = [ones(size(a21d)) a21d conj(a21d) a21d.^2 conj(a21d).^2 abs(a21d).^2];

% var1 = completeA21\B21;
% var2 = completeA21_samp\b21_samp;

% Extract model: b21d = designA21*XQPHD or b21d = designA21*Xx
XQPHD = designQPHDA21(a21d)\b21d;
XqCPHD = designqCPHDA21(a21d)\b21d;
Xx = designXA21(a21d)\b21d;

%XOport=designXA21(a21d)\b11d;

%XY_QPHD = designQPHDVD(VDd)\IDd;

completeA = [a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21d).^2];
%completeA = [ones(size(a21d)) a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21).^2];
P = completeA\b21d;

completeA_posAsq = [a21d conj(a21d) a21d.^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21d).^2];
%completeA = [ones(size(a21d)) a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21).^2];
P_posAsq = completeA_posAsq\b21d;

completeA_conjAsq = [a21d conj(a21d) conj(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21d).^2];
%completeA = [ones(size(a21d)) a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21).^2];
P_conjAsq = completeA_conjAsq\b21d;

completeA_posAsqDen = [a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*a21d.^2];
%completeA = [ones(size(a21d)) a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21).^2];
P_posAsqDen = completeA_posAsqDen\b21d;

completeA_conjAsqDen = [a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*conj(a21d).^2];
%completeA = [ones(size(a21d)) a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21).^2];
P_conjAsqDen = completeA_conjAsqDen\b21d;

completeA_a21a21 = [a21d conj(a21d) a21d.^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*a21d.^2];
%completeA = [ones(size(a21d)) a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21).^2];
P_a21a21 = completeA_a21a21\b21d;


completeA_a21conj = [a21d conj(a21d) a21d.^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*conj(a21d).^2];
%completeA = [ones(size(a21d)) a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21).^2];
P_a21conj = completeA_a21conj\b21d;

completeA_conja21 = [a21d conj(a21d) conj(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*a21d.^2];
%completeA = [ones(size(a21d)) a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21).^2];
P_conja21 = completeA_conja21\b21d;

completeA_conjconj = [a21d conj(a21d) conj(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*conj(a21d).^2];
%completeA = [ones(size(a21d)) a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21).^2];
P_conjconj = completeA_conjconj\b21d;

completeA_QPHD_level = [a21d conj(a21d) a21d.^2 conj(a21d).^2 abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*a21d.^2 -b21d.*conj(a21d).^2 -b21d.*abs(a21d).^2];
%completeA = [ones(size(a21d)) a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21).^2];
P_Qlvl = completeA_QPHD_level\b21d;

completeV = [VDd conj(VDd) abs(VDd).^2 -IDd.*VDd -IDd.*conj(VDd) -IDd.*abs(VDd).^2];
%completeA = [ones(size(a21d)) a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21).^2];
XY_P = completeV\IDd;


completeA_ho_QPHD = [ones(size(a21d)) a21d conj(a21d) a21d.*a21d conj(a21d).*conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*a21d.*a21d -b21d.*conj(a21d).*conj(a21d) -b21d.*abs(a21).^2];
P_ho_QPHD = completeA_ho_QPHD\b21d;

completeA_ho_QPHD_nor_den = [ones(size(a21d)) a21d conj(a21d) a21d.*a21d conj(a21d).*conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21).^2];
P_ho_QPHD_nor_den = completeA_ho_QPHD_nor_den\b21d;

completeA_1101 = [a21d conj(a21d) abs(a21d).^2 -b21d.*conj(a21d)];
P_1101 = completeA_1101\b21d;

completeA_wo_den = [a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d)];
P_wo_den = completeA_wo_den\b21d;

completeA_wo_num = [a21d conj(a21d) -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21).^2];
P_wo_num = completeA_wo_num\b21d;

completeA_wo_ho = [a21d conj(a21d) -b21d.*a21d -b21d.*conj(a21d)];
P_wo_ho = completeA_wo_ho\b21d;

% Use QPHD model to predict output wave
b21_model = XF + designQPHDA21(a21d)*XQPHD;
numPts = sqrt(length(b21_model));
B21_model = reshape(b21_model, numPts, numPts);
A21 = reshape(a21, numPts, numPts); 
B21 = reshape(b21, numPts, numPts); 

% Plot QPHD model vs "measurements"
mesh(real(A21), imag(A21), abs(B21_model)); hold on;
mesh(real(A21), imag(A21), abs(B21), 'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o'); hold off;

%Use Padé model to predict output wave
b21_modelP = XF + completeA*P;
numPts = sqrt(length(b21_modelP));
B21_modelP = reshape(b21_modelP, numPts, numPts);
A21 = reshape(a21, numPts, numPts); 
B21 = reshape(b21, numPts, numPts); 

% Plot Padé model vs "measurements"
figure
mesh(real(A21), imag(A21), abs(B21_modelP)); hold on;
mesh(real(A21), imag(A21), abs(B21), 'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o'); hold off;

%Use Xparam model to predict output wave
b21_model = XF + designXA21(a21d)*Xx;
B21_modelX = reshape(b21_model, numPts, numPts);

% Plot model vs "measurements"
figure
mesh(real(A21), imag(A21), abs(B21_modelX)); hold on;
mesh(real(A21), imag(A21), abs(B21), 'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o', 'FaceAlpha', 0); hold off;

Pout = abs(B21_model).^2 -abs(A21).^2;
%Pout1 = abs(B21).^2 -abs(A21).^2;
PoutdBm = 10*log10(Pout) + 30;
PoutX = abs(B21_modelX).^2 -abs(A21).^2;
%Pout1 = abs(B21).^2 -abs(A21).^2;
PoutdBmX = 10*log10(PoutX) + 30;
%check = log10(Pout1);
%figure

%mesh(real(A21), imag(A21), abs(PoutdBm)); hold on;

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

%mesh(real(A21),imag(A21), abs(Pdel_measV1),'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o', 'FaceAlpha', 0); hold off;
%xlabel('real(a21)')
%ylabel('imag(a21)')
%zlabel('Pdel(dBm)')
%title('QPHD opt vs "Measurement" results versus a21')
gammaL=A21./B21;
figure
mesh(real(gammaL), imag(gammaL), PoutdBm); hold on;
mesh(real_gammaQ1, imag_gammaQ1, Pdel_measV1, 'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o', 'FaceAlpha', 0); hold off;
xlabel('real(gammaL)')
ylabel('imag(gammaL)')
zlabel('Pdel(dBm)')
title('QPHD opt vs "Measurement" results versus load')

figure
mesh(real(gammaL), imag(gammaL), PoutdBmX); hold on;
mesh(real_gammaQ1, imag_gammaQ1, Pdel_measV1, 'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o', 'FaceAlpha', 0); hold off;
xlabel('real(gammaL)')
ylabel('imag(gammaL)')
zlabel('Pdel(dBm)')
title('X param vs "Measurement" results versus load')

save('Model_coefficients.mat','XQPHD','Xx','a21_lsop','XF')

% figure
% mesh(real(A21), imag(A21), PoutdBmX); hold on;
% mesh(real(A21), imag(A21), Pdel_measV1, 'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o', 'FaceAlpha', 0); hold off;
% xlabel('real(a21)')
% ylabel('imag(a21)')
% zlabel('Pdel(dBm)')
% title('X param vs "Measurement" results versus a21')

% Hi Ciaran. The QPHD model seems to work well, but the Xparam one looks
% terrible (I think it's correct, but I'm surprised at how bad it is)
% 
% Try and extend this to power i.e. just plot Pout = |B21_model|^2 -
% |A21|^2 versus both A21 and GammaL (and do same for "measurements" and
% show on same plot)

%save var1.mat

