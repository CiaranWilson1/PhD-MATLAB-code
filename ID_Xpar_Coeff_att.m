clear all
filename = 'C:\Users\Ciaran Wilson\Documents\Pade_opt_load2_wrk\ID.txt';

fp1 = fopen(filename);
% IDS=zeros(414,414);
% VDS=zeros(414,414);
ii=0;
while ~feof(fp1)
    currLine = fgetl(fp1);
    if length(currLine) >=6 && strcmp(currLine(1:6),'0.0000')
        break
    end
    ii = ii + 1;
end

frewind(fp1);

%data = textscan(fp,'VAR VGSQ(real)=%f','HeaderLines',ii);
data = textscan(fp1,'%f %f / %f','HeaderLines',ii);
% C = textscan(fp1,'%f %f %f / %f','Delimiter',',',...
% 'TreatAsEmpty',{'NA','na'},'CommentStyle','phasez');
% data = textscan(fp1,'%f %f %f / %f','HeaderLines',ii);

jj=1;
phase = data{1}(:);
mag = data{2}(:);
phase1 = data{3}(:);
ID=mag.*exp(1j*(pi/180).*phase1);
%b21comp = [0.572*exp(j*(pi/180)*165.783) 0.549*exp(j*(pi/180)*170.468) 0.498*exp(j*(pi/180)*171.063) 0.469*exp(j*(pi/180)*166.025) 0.496*exp(j*(pi/180)*160.827) 0.547*exp(j*(pi/180)*161.187)];

filename = 'C:\Users\Ciaran Wilson\Documents\Pade_opt_load2_wrk\a21_2nd.txt';

fp1 = fopen(filename);
% IDS=zeros(414,414);
% VDS=zeros(414,414);
ii=0;
while ~feof(fp1)
    currLine = fgetl(fp1);
    if length(currLine) >=6 && strcmp(currLine(1:6),'0.0000')
        break
    end
    ii = ii + 1;
end

frewind(fp1);

%data = textscan(fp,'VAR VGSQ(real)=%f','HeaderLines',ii);
data = textscan(fp1,'%f %f / %f','HeaderLines',ii);
% C = textscan(fp1,'%f %f %f / %f','Delimiter',',',...
% 'TreatAsEmpty',{'NA','na'},'CommentStyle','phasez');

jj=1;
phase = data{1}(:);
mag = data{2}(:);
phase1 = data{3}(:);
a21=mag.*exp(1j*(pi/180).*phase1);


% P=exp(j*inp1);
% P=1;
% Pa21=P.*a21;
% Pa21conj=conj(P).*conj(a21);
% % Pa21conj=P.*(a21)';
% completeA21 = [Pa21 Pa21conj];
% B21 = b21;
% var = B21\completeA21;
% var1 = completeA21\B21;



a21=[a21];
ID=[ID];
P=1;
Pa21=P.*a21;
Pa21conj=conj(P).*conj(a21);
% Pa21conj=P.*(a21)';
%completeA21 = [Pa21 Pa21conj];
completeA21 = [Pa21];
ID = 2*ID;
var = ID\completeA21;
var1 = completeA21\ID;