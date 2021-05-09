clear all;
% filename = 'C:\Users\Ciaran Wilson\Documents\IMS2019_wrk\10200_2000_pulsed_fromMDIF1.txt';
filename = 'C:\Users\Ciaran Wilson\Documents\Ecsel_meas\UMS\28-July-2018\DC\FWD-BIAS\DC_IV_0250.txt';

fp1 = fopen(filename);
% IDS=NaN(19,483);
% VDS=NaN(19,483);
ii=0;
% while ~feof(fp1)
%     currLine = fgetl(fp1);
%     if length(currLine) >=6 && strcmp(currLine(1:6),'VAR VG')
%         break
%     end
%     ii = ii + 1;
% end
% 
% frewind(fp1);
% 
% %data = textscan(fp,'VAR VGSQ(real)=%f','HeaderLines',ii);
% data = textscan(fp1,'VAR %*s%f','HeaderLines',ii);
% 
% jj=1;
% VGS(jj) = data{1}(1);
% VGS_p(jj) = data{1}(2);
% VDS_p(jj) = data{1}(3);
% frewind(fp1);
%for kk=1:1:19
while ~feof(fp1)
    currLine = fgetl(fp1);
    if length(currLine) >=6 && strcmp(currLine(1:2),' 0')
        break
    end
    ii = ii + 1;
end
frewind(fp1);
data = textscan(fp1,'%f %f %f %f','HeaderLines',ii);
VGS = data{1}(:);
VDS = data{2}(:);
IDS = data{3}(:);

fileName = ['DCIV_UMS_FWD'];
save(fileName,'VGS','VDS','IDS');
% a = data{2}(:);
% b = length(a);
% c = 483-b;
% d = NaN(c,1);
% e = [a;d];
% IDS(kk,:) = e;
% a = data{1}(:);
% b = length(a);
% c = 483-b;
% d = NaN(c,1);
% e = [a;d];
% VDS(kk,:) = e;
% ii = ii+length(a);
%end

% while ~feof(fp1)
%     currLine = fgetl(fp1);
%     if length(currLine) >=6 && strcmp(currLine(1),'0')
%         break
%     end
%     ii = ii + 1;
% end
% frewind(fp1);
% 
% data = textscan(fp1,'%f %f','HeaderLines',ii);
% IDS(2,:) = data{2}(:);
% VDS(2,:) = data{1}(:);
% ii = ii+414;
% while ~feof(fp1)
%     currLine = fgetl(fp1);
%     if length(currLine) >=6 && strcmp(currLine(1),'0')
%         break
%     end
%     ii = ii + 1;
% end
% kk=1;
% frewind(fp1);
% data = textscan(fp1,'%f %f','HeaderLines',ii);
% IDS(1,:) = data{2}(:);
% VDS(1,:) = data{1}(:);
% ii = ii+414;
% while ~feof(fp1)
%     currLine = fgetl(fp1);
%     if length(currLine) >=6 && strcmp(currLine(1),'0')
%         break
%     end
%     ii = ii + 1;
% end
% frewind(fp1);
% 
% data = textscan(fp1,'%f %f','HeaderLines',ii);
% IDS(2,:) = data{2}(:);
% VDS(2,:) = data{1}(:);
% ii = ii+414;