filename = 'C:\Users\ciara\OneDrive\Documents\Load_pull_measurements-20191230T192750Z-001\Load_pull_measurements\1p5GHz\MesuroDataFile_4975_fixture_plane_20dBm.mdf';

fp1 = fopen(filename);
fp2 = fopen(filename);
IDS=zeros(414,414);
VDS=zeros(414,414);
ii=0;
ll=0;
oo=0;
a1_mat =zeros(10,7);
b1_mat =zeros(10,7);
a2_mat =zeros(10,7);
b2_mat =zeros(10,7);
i2_mat =zeros(10,7);
v2_mat =zeros(10,7);
% a1_mat =zeros(10,6);
% b1_mat =zeros(10,6);
% a2_mat =zeros(10,6);
% b2_mat =zeros(10,6);
% i2_mat =zeros(10,6);
% v2_mat =zeros(10,6);
% a1_mat =zeros(10,5);
% b1_mat =zeros(10,5);
% a2_mat =zeros(10,5);
% b2_mat =zeros(10,5);
% i2_mat =zeros(10,5);
% v2_mat =zeros(10,5);


%while ll < 10

while ~feof(fp1)
    currLine = fgetl(fp1);
    if length(currLine) >=6 && strcmp(currLine(1:6),'VAR re')
        break
    end
    ii = ii + 1;
end
qq=0;
while ii<10414          % 9765%10414%9116
frewind(fp1);
qq=qq+1;
data1 = textscan(fp1,'%*s %*s %*s %*s %f','HeaderLines',ii);
%data = textscan(fp1,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','HeaderLines',ii);
realLoad = data1{1}(1);
imagLoad = data1{1}(2);

Load_point(ll+1) = realLoad + 1i*imagLoad;
ii = ii + 16; %15%16
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

while oo<10414 %9765%10414%9116
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

oo = oo + 16; %15%16
ll = ll + 1;
end
Load_point_mat = [Load_point(2:73);Load_point(74:145);Load_point(146:217);Load_point(218:289);Load_point(290:361);Load_point(362:433);Load_point(434:505);Load_point(506:577);Load_point(578:649)];
Load_point_mat_inv = Load_point_mat.';

a11_15G=a1_mat(:,2);
b11_15G=b1_mat(:,2);
b21_15G=b2_mat(:,2);
a21_15G=a2_mat(:,2);
%i21_DC = i2_mat(:,1);
Pout_W = abs(b21_15G).^2 - abs(a21_15G).^2;
Pout_dBm = 10*log10(Pout_W) + 30;
Pin_W = abs(a11_15G).^2 - abs(b11_15G).^2;
Pin_dBm = 10*log10(Pin_W) + 30;
%Pdc = 2*28*i21_DC;
ID = i2_mat(:,1);
VD = v2_mat(:,1);
ID_1rst = i2_mat(:,2);
VD_1rst = v2_mat(:,2);

Pdc = 2*28*ID;
% XI = 0.0843551;
% %XY = 0.030155554126115 - 0.038243323198444i;
% XY = 0.0478 - 0.0652i;
% XI = 0.6517;                %30dBm
% XY = 0.0938 + 1j*-0.0990;

% XI = 0.0718;                  %2GHz 10dBm
% XY=-0.0279 + 0.0744i;

% XI = 0.6527191;               %2GHz 30dBm
% XY=-0.0516 + 0.0992i;

XI = 0.6134;               %2.5GHz 30dBm
XY=0.0300 + 0.0933i;

Mess_Pin=0.5120;            %2.5GHz 30dBm
Mess_SS = 0.0748+1j*0.0155;

% Mess_Pin=0.1608;            %2.5GHz 25dBm
% Mess_SS = 0.0749+1j*0.0156;

Pin_mod=Mess_Pin+real(Mess_SS*a21_15G);
Pin_mod_mat = [Pin_mod(2:73),Pin_mod(74:145),Pin_mod(146:217),Pin_mod(218:289),Pin_mod(290:361),Pin_mod(362:433),Pin_mod(434:505),Pin_mod(506:577),Pin_mod(578:649)];

Pdc_mod=2*28*(XI+real(XY*a21_15G));
Drain_efficiency = Pout_W./Pdc;
Drain_efficiency_mat = [Drain_efficiency(2:73),Drain_efficiency(74:145),Drain_efficiency(146:217),Drain_efficiency(218:289),Drain_efficiency(290:361),Drain_efficiency(362:433),Drain_efficiency(434:505),Drain_efficiency(506:577),Drain_efficiency(578:649)];
Pdc_mat = [Pdc(2:73),Pdc(74:145),Pdc(146:217),Pdc(218:289),Pdc(290:361),Pdc(362:433),Pdc(434:505),Pdc(506:577),Pdc(578:649)];
Pdc_mod_mat = [Pdc_mod(2:73),Pdc_mod(74:145),Pdc_mod(146:217),Pdc_mod(218:289),Pdc_mod(290:361),Pdc_mod(362:433),Pdc_mod(434:505),Pdc_mod(506:577),Pdc_mod(578:649)];
Pout_W_mat = [Pout_W(2:73),Pout_W(74:145),Pout_W(146:217),Pout_W(218:289),Pout_W(290:361),Pout_W(362:433),Pout_W(434:505),Pout_W(506:577),Pout_W(578:649)];
Pout_dBm_mat = [Pout_dBm(2:73),Pout_dBm(74:145),Pout_dBm(146:217),Pout_dBm(218:289),Pout_dBm(290:361),Pout_dBm(362:433),Pout_dBm(434:505),Pout_dBm(506:577),Pout_dBm(578:649)];
Pin_dBm_mat = [Pin_dBm(2:73),Pin_dBm(74:145),Pin_dBm(146:217),Pin_dBm(218:289),Pin_dBm(290:361),Pin_dBm(362:433),Pin_dBm(434:505),Pin_dBm(506:577),Pin_dBm(578:649)];
Pin_W_mat = [Pin_W(2:73),Pin_W(74:145),Pin_W(146:217),Pin_W(218:289),Pin_W(290:361),Pin_W(362:433),Pin_W(434:505),Pin_W(506:577),Pin_W(578:649)];
%Pout_modP_mat = [Pout_mod_P(2:73),Pout_mod_P(74:145),Pout_mod_P(146:217),Pout_mod_P(218:289),Pout_mod_P(290:361),Pout_mod_P(362:433),Pout_mod_P(434:505),Pout_mod_P(506:577),Pout_mod_P(578:649)];

%Vq_p = interp2(mag_mat,phase_mat,Pout_dBm_mat,abs(Gamma_opt_P),167.0489);
b11_samp = [b11_15G(218:289),b11_15G(290:361)];
b21_samp = [b21_15G(218:289),b21_15G(290:361)];
a21_samp = [a21_15G(218:289),a21_15G(290:361)];
b11_samp = b11_samp(1:6:end);
b21_samp = b21_samp(1:6:end);
a21_samp = a21_samp(1:6:end);
ref_coeff=a21_samp/b21_samp;

B21_mat = [b21_15G(2:73),b21_15G(74:145),b21_15G(146:217),b21_15G(218:289),b21_15G(290:361),b21_15G(362:433),b21_15G(434:505),b21_15G(506:577),b21_15G(578:649)];
A21_mat = [a21_15G(2:73),a21_15G(74:145),a21_15G(146:217),a21_15G(218:289),a21_15G(290:361),a21_15G(362:433),a21_15G(434:505),a21_15G(506:577),a21_15G(578:649)];
A11_mat = [a11_15G(2:73),a11_15G(74:145),a11_15G(146:217),a11_15G(218:289),a11_15G(290:361),a11_15G(362:433),a11_15G(434:505),a11_15G(506:577),a11_15G(578:649)];
B11_mat = [b11_15G(2:73),b11_15G(74:145),b11_15G(146:217),b11_15G(218:289),b11_15G(290:361),b11_15G(362:433),b11_15G(434:505),b11_15G(506:577),b11_15G(578:649)];


Op_gain = Pout_dBm./Pin_dBm;
Op_gain_mat = [Op_gain(2:73),Op_gain(74:145),Op_gain(146:217),Op_gain(218:289),Op_gain(290:361),Op_gain(362:433),Op_gain(434:505),Op_gain(506:577),Op_gain(578:649)];
Op_gain_dB = 10*log10(Pout_W./Pin_W);
Op_gain_dB_mat = [Op_gain_dB(2:73),Op_gain_dB(74:145),Op_gain_dB(146:217),Op_gain_dB(218:289),Op_gain_dB(290:361),Op_gain_dB(362:433),Op_gain_dB(434:505),Op_gain_dB(506:577),Op_gain_dB(578:649)];
XA=-1.1104 + 0.5091i;
XB=0.0283 - 0.0134i;
XC=-0.0061 - 0.0062i;

a21_lsop=-0.0324 - 0.0499i;
B11_mod = XA + XB*(a21_15G-a21_lsop) + XC*conj(a21_15G-a21_lsop);
B11_mod_mat = [B11_mod(2:73),B11_mod(74:145),B11_mod(146:217),B11_mod(218:289),B11_mod(290:361),B11_mod(362:433),B11_mod(434:505),B11_mod(506:577),B11_mod(578:649)];

plot(1:1:19,select_Meas,'rx')

%b21s_Q = Xf + Xs*a21_15G + Xt*conj(a21_15G) + Xu*(a21_15G).^2 + Xv*conj(a21_15G).^2 + Xw*(a21_15G).*conj(a21_15G);
%b21opt_Pade = G21+(G21_21_10*a21_15G+G21_21_01*conj(a21_15G)+G21_21_11*a21_15G.*conj(a21_15G))./(1+H21_21_10*a21_15G+H21_21_01*conj(a21_15G)+H21_21_11*conj(a21_15G).*a21_15G);
%b21opt1_P = G21+(G21_21_10*a21_15G+G21_21_01*conj(a21_15G)+G21_num_reg*a21_15G.*a21_15G+G21_num_conj*conj(a21_15G).*conj(a21_15G)+G21_21_11*a21_15G.*conj(a21_15G))./(1+H21_21_10*a21_15G+H21_21_01*conj(a21_15G)+H21_21_11*conj(a21_15G).*a21_15G);
%b21opt1_P_v1 = G21+(G21_21_10*a21_15G+G21_21_01*conj(a21_15G)+G21_num_reg*a21_15G.*a21_15G+G21_num_conj*conj(a21_15G).*conj(a21_15G)+G21_21_11*a21_15G.*conj(a21_15G))./(1+H21_21_10*a21_15G+H21_21_01*conj(a21_15G)+H21_den_reg*a21_15G.*a21_15G+H21_den_conj*conj(a21_15G).*conj(a21_15G)+H21_21_11*conj(a21_15G).*a21_15G);
%Pout_dBm_QPHD_mat = [Pout_dBm_QPHD(2:73),Pout_dBm_QPHD(74:145),Pout_dBm_QPHD(146:217),Pout_dBm_QPHD(218:289),Pout_dBm_QPHD(290:361),Pout_dBm_QPHD(362:433),Pout_dBm_QPHD(434:505),Pout_dBm_QPHD(506:577),Pout_dBm_QPHD(578:649)];
%Pout_dBm_mat = [Pout_dBm(2:73),Pout_dBm(74:145),Pout_dBm(146:217),Pout_dBm(218:289),Pout_dBm(290:361),Pout_dBm(362:433),Pout_dBm(434:505),Pout_dBm(506:577),Pout_dBm(578:649)];
%Pout_dBm_Pade_mat = [Pout_dBm_Pade(2:73),Pout_dBm_Pade(74:145),Pout_dBm_Pade(146:217),Pout_dBm_Pade(218:289),Pout_dBm_Pade(290:361),Pout_dBm_Pade(362:433),Pout_dBm_Pade(434:505),Pout_dBm_Pade(506:577),Pout_dBm_Pade(578:649)];
%end
fileName = '10APR19_S2PSWEEP_-5V30V';
save(fileName,'VGSQ','VDSQ','IGSQ','IDSQ','VGS','VDS','IG','ID');

XYs = XY_QPHD(1);
XYt = XY_QPHD(2);
XYu = XY_QPHD(3);
XYv = XY_QPHD(4);
XYw = XY_QPHD(5);
VD_1rstd = VD_1rst - VD_1rst(1);
Imod_Q = XY_F + XYs*VD_1rstd + XYt*conj(VD_1rstd) + XYu*(VD_1rstd).^2 + XYv*conj(VD_1rstd).^2 + XYw*(VD_1rstd).*conj(VD_1rstd);
ImodQ_mat = [Imod_Q(2:73),Imod_Q(74:145),Imod_Q(146:217),Imod_Q(218:289),Imod_Q(290:361),Imod_Q(362:433),Imod_Q(434:505),Imod_Q(506:577),Imod_Q(578:649)];
magImod_Q = sqrt(real(ImodQ_mat).^2 + imag(ImodQ_mat).^2);

Imeas_mat = [ID_1rst(2:73),ID_1rst(74:145),ID_1rst(146:217),ID_1rst(218:289),ID_1rst(290:361),ID_1rst(362:433),ID_1rst(434:505),ID_1rst(506:577),ID_1rst(578:649)];
magImeas = sqrt(real(Imeas_mat).^2 + imag(Imeas_mat).^2);

figure
mesh(real(Load_point_mat_inv),imag(Load_point_mat_inv),magImeas,'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o')
hold on;
mesh(real(Load_point_mat_inv),imag(Load_point_mat_inv),magImod_Q)

G21_21_10XY=XY_P(1);
G21_21_01XY=XY_P(2);
G21_21_11XY=XY_P(3);
H21_21_10XY=XY_P(4);
H21_21_01XY=XY_P(5);
H21_21_11XY=XY_P(6);
G21_XY = XY_F;
Imod_Pade = G21_XY+(G21_21_10XY*VD_1rstd+G21_21_01XY*conj(VD_1rstd)+G21_21_11XY*VD_1rstd.*conj(VD_1rstd))./(1+H21_21_10XY*VD_1rstd+H21_21_01XY*conj(VD_1rstd)+H21_21_11XY*conj(VD_1rstd).*VD_1rstd);
ImodP_mat = [Imod_Pade(2:73),Imod_Pade(74:145),Imod_Pade(146:217),Imod_Pade(218:289),Imod_Pade(290:361),Imod_Pade(362:433),Imod_Pade(434:505),Imod_Pade(506:577),Imod_Pade(578:649)];
magImod_P = sqrt(real(ImodP_mat).^2 + imag(ImodP_mat).^2);

figure
mesh(real(Load_point_mat_inv),imag(Load_point_mat_inv),magImeas,'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o')
hold on;
mesh(real(Load_point_mat_inv),imag(Load_point_mat_inv),magImod_P)

modA = (VD_1rst + 50*Imod_Pade)/(2*sqrt(50));
modB = (VD_1rst - 50*Imod_Pade)/(2*sqrt(50));
% frewind(fp1);
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
% ii = ii+415;
% while ~feof(fp1)
%     currLine = fgetl(fp1);
%     if length(currLine) >=6 && strcmp(currLine(1:6),'VAR VG')
%         break
%     end
%     ii = ii + 1;
% end
% frewind(fp1);
% 
% data = textscan(fp1,'VAR %*s%f','HeaderLines',ii);