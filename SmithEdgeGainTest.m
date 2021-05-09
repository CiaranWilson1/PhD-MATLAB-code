filename = 'C:\Users\ciara\Documents\Behavioral_thermal_wrk\b21_25d.txt';

fp1 = fopen(filename);

C = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','phasez');

jj=1;
phase = C{1}(:);
mag = C{2}(:);
mag1 = C{3}(:);
mag1=mag1(~isnan(mag1));
phase1 = C{4}(:);

phase1 = [phase1];
mag1 = [mag1];
b21=mag1.*exp(1j*(pi/180).*phase1);

filename = 'C:\Users\ciara\Documents\Behavioral_thermal_wrk\a11_25d.txt';

fp1 = fopen(filename);

C = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','phasez');


jj=1;
phase = C{1}(:);
mag = C{2}(:);
mag1 = C{3}(:);
mag1=mag1(~isnan(mag1));
phase1 = C{4}(:);

phase1 = [phase1];
mag1 = [mag1];
a11=mag1.*exp(1j*(pi/180).*phase1);


filename = 'C:\Users\ciara\Documents\Behavioral_thermal_wrk\a21_25d.txt';

fp1 = fopen(filename);

C = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','phasez');


jj=1;
phase = C{1}(:);
mag = C{2}(:);
mag1 = C{3}(:);
mag1=mag1(~isnan(mag1));
phase1 = C{4}(:);

phase1 = [phase1];
mag1 = [mag1];
a21=mag1.*exp(1j*(pi/180).*phase1);

filename = 'C:\Users\ciara\Documents\Behavioral_thermal_wrk\b11_25d.txt';

fp1 = fopen(filename);

C = textscan(fp1,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','phasez');


jj=1;
phase = C{1}(:);
mag = C{2}(:);
mag1 = C{3}(:);
mag1=mag1(~isnan(mag1));
phase1 = C{4}(:);

phase1 = [phase1];
mag1 = [mag1];
b11=mag1.*exp(1j*(pi/180).*phase1);

Pout_W = abs(b21).^2 - abs(a21).^2;
Pout_dBm = 10*log10(Pout_W) + 30;
Pin_W = abs(a11).^2 - abs(b11).^2;
Pin_dBm = 10*log10(Pin_W) + 30;

Load_points=mag.*exp(1j*(pi/180).*phase);
Load_point_mat=reshape(Load_points,11,72);

Op_gain_lin = Pout_W./Pin_W;
Op_gain_lin_mat=reshape(Op_gain_lin,11,72);

Op_gain_dB = 10*log10(Pout_W./Pin_W);
Op_gain_dB_mat=reshape(Op_gain_dB,11,72);

Pin_mat=reshape(Pin_W,11,72);
Pout_mat=reshape(Pout_W,11,72);

A21_mat=reshape(a21,11,72);
B21_mat=reshape(b21,11,72);

a21_samp_meas=A21_mat(5:6,1:6:end);
b21_samp_meas=B21_mat(5:6,1:6:end);

XI=0.0213;
XY=-0.0035+1j*-0.0288;

Pin_mod = XI + real(XY*a21);
Pin_mod_mat=reshape(Pin_mod,11,72);

figure
mesh(real(Load_point_mat),imag(Load_point_mat),Pin_mod_mat)
hold on;
mesh(real(Load_point_mat),imag(Load_point_mat),Pin_mat, 'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o')
% figure
% mesh(real(Load_point_mat),imag(Load_point_mat),Op_gain_lin_mat)
% 
% figure
% mesh(real(Load_point_mat),imag(Load_point_mat),Pin_mat)
% 
% title('Pin(Watts')
% 
% figure
% mesh(real(Load_point_mat),imag(Load_point_mat),Pout_mat)
% 
% title('Pout(Watts')

Op_gain = Pout_dBm./Pin_dBm;
Op_gain_mat=reshape(Op_gain,11,72);

% figure
% mesh(real(Load_point_mat),imag(Load_point_mat),Op_gain_mat)

a11(11:11:end)=[];
b11(11:11:end)=[];
a21(11:11:end)=[];
b21(11:11:end)=[];

Pout_W_cut = abs(b21).^2 - abs(a21).^2;
Pout_dBm_cut = 10*log10(Pout_W_cut) + 30;
Pin_W_cut = abs(a11).^2 - abs(b11).^2;
Pin_dBm_cut = 10*log10(Pin_W_cut) + 30;

Op_gain_cut = Pout_dBm_cut./Pin_dBm_cut;
Op_gain_cut_mat=reshape(Op_gain_cut,10,72);

Op_gain_W_cut = Pout_W_cut./Pin_W_cut;
Op_gain_W_cut_mat=reshape(Op_gain_W_cut,10,72);

Op_gain_dB_cut = 10*log10(Pout_W_cut./Pin_W_cut);
Op_gain_dB_cut_mat=reshape(Op_gain_dB_cut,10,72);

Load_points(11:11:end)=[];
Load_point_cut_mat=reshape(Load_points,10,72);

figure
mesh(real(Load_point_cut_mat),imag(Load_point_cut_mat),Op_gain_dB_cut_mat)