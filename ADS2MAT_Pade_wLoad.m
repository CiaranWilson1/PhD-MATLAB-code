clear all;
%filename = 'C:\Users\Ciaran Wilson\Documents\Pade_opt_load2_wrk\b21_Pade_load.txt';
filename = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\b21_Pade_load.txt';

fp1 = fopen(filename);
% IDS=zeros(414,414);
% VDS=zeros(414,414);
ii=0;
while ~feof(fp1)
    currLine = fgetl(fp1);
    if length(currLine) >=6 && strcmp(currLine(4:7),'0000')
        break
    end
    ii = ii + 1;
end

frewind(fp1);

%data = textscan(fp,'VAR VGSQ(real)=%f','HeaderLines',ii);
% data = textscan(fp1,'%f %f / %f','HeaderLines',ii);
%C1=[];
%while ~feof(fp1)
%C = textscan(fp1,'%f %f / %f','HeaderLines',ii);
C = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','imagz');
fseek(fp1,0,0);
C1 = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'%f %f <invalid>','na'},'CommentStyle','imagz');
fseek(fp1,0,0);
C2 = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'%f %f <invalid>','na'},'CommentStyle','imagz');
fseek(fp1,0,0);
C3 = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'%f %f <invalid>','na'},'CommentStyle','imagz');


jj=1;
phase = C{1}(:);
mag = C{2}(:);
mag1 = C{3}(:);
mag1=mag1(~isnan(mag1));
phase1 = C{4}(:);
mag2 = C1{3}(:);
mag2=mag2(~isnan(mag2));
phase2 = C1{4}(:);
mag3 = C2{3}(:);
mag3=mag3(~isnan(mag3));
phase3 = C2{4}(:);
mag4 = C3{3}(:);
mag4=mag4(~isnan(mag4));
phase4 = C3{4}(:);
% phase1 = [phase1;phase2;phase3;phase4];
% mag1 = [mag1;mag2;mag3;mag4];
phase1 = [phase1];
mag1 = [mag1];
b21=mag1.*exp(1j*(pi/180).*phase1);
%b21=b21(1:2:end);
%b21comp = [0.572*exp(j*(pi/180)*165.783) 0.549*exp(j*(pi/180)*170.468) 0.498*exp(j*(pi/180)*171.063) 0.469*exp(j*(pi/180)*166.025) 0.496*exp(j*(pi/180)*160.827) 0.547*exp(j*(pi/180)*161.187)];
%filename = 'C:\Users\Ciaran Wilson\Documents\Pade_opt_load2_wrk\a11_Pade_load.txt';
filename = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\a11_Pade_load.txt';

fp1 = fopen(filename);
% IDS=zeros(414,414);
% VDS=zeros(414,414);
ii=0;
while ~feof(fp1)
    currLine = fgetl(fp1);
    if length(currLine) >=6 && strcmp(currLine(4:7),'0000')
        break
    end
    ii = ii + 1;
end

frewind(fp1);

%data = textscan(fp,'VAR VGSQ(real)=%f','HeaderLines',ii);
%C = textscan(fp1,'%f %f / %f','HeaderLines',ii);
C = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','imagz');
fseek(fp1,0,0);
C1 = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'%f %f <invalid>','na'},'CommentStyle','imagz');
fseek(fp1,0,0);
C2 = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'%f %f <invalid>','na'},'CommentStyle','imagz');
fseek(fp1,0,0);
C3 = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'%f %f <invalid>','na'},'CommentStyle','imagz');


jj=1;
phase = C{1}(:);
mag = C{2}(:);
mag1 = C{3}(:);
mag1=mag1(~isnan(mag1));
phase1 = C{4}(:);
mag2 = C1{3}(:);
mag2=mag2(~isnan(mag2));
phase2 = C1{4}(:);
mag3 = C2{3}(:);
mag3=mag3(~isnan(mag3));
phase3 = C2{4}(:);
mag4 = C3{3}(:);
mag4=mag4(~isnan(mag4));
phase4 = C3{4}(:);
% phase1 = [phase1;phase2;phase3;phase4];
% mag1 = [mag1;mag2;mag3;mag4];
phase1 = [phase1];
mag1 = [mag1];
a11=mag1.*exp(1j*(pi/180).*phase1);

% jj=1;
% phase = C{1}(:);
% mag = C{2}(:);
% mag1 = C{3}(:);
% phase1 = C{4}(:);
% a11=mag1.*exp(1j*(pi/180).*phase1);
%a11=a11(1:2:end);

%filename = 'C:\Users\Ciaran Wilson\Documents\Pade_opt_load2_wrk\a21_Pade_load.txt';
filename = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\a21_Pade_load.txt';

fp1 = fopen(filename);
% IDS=zeros(414,414);
% VDS=zeros(414,414);
ii=0;
while ~feof(fp1)
    currLine = fgetl(fp1);
    if length(currLine) >=6 && strcmp(currLine(4:7),'0000')
        break
    end
    ii = ii + 1;
end

frewind(fp1);

%data = textscan(fp,'VAR VGSQ(real)=%f','HeaderLines',ii);
%C = textscan(fp1,'%f %f / %f','HeaderLines',ii);
C = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','imagz');
fseek(fp1,0,0);
C1 = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'%f %f <invalid>','na'},'CommentStyle','imagz');
fseek(fp1,0,0);
C2 = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'%f %f <invalid>','na'},'CommentStyle','imagz');
fseek(fp1,0,0);
C3 = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'%f %f <invalid>','na'},'CommentStyle','imagz');


jj=1;
phase = C{1}(:);
mag = C{2}(:);
mag1 = C{3}(:);
mag1=mag1(~isnan(mag1));
phase1 = C{4}(:);
mag2 = C1{3}(:);
mag2=mag2(~isnan(mag2));
phase2 = C1{4}(:);
mag3 = C2{3}(:);
mag3=mag3(~isnan(mag3));
phase3 = C2{4}(:);
mag4 = C3{3}(:);
mag4=mag4(~isnan(mag4));
phase4 = C3{4}(:);
% phase1 = [phase1;phase2;phase3;phase4];
% mag1 = [mag1;mag2;mag3;mag4];
phase1 = [phase1];
mag1 = [mag1];
a21=mag1.*exp(1j*(pi/180).*phase1);
%a21=a21(1:2:end);

inp1 = imag(a11)./real(a11);

% P=exp(j*inp1);
% P=1;
% Pa21=P.*a21;
% Pa21conj=conj(P).*conj(a21);
% % Pa21conj=P.*(a21)';
% completeA21 = [Pa21 Pa21conj];
% B21 = b21;
% var = B21\completeA21;
% var1 = completeA21\B21;


a11=[a11];
a21=[a21];
b21=[b21];
P=1;
Pa21=P.*a21;
Pa21conj=conj(P).*conj(a21);
% Pa21conj=P.*(a21)';
%completeA21 = [Pa21 Pa21conj];
completeA21 = [ones(size(Pa21)) Pa21 Pa21conj Pa21.^2 Pa21conj.^2 abs(Pa21).^2];
B21 = b21;
% var = B21\completeA21;
% var1 = completeA21\B21;
%completeA = [ones(size(Pa21)) Pa21 -B21.*Pa21conj]; %Pade 10/01
%completeA = [ones(size(Pa21)) Pa21 Pa21conj Pa21.*Pa21conj -B21.*Pa21 -B21.*Pa21conj -B21.*Pa21.*Pa21conj];
completeA = [ones(size(Pa21)) Pa21 Pa21conj abs(Pa21).^2 -B21.*Pa21 -B21.*Pa21conj -B21.*abs(Pa21).^2];
%Aherm = htranspose(completeA);
%P1 = inv(completeA'*completeA)*completeA'*B21;
P = completeA\B21;

save P.mat
    