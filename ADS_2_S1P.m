filename = 'C:\Users\Ciaran Wilson\Documents\IMS2019_wrk\S11_samp1.txt';

fp1 = fopen(filename);

fileID = fopen('S11.s1p','w');

fprintf(fileID,'! blah\n')
fprintf(fileID,'! blah\n')
fprintf(fileID,'# GHz S RI R 50\n')

C = textscan(fp1,'%f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','freq2');

freq = C{1}(:);
mag = C{2}(:);
phase = C{3}(:);

comp=mag.*exp(1j*(pi/180).*phase);
real1 = real(comp);
im = imag(comp);
formatSpec = '%f %f %f\n';

for ii=1:1:length(freq)                
       fprintf(fileID, formatSpec, freq(ii), real1(ii), im(ii));
end

filename = 'C:\Users\Ciaran Wilson\Documents\IMS2019_wrk\S11_DC.txt';

fp2 = fopen(filename);

fileID1 = fopen('S11_DC.s1p','w');

fprintf(fileID1,'! blah\n')
fprintf(fileID1,'! blah\n')
fprintf(fileID1,'# GHz S RI R 50\n')

C = textscan(fp2,'%f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','freq');

freq = C{1}(:);
mag = C{2}(:);
phase = C{3}(:);

comp=mag.*exp(1j*(pi/180).*phase);
real1 = real(comp);
im = imag(comp);
formatSpec = '%f %f %f\n';

for ii=1:1:length(freq)                
       fprintf(fileID1, formatSpec, freq(ii), real1(ii), im(ii));
end

filename = 'C:\Users\Ciaran Wilson\Documents\IMS2019_wrk\S22_samp.txt';

fp3 = fopen(filename);

fileID2 = fopen('S22.s1p','w');

fprintf(fileID2,'! blah\n')
fprintf(fileID2,'! blah\n')
fprintf(fileID2,'# GHz S RI R 50\n')

C = textscan(fp3,'%f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','freq2');

freq = C{1}(:);
mag = C{2}(:);
phase = C{3}(:);

comp=mag.*exp(1j*(pi/180).*phase);
real1 = real(comp);
im = imag(comp);
formatSpec = '%f %f %f\n';

for ii=1:1:length(freq)                
       fprintf(fileID2, formatSpec, freq(ii), real1(ii), im(ii));
end

filename = 'C:\Users\Ciaran Wilson\Documents\IMS2019_wrk\S22_DC.txt';

fp4 = fopen(filename);

fileID3 = fopen('S22_DC.s1p','w');

fprintf(fileID3,'! blah\n')
fprintf(fileID3,'! blah\n')
fprintf(fileID3,'# GHz S RI R 50\n')

C = textscan(fp4,'%f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','freq');

freq = C{1}(:);
mag = C{2}(:);
phase = C{3}(:);

comp=mag.*exp(1j*(pi/180).*phase);
real1 = real(comp);
im = imag(comp);
formatSpec = '%f %f %f\n';

for ii=1:1:length(freq)                
       fprintf(fileID3, formatSpec, freq(ii), real1(ii), im(ii));
end

filename = 'C:\Users\Ciaran Wilson\Documents\IMS2019_wrk\S22_samp_125_VG_2VD.txt';

fp5 = fopen(filename);

fileID4 = fopen('S22_125VG.s1p','w');

fprintf(fileID4,'! blah\n')
fprintf(fileID4,'! blah\n')
fprintf(fileID4,'# GHz S RI R 50\n')

C = textscan(fp5,'%f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','freq2');

freq = C{1}(:);
mag = C{2}(:);
phase = C{3}(:);

comp=mag.*exp(1j*(pi/180).*phase);
real1 = real(comp);
im = imag(comp);
formatSpec = '%f %f %f\n';

for ii=1:1:length(freq)                
       fprintf(fileID4, formatSpec, freq(ii), real1(ii), im(ii));
end

filename = 'C:\Users\Ciaran Wilson\Documents\IMS2019_wrk\S22_DC_125VG.txt';

fp7 = fopen(filename);

fileID6 = fopen('S22_DC_125VG.s1p','w');

fprintf(fileID6,'! blah\n')
fprintf(fileID6,'! blah\n')
fprintf(fileID6,'# GHz S RI R 50\n')

C = textscan(fp7,'%f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','freq');

freq = C{1}(:);
mag = C{2}(:);
phase = C{3}(:);

comp=mag.*exp(1j*(pi/180).*phase);
real1 = real(comp);
im = imag(comp);
formatSpec = '%f %f %f\n';

for ii=1:1:length(freq)                
       fprintf(fileID6, formatSpec, freq(ii), real1(ii), im(ii));
end