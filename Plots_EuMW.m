close all;
clear all;
Vgs=load('C:\Users\Ciaran Wilson\Documents\DC and Pulsed DATA for GaN on Si Device\DC\DC_IV_0250_VGS.txt');
Vds=load('C:\Users\Ciaran Wilson\Documents\DC and Pulsed DATA for GaN on Si Device\DC\DC_IV_0250_VDS.txt');
IDS=load('C:\Users\Ciaran Wilson\Documents\DC and Pulsed DATA for GaN on Si Device\DC\DC_IV_0250_IDS.txt');

Vds=Vds(1:2:end,1:31);
IDS=IDS(1:2:end,1:31);


%samp=load('C:\Users\Ciaran Wilson\Documents\DC and Pulsed DATA for GaN on Si Device\DC\DC_IV_0250.cti');

% plot(Vds.',IDS.','k')
% hold on;

fp1=fopen('C:\Users\Ciaran Wilson\Documents\DC and Pulsed DATA for GaN on Si Device\PulsedIV\TextData\N2_10200_2000.TXT');

ii=0;
while ~feof(fp1)
    currLine = fgetl(fp1);
    if length(currLine) >=6 && strcmp(currLine(1),' ')
        break
    end
    ii = ii + 1;
end
h=2;

frewind(fp1);

data = textscan(fp1,'%f %f %f %f','HeaderLines',ii);

Vds_p = data{3}(:);
IDS_p = data{4}(:);

%Vds_p=(1E-3)*Vds_p;
IDS_p=(1E-3)*IDS_p;

indices = find(Vds_p>30);
Vds_p(indices)=[];
IDS_p(indices)=[];

% Vds_p=Vds_p(1:2:end);
% IDS_p=IDS_p(1:2:end);

p=plot(Vds_p.',IDS_p.','o',Vds.',IDS.','k');
h3=legend('Pulsed','DC');
h2=title('DC vs Pulsed IV measurements');
h=xlabel('Vds (V)');
h1=ylabel('IDS (A)');

h.FontSize = 15;
h1.FontSize = 15;
h2.FontSize = 15;
h3.FontSize = 15;

