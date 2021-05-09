clear all;
%filename = 'C:\Users\Ciaran Wilson\Documents\Pade_opt_load2_wrk\Pdel_dBm.txt';
filename = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\Pdel.txt';
%filename = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\PAE.txt';

fp1 = fopen(filename);
C = textscan(fp1,'%f %f %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','X1');

size=20;

imag_gamma = C{1}(:);
real_gamma = C{2}(:);
Pdel = C{3}(:);

imag_gamma1 = reshape(imag_gamma,size,size)';
real_gamma1 = reshape(real_gamma,size,size)';
Pdel1 = reshape(Pdel,size,size)';

figure
mesh(imag_gamma1,real_gamma1, Pdel1)
hold on;
% 
filename1 = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\Pdel_QPHD_Xfsep.txt';
% filename1 = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\Pdel_Pade.txt';

fp2 = fopen(filename1);
C1 = textscan(fp2,'%f %f %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','X1');

imag_gammaQ = C1{1}(:);
real_gammaQ = C1{2}(:);
PdelQ = C1{3}(:);

imag_gamma1Q = reshape(imag_gammaQ,size,size)';
real_gamma1Q = reshape(real_gammaQ,size,size)';
Pdel1Q = reshape(PdelQ,size,size)';
scatter3(imag_gamma1Q(:),real_gamma1Q(:),Pdel1Q(:))
% title('Pade vs "Measurement" results')
title('QPHD opt vs "Measurement" results')
% title('PAE vs reflection coeff results')
xlabel('imag reflect')
ylabel('real reflect')
zlabel('P del(dBm)')
%zlabel('PAE (%)')