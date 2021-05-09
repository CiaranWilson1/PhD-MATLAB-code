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
% v2_mat =zeros(10,7);
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
qq=0;
while ii<9116            % 9765%10414%9116
frewind(fp1);
qq=qq+1;
data1 = textscan(fp1,'%*s %*s %*s %*s %f','HeaderLines',ii);
%data = textscan(fp1,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','HeaderLines',ii);
realLoad = data1{1}(1);
imagLoad = data1{1}(2);

Load_point(ll+1) = realLoad + 1i*imagLoad;
ii = ii + 14; %15%16
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

while oo<9116 %9765%10414%9116
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

oo = oo + 14; %15%16
ll = ll + 1;
end
Load_point_mat = [Load_point(2:73);Load_point(74:145);Load_point(146:217);Load_point(218:289);Load_point(290:361);Load_point(362:433);Load_point(434:505);Load_point(506:577);Load_point(578:649)];
Load_point_mat_inv = Load_point_mat.';

a11_15G=a1_mat(:,2);
b11_15G=b1_mat(:,2);
b21_15G=b2_mat(:,2);
a21_15G=a2_mat(:,2);

B21_mat = [b21_15G(2:73),b21_15G(74:145),b21_15G(146:217),b21_15G(218:289),b21_15G(290:361),b21_15G(362:433),b21_15G(434:505),b21_15G(506:577),b21_15G(578:649)];
A21_mat = [a21_15G(2:73),a21_15G(74:145),a21_15G(146:217),a21_15G(218:289),a21_15G(290:361),a21_15G(362:433),a21_15G(434:505),a21_15G(506:577),a21_15G(578:649)];

% mag_B21=abs(B21_mat);
% phase_B21=(180/pi)*atan(imag(B21_mat)./real(B21_mat));
% 
% test_B21_mat = mag_B21.*exp(1j*(pi/180).*phase_B21);

mags=0.1:0.1:0.9;

mags_ext = 0.1:0.1:1;
phase_ext = 0:5:355;

gamma_1=1*exp(1j*(pi/180).*phase_ext);

Load_point_mat = [Load_point(2:73);Load_point(74:145);Load_point(146:217);Load_point(218:289);Load_point(290:361);Load_point(362:433);Load_point(434:505);Load_point(506:577);Load_point(578:649);gamma_1];
Load_point_mat_inv = Load_point_mat.';

Mod_mat=zeros(72,10);
Mod_mat_B=zeros(72,10);

for qq=1:1:72
    a21_samp = A21_mat(qq,:);
    b21_samp = B21_mat(qq,:);
    a21_samp = a21_samp.';
    b21_samp = b21_samp.';
    
    X=[ones(1,9);mags;mags.^2];
    b=regress(a21_samp,X');
    
    Ymod_v2 = b(1) + b(2)*mags_ext + b(3)*mags_ext.^2;
    Mod_mat(qq,:)=Ymod_v2;
    
    b_b=regress(b21_samp,X');
    
    Ymod_B = b_b(1) + b_b(2)*mags_ext + b_b(3)*mags_ext.^2;
    Mod_mat_B(qq,:)=Ymod_B;
    
    
end
degrees_B21=(180/pi)*atan(imag(Mod_mat_B)./real(Mod_mat_B));
mag_B21 = abs(Mod_mat);                                          %This is done intentionally at gamma=1 magA=magB

B21_ext=mag_B21.*exp(1j*(pi/180).*degrees_B21);

B21_10 = B21_ext(:,10);
A21_10 = Mod_mat(:,10);

B21_mat_ext = [b21_15G(2:73),b21_15G(74:145),b21_15G(146:217),b21_15G(218:289),b21_15G(290:361),b21_15G(362:433),b21_15G(434:505),b21_15G(506:577),b21_15G(578:649),B21_10];
A21_mat_ext = [a21_15G(2:73),a21_15G(74:145),a21_15G(146:217),a21_15G(218:289),a21_15G(290:361),a21_15G(362:433),a21_15G(434:505),a21_15G(506:577),a21_15G(578:649),A21_10];

B11_mat = [b11_15G(2:73),b11_15G(74:145),b11_15G(146:217),b11_15G(218:289),b11_15G(290:361),b11_15G(362:433),b11_15G(434:505),b11_15G(506:577),b11_15G(578:649)];
A11_mat = [a11_15G(2:73),a11_15G(74:145),a11_15G(146:217),a11_15G(218:289),a11_15G(290:361),a11_15G(362:433),a11_15G(434:505),a11_15G(506:577),a11_15G(578:649)];

B21_col_ext=B21_mat_ext(:);
A21_col_ext=A21_mat_ext(:);

b21_samp_meas = [B21_col_ext(217:6:288),B21_col_ext(289:6:360),B21_col_ext(649:6:end)];
a21_samp_meas = [A21_col_ext(217:6:288),A21_col_ext(289:6:360),A21_col_ext(649:6:end)];

XF=b21_15G(1);

b21 = b21_samp_meas(:);
a21 = a21_samp_meas(:);

a21_lsop=a21_15G(1);

a21d = a21 - a21_lsop;
b21d = b21 - XF;

completeA = [a21d conj(a21d) abs(a21d).^2 -b21d.*a21d -b21d.*conj(a21d) -b21d.*abs(a21d).^2];
P = completeA\b21d;

designQPHDA21 = @(x) [x conj(x) x.^2 conj(x).^2 abs(x).^2];
XQPHD = designQPHDA21(a21d)\b21d;

% Mess_Pin=0.5120;            %2.5GHz 30dBm
Mess_SS = 0.0748+1j*0.0155;

Mess_Pin=0.5120;            %2.5GHz 30dBm
Mess_SS_V1 = 0.0746+1j*0.0169;
Mess_SS1_V1 = 0.0033-1j*0.0013;


B21_LSOP = b21_15G(1);
save('WavesMat.mat','B21_mat_ext','A21_mat_ext','B21_LSOP','P','Mess_Pin','Mess_SS')
save('WavesMat1.mat','B21_mat_ext','A21_mat_ext','B11_mat','A11_mat','B21_LSOP','XQPHD','Mess_Pin','Mess_SS')

Pout = abs(B21_mat_ext).^2-abs(A21_mat_ext).^2;

Mess_Pin=0.5120;            %2.5GHz 30dBm
Mess_SS = 0.0748+1j*0.0155;

% Mess_Pin=0.1608;            %2.5GHz 25dBm
% Mess_SS = 0.0749+1j*0.0156;

Pin_mod=Mess_Pin+real(Mess_SS*A21_mat_ext);
Pin_mod1=Mess_Pin+real(Mess_SS_V1*A21_mat_ext+Mess_SS1_V1*A21_mat_ext.^2);

Op_gain=Pout./Pin_mod;
%Pin_mod_mat = [Pin_mod(2:73),Pin_mod(74:145),Pin_mod(146:217),Pin_mod(218:289),Pin_mod(290:361),Pin_mod(362:433),Pin_mod(434:505),Pin_mod(506:577),Pin_mod(578:649)];

figure
mesh(real(Load_point_mat_inv),imag(Load_point_mat_inv),Pout)

figure
mesh(real(Load_point_mat_inv),imag(Load_point_mat_inv),Op_gain)

B21_col_ext = [b21_15G(1);B21_mat_ext(:)];
A21_col_ext = [a21_15G(1);A21_mat_ext(:)];
% b11_samp = [b11_15G(218:289),b11_15G(290:361)];
b21_samp_meas = [B21_col_ext(218:289),B21_col_ext(290:361),B21_col_ext(650:end)];
a21_samp_meas = [A21_col_ext(218:289),A21_col_ext(290:361),A21_col_ext(650:end)];

% B21_mat_v1=[B21_mat;B21_10];
% A21_mat_v1=[A21_mat;A21_10];

mags_ext = repmat(mags_ext,72,1);
phases = 0:5:355;
phases = repmat(phases,10,1);
phases=phases.';

Loads_points_mat_gen=mags_ext.*exp(1j*(pi/180).*phases);

figure
mesh(real(Load_point_mat_inv),imag(Load_point_mat_inv),abs(A21_mat),'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o', 'FaceAlpha', 0)
hold on;
mesh(real(Loads_points_mat_gen),imag(Loads_points_mat_gen),abs(Mod_mat))