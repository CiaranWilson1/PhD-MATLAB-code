function PdcOpt
filename = 'C:\Users\ciara\OneDrive\Documents\Load_pull_measurements-20191230T192750Z-001\Load_pull_measurements\2p5GHz\MesuroDataFile_4934_fixture_plane_30dBm.mdf';

fp1 = fopen(filename);
fp2 = fopen(filename);
IDS=zeros(414,414);
VDS=zeros(414,414);
ii=0;
ll=0;
oo=0;
% a1_mat =zeros(10,7);
% b1_mat =zeros(10,7);
% a2_mat =zeros(10,7);
% b2_mat =zeros(10,7);
% i2_mat =zeros(10,7);
% a1_mat =zeros(10,6);
% b1_mat =zeros(10,6);
% a2_mat =zeros(10,6);
% b2_mat =zeros(10,6);
% i2_mat =zeros(10,6);
% v2_mat =zeros(10,6);
a1_mat =zeros(10,5);
b1_mat =zeros(10,5);
a2_mat =zeros(10,5);
b2_mat =zeros(10,5);
i2_mat =zeros(10,5);
v2_mat =zeros(10,5);


%while ll < 10

while ~feof(fp1)
    currLine = fgetl(fp1);
    if length(currLine) >=6 && strcmp(currLine(1:6),'VAR re')
        break
    end
    ii = ii + 1;
end

while ii<9116      %9116 %9765%10414
frewind(fp1);

data1 = textscan(fp1,'%*s %*s %*s %*s %f','HeaderLines',ii);
%data = textscan(fp1,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','HeaderLines',ii);
realLoad = data1{1}(1);
imagLoad = data1{1}(2);

Load_point(ll+1) = realLoad + 1i*imagLoad;
ii = ii + 14; %14%15%16
ll = ll + 1;
end
%frewind(fp1);


while ~feof(fp2)
    currLine = fgetl(fp2);
    if length(currLine) >=6 && strcmp(currLine(1),'0')
        break
    end
    oo = oo + 1;
end

ll=0;

while oo<9116      %9116 %9765%10414
frewind(fp2);

%data = textscan(fp,'VAR VGSQ(real)=%f','HeaderLines',ii);
data = textscan(fp2,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','HeaderLines',oo);

jj=1;
freq = data{1}(:);
a1R = data{2}(:);
a1I = data{3}(:);
b1R = data{4}(:);
b1I = data{5}(:);
a2R = data{6}(:);
a2I = data{7}(:);
b2R = data{8}(:);
b2I = data{9}(:);
v1R = data{10}(:);
v1I = data{11}(:);
i1R = data{12}(:);
i1I = data{13}(:);
v2R = data{14}(:);
v2I = data{15}(:);
i2R = data{16}(:);
i2I = data{17}(:);

a1_comp = a1R+1i*a1I;
b1_comp = b1R+1i*b1I;
a2_comp = a2R+1i*a2I;
b2_comp = b2R+1i*b2I;
i2_comp = i2R+1i*i2I;
v2_comp = v2R+1i*v2I;

a1_mat(ll+1,:) = a1_comp;
b1_mat(ll+1,:) = b1_comp;
a2_mat(ll+1,:) = a2_comp;
b2_mat(ll+1,:) = b2_comp;
i2_mat(ll+1,:) = i2_comp;
v2_mat(ll+1,:) = v2_comp;

oo = oo + 14;%14%15%16
ll = ll + 1;
end
Load_point_mat = [Load_point(2:73);Load_point(74:145);Load_point(146:217);Load_point(218:289);Load_point(290:361);Load_point(362:433);Load_point(434:505);Load_point(506:577);Load_point(578:649)];
Load_point_mat_inv = Load_point_mat.';

a11_15G=a1_mat(:,2);
b11_15G=b1_mat(:,2);
b21_15G=b2_mat(:,2);
a21_15G=a2_mat(:,2);
i21_DC = i2_mat(:,1);
% 
% filename = 'C:\Users\ciara\Documents\Behavioral_thermal_wrk\b21_25d.txt';
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
% filename = 'C:\Users\ciara\Documents\Behavioral_thermal_wrk\a11_25d.txt';
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
% filename = 'C:\Users\ciara\Documents\Behavioral_thermal_wrk\a21_25d.txt';
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
% filename = 'C:\Users\ciara\Documents\Behavioral_thermal_wrk\b11_25d.txt';
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
% b11=mag1.*exp(1j*(pi/180).*phase1);
% 
% b21_15G=b21;
% a21_15G=a21;
% a11_15G=a11;
% b11_15G=b11;


Pout_W = abs(b21_15G).^2 - abs(a21_15G).^2;
Pout_dBm = 10*log10(Pout_W) + 30;
Pin_W = abs(a11_15G).^2 - abs(b11_15G).^2;
Pin_dBm = 10*log10(Pin_W) + 30;
%Pdc = 2*28*i21_DC;
% ID = i2_mat(:,1);
% VD = v2_mat(:,1);
% VD_1rst = v2_mat(:,2);

a21_lsop=-0.0215 - 0.0056i;
%a21_lsop=0;

%Pdc = 2*28*ID;
%XI = 0.0416;
XI = Pin_W(1);
%XY = 0.030155554126115 - 0.038243323198444i;
XY=0.0490 - 0.0680i;
%Pdc_mod=2*28*(XI+real(XY*a21_15G));
%Drain_efficiency = Pout_W./Pdc;
%Drain_efficiency_mat = [Drain_efficiency(2:73),Drain_efficiency(74:145),Drain_efficiency(146:217),Drain_efficiency(218:289),Drain_efficiency(290:361),Drain_efficiency(362:433),Drain_efficiency(434:505),Drain_efficiency(506:577),Drain_efficiency(578:649)];
%Pdc_mat = [Pdc(2:73),Pdc(74:145),Pdc(146:217),Pdc(218:289),Pdc(290:361),Pdc(362:433),Pdc(434:505),Pdc(506:577),Pdc(578:649)];

b21_samp = [b21_15G(74:145),b21_15G(218:289)];
a21_samp = [a21_15G(74:145),a21_15G(218:289)];
b21_samp = b21_samp(1:6:end);
a21_samp = a21_samp(1:6:end);
ref_coeff=a21_samp/b21_samp;

realXY = 0.0748;
imagXY = 0.0155;
realXY1 = 0.01;
imagXY1 = 0.01;

ID_mod = XI + real((realXY+1j*imagXY)*a21_15G);

%Error = sum(abs(ID_mod-ID));

options = optimoptions('lsqnonlin','Jacobian','off','Algorithm', 'levenberg-marquardt',...
    'MaxIter',10000,'Display', 'iter', 'MaxFunEvals', 10000,  'TolFun', 1E-10,...
    'DerivativeCheck', 'on', 'FinDiffType','central');

%x0 = [realXY,imagXY];
x0 = [realXY,imagXY,realXY1,imagXY1];

xUpt = lsqnonlin(@errorCalc,x0,[],[],options);

save xUpt

function [Fvec] = errorCalc(xUpt)
        % Evaluate the vector function and the Jacobian matrix for
        % an ANN
        % W are the input ANN weights
        % yData are the measured data we are trying to model
        % net is the NeuralNetwork object
        %XI = xUpt(1);
        realXY = xUpt(1);
        imagXY = xUpt(2);
        realXY1 = xUpt(3);
        imagXY1 = xUpt(4);
        
        
        %ID_mod = XI + real((realXY+1j*imagXY)*(a21_15G-a21_lsop));
        ID_mod = XI + real((realXY+1j*imagXY)*(a21_15G-a21_lsop)+(realXY1+1j*imagXY1)*(a21_15G-a21_lsop).^2);

        %Fvec = sum(abs(ID_mod-ID));
        Fvec = sum(abs(ID_mod-Pin_W));
%         Fvec(31,:) = Fvec1(31,:)*3;
%         Fvec(30,:) = Fvec1(30,:)*2.9;
%         Fvec(29,:) = Fvec1(29,:)*2.8;
%         Fvec(28,:) = Fvec1(28,:)*2.7;
%         Fvec(27,:) = Fvec1(27,:)*2.6;
%         Fvec(26,:) = Fvec1(26,:)*2.5;
%         Fvec(25,:) = Fvec1(25,:)*2.4;
%         Fvec(24,:) = Fvec1(24,:)*2.3;
%         Fvec(23,:) = Fvec1(23,:)*2.2;
%         Fvec(22,:) = Fvec1(22,:)*2.1;
%         Fvec(21,:) = Fvec1(21,:)*2;
%         Fvec(20,:) = Fvec1(20,:)*1.9;
%         Fvec(19,:) = Fvec1(19,:)*1.8;
%         Fvec(18,:) = Fvec1(18,:)*1.7;
%         Fvec(17,:) = Fvec1(17,:)*1.6;
%         Fvec(16,:) = Fvec1(16,:)*1.5;
%         Fvec(15,:) = Fvec1(15,:)*1.4;
%         Fvec(14,:) = Fvec1(14,:)*1.3;
%         Fvec(13,:) = Fvec1(13,:)*1.2;
%         Fvec(12,:) = Fvec1(12,:)*1.1;
%         Fvec(11,:) = Fvec1(11,:)*1;
%         Fvec(10,:) = Fvec1(10,:)*0.9;
%         Fvec(9,:) = Fvec1(9,:)*0.8;
%         Fvec(8,:) = Fvec1(8,:)*0.7;
%         Fvec(7,:) = Fvec1(7,:)*0.6;
%         Fvec(6,:) = Fvec1(6,:)*0.5;
%         Fvec(5,:) = Fvec1(5,:)*0.4;
%         Fvec(4,:) = Fvec1(4,:)*0.3;
%         Fvec(3,:) = Fvec1(3,:)*0.2;
%         Fvec(2,:) = Fvec1(2,:)*0.1;
%         Fvec(1) = Fvec1(1)*0.05;
%         Fvec = sum(Fvec);
        % Evaluate the Jacobian matrix if nargout > 1
    end
end