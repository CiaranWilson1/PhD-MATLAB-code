filename = 'C:\Users\Ciaran Wilson\Documents\Energy_Cons_wrk\Mod_S_102VGS_2VDS.txt';

fp2 = fopen(filename);

out = [];        
ipart = 0;
len = 152;
part = zeros(2, len);

while 1  % Infinite loop
  s = fgets(fp2);
  if ischar(s)
    data = sscanf(s, '%g %g', 2);
    if length(data) == 2
      ipart = ipart + 1;
      part(:, ipart) = data;
      if ipart == len
        out = cat(2, out, part);
        ipart = 0;
      end
    end
  else  % End of file:
    break;
  end
end

out = cat(2, out, part(:, 1:ipart));

freq = out(1,1:19);
realS11 = out(2,1:19);
imagS11 = out(2,20:38);
realS12 = out(2,39:57);
imagS12 = out(2,58:76);
realS21 = out(2,77:95);
imagS21 = out(2,96:114);
realS22 = out(2,115:133);
imagS22 = out(2,134:152);

A=[freq;realS11;imagS11;realS21;imagS21;realS12;imagS12;realS22;imagS22];

fileID = fopen('Sparameters_Modelled_102VGS_2VDS.txt','w');
fprintf(fileID,'Freqs S11r S11i S21r S21i S12r S12i S22r S22i\n');
fprintf(fileID,'%6.2e %12.8e %12.8e %12.8e %12.8e %12.8e %12.8e %12.8e %12.8e\n',A);
fclose(fileID);

filename = 'C:\Users\Ciaran Wilson\Documents\Energy_Cons_wrk\Meas_S_102VGS_2VDS.txt';

fp2 = fopen(filename);

out = [];        
ipart = 0;
len = 152;
part = zeros(2, len);

while 1  % Infinite loop
  s = fgets(fp2);
  if ischar(s)
    data = sscanf(s, '%g %g', 2);
    if length(data) == 2
      ipart = ipart + 1;
      part(:, ipart) = data;
      if ipart == len
        out = cat(2, out, part);
        ipart = 0;
      end
    end
  else  % End of file:
    break;
  end
end

out = cat(2, out, part(:, 1:ipart));

freq = out(1,1:19);
realS11 = out(2,1:19);
imagS11 = out(2,20:38);
realS12 = out(2,39:57);
imagS12 = out(2,58:76);
realS21 = out(2,77:95);
imagS21 = out(2,96:114);
realS22 = out(2,115:133);
imagS22 = out(2,134:152);

A=[freq;realS11;imagS11;realS21;imagS21;realS12;imagS12;realS22;imagS22];

fileID = fopen('Sparameters_Measured_102VGS_2VDS.txt','w');
fprintf(fileID,'Freqs S11r S11i S21r S21i S12r S12i S22r S22i\n');
fprintf(fileID,'%6.2e %12.8e %12.8e %12.8e %12.8e %12.8e %12.8e %12.8e %12.8e\n',A);
fclose(fileID);

Cap = load('C:\Users\Ciaran Wilson\Documents\Energy Conservative\CapMatrix.mat');
Vds = Cap.VDSQ_c;
Vgs = Cap.VGSQ_c;
Cgs = Cap.CGS_c;
Cgd = Cap.CGD_c;
Cds = Cap.CDS_c;

C11 = Cgs + Cgd;
C12 = -Cgd;
C21 = -Cgd;
C22 = Cds + Cgd;

Vgs_print = Vgs(:);
Vds_print = Vds(:);
C11_meas = C11(:);
C12_meas = C12(:);
C21_meas = C21(:);
C22_meas = C22(:);

Cap = load('C:\Users\Ciaran Wilson\Documents\Energy Conservative\dZ2_VGS.mat');
% Vds = Cap.VDSQ_c;
% Vgs = Cap.VGSQ_c;
C11_mod = Cap.d2Z2_VGS2*10;
C12_mod = Cap.d2Z2_VDSVGS*10;
C22_mod = Cap.d2Z2_VDS2*10;
C21_mod = Cap.d2Z2_VGSVDS*10;

C11_mod1 = C11_mod(:);
C12_mod1 = C12_mod(:);
C21_mod1 = C21_mod(:);
C22_mod1 = C22_mod(:);

A=[Vgs_print,Vds_print,C11_meas*1E12,C12_meas*1E12,C21_meas*1E12,C22_meas*1E12,C11_mod1,C12_mod1,C21_mod1,C22_mod1]';

fileID = fopen('Capacitances_Modelled.txt','w');
fprintf(fileID,'Vgs Vds C11mod C12mod C21_mod C22_mod C11meas C12meas C21_meas C22_meas\n');
fprintf(fileID,'%6.2f %6.2f %12.8e %12.8e %12.8e %12.8e %12.8e %12.8e %12.8e %12.8e\n',A);
fclose(fileID);

A = [Vgs(:),Vds(:),E(:)]';
fileID = fopen('Energy_Surface.txt','w');
fprintf(fileID,'Vgs Vds E\n');
fprintf(fileID,'%6.2f %6.2f %12.8e\n',A);
fclose(fileID);

