%load('Intrinsicz_28-Nov-2018.mat');

Index = 1:1:length(rfObj.Freq(10:80));
A= [Index; rfObj.Freq(10:80)'; tau_set(10:80)];
%A= [Index, VGSnew, VDSnew, GLGS, GLGD, CGS, CGD, RGS, RGD, GDS, CDS, GM, TAU];
fileID = fopen('tau_withFreq1.txt','w');
fprintf(fileID, 'Begin dscrdata\r\n');
fprintf(fileID,'%6s %6s %7s\r\n', '%index', 'freqz', 'tau');
fprintf(fileID, '%1.0f %11.2f %6.2e\r\n',A);
fprintf(fileID, 'END');
fclose(fileID); 