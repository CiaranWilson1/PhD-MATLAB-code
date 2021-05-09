load('WavesMat.mat');
load('WavesMat1.mat');

G21 = B21_LSOP;             
G21_21_10 = P(1);
G21_21_01 = P(2);
G21_21_11 = P(3);
H21_21_10 = P(4);
H21_21_01 = P(5);
H21_21_11 = P(6);

Xf = B21_LSOP;                 
Xs = XQPHD(1);
Xt = XQPHD(2);
Xu= XQPHD(3);
Xv=  XQPHD(4);
Xw=XQPHD(5);

b21_Pade = G21+(G21_21_10*A21_mat_ext+G21_21_01*conj(A21_mat_ext)+G21_21_11*A21_mat_ext.*conj(A21_mat_ext))./(1+H21_21_10*A21_mat_ext+H21_21_01*conj(A21_mat_ext)+H21_21_11*conj(A21_mat_ext).*A21_mat_ext);
b21_Q=Xf + Xs*(A21_mat_ext) + Xt*conj(A21_mat_ext) + Xu*(A21_mat_ext).^2 + Xv*conj(A21_mat_ext).^2 + Xw*(A21_mat_ext).*conj(A21_mat_ext);

Pout_mod_P = abs(b21_Pade).^2-abs(A21_mat_ext).^2;
Pout_mod_Q = abs(b21_Q).^2-abs(A21_mat_ext).^2;

Pin_mod=Mess_Pin+real(Mess_SS*A21_mat_ext);
%Pin_mod=Mess_Pin+real(Mess_SS_V1*A21_mat_ext+Mess_SS1_V1*A21_mat_ext);

Op_gain_mod_P = Pout_mod_P./Pin_mod; %linear gain units
Op_gain_mod_Q = Pout_mod_Q./Pin_mod; 

Gamma_ext = A21_mat_ext./B21_mat_ext;


B21_mat = B21_mat_ext(:,1:9);
A21_mat = A21_mat_ext(:,1:9);
Pout_meas = abs(B21_mat).^2-abs(A21_mat).^2;
Pin_meas = abs(A11_mat).^2-abs(B11_mat).^2;

Op_gain_meas = Pout_meas./Pin_meas; 
[M,I]=max(Op_gain_meas(:));

XI = 0.6134;               %2.5GHz 30dBm
XY=0.0300 + 0.0933i;

Pdc_mod=2*28*(XI+real(XY*A21_mat));

Eff=Pout_meas./Pdc_mod;

Max_index=392;

Op_gain_mod_P_tru=Op_gain_mod_P(:,1:9);
Op_gain_mod_Q_tru=Op_gain_mod_Q(:,1:9);
Err_Q = abs(sum(sum(Op_gain_mod_Q_tru-Op_gain_meas)));
Err_P = abs(sum(sum(Op_gain_mod_P_tru-Op_gain_meas)));

Gamma = A21_mat./B21_mat;

mag=0.1:0.1:0.9;
mag_mat=repmat(mag,72,1);

phase = 0:5:355;
phase_mat=repmat(phase,9,1).';

% figure
% mesh(real(Gamma_ext),imag(Gamma_ext),Op_gain_mod_P)
% hold on;
% mesh(real(Gamma),imag(Gamma),Op_gain_meas,'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o', 'FaceAlpha', 0)
% title('Pade vs meas')
% 
% figure
% mesh(real(Gamma_ext),imag(Gamma_ext),Op_gain_mod_Q)
% hold on;
% mesh(real(Gamma),imag(Gamma),Op_gain_meas,'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o', 'FaceAlpha', 0)
% title('QPHD vs meas')

%[pks,locs]=findpeaks(Op_gain_mod(:));

% Mess_Pin=0.5120;            %2.5GHz 30dBm
% Mess_SS_V1 = 0.0746+1j*0.0169;
% Mess_SS1_V1 = 0.0033-1j*0.0013;

%G21 = -0.7844 + 0.1040i;             %10dBm diffLSOP
G21_21_10 = -0.5055 - 0.1686i;
G21_21_01 = -0.0025 - 0.0913i;
G21_21_11 = -0.0601 + 0.0006i;
H21_21_10 = 0.0162 - 0.0294i;
H21_21_01 = 0.0166 - 0.0439i;
H21_21_11 = -0.0035 + 0.0013i;

%fun = abs(G21+(G21_21_10*(x(1)+x(2)*1j)+G21_21_01*conj((x(1)+x(2)*1j))+G21_21_11*(x(1)+x(2)*1j).*conj((x(1)+x(2)*1j)))./(1+H21_21_10*(x(1)+x(2)*1j)+H21_21_01*conj((x(1)+x(2)*1j))+H21_21_11*conj((x(1)+x(2)*1j)).*(x(1)+x(2)*1j))).^2-(x(1)+x(2)*1j)*conj((x(1)+x(2)*1j));
fun = @(x)-1*((abs(G21+(G21_21_10*(x(1)+x(2)*1j)+G21_21_01*conj((x(1)+x(2)*1j))+G21_21_11*(x(1)+x(2)*1j).*conj((x(1)+x(2)*1j)))./(1+H21_21_10*(x(1)+x(2)*1j)+H21_21_01*conj((x(1)+x(2)*1j))+H21_21_11*conj((x(1)+x(2)*1j)).*(x(1)+x(2)*1j))).^2-(x(1)+x(2)*1j)*conj((x(1)+x(2)*1j)))/(Mess_Pin + real(Mess_SS)*(x(1))+(-1)*imag(Mess_SS)*(x(2))));
%fun = @(x)-1*((abs(G21+(G21_21_10*(x(1)+x(2)*1j)+G21_21_01*conj((x(1)+x(2)*1j))+G21_21_11*(x(1)+x(2)*1j).*conj((x(1)+x(2)*1j)))./(1+H21_21_10*(x(1)+x(2)*1j)+H21_21_01*conj((x(1)+x(2)*1j))+H21_21_11*conj((x(1)+x(2)*1j)).*(x(1)+x(2)*1j))).^2-(x(1)+x(2)*1j)*conj((x(1)+x(2)*1j)))/(Mess_Pin + real(Mess_SS*(x(1)+1j*x(2)))));
%fun = @(x)-1*((abs(G21+(G21_21_10*(x(1)+x(2)*1j)+G21_21_01*conj((x(1)+x(2)*1j))+G21_21_11*(x(1)+x(2)*1j).*conj((x(1)+x(2)*1j)))./(1+H21_21_10*(x(1)+x(2)*1j)+H21_21_01*conj((x(1)+x(2)*1j))+H21_21_11*conj((x(1)+x(2)*1j)).*(x(1)+x(2)*1j))).^2-(x(1)+x(2)*1j)*conj((x(1)+x(2)*1j)))/(Mess_Pin + real(Mess_SS_V1*(x(1)+1j*x(2))+Mess_SS1_V1*(x(1)+1j*x(2))^2)));
%fun = @(x)-1*((abs(G21+(G21_21_10*(x(1)+x(2)*1j)+G21_21_01*conj((x(1)+x(2)*1j))+G21_21_11*(x(1)+x(2)*1j).*conj((x(1)+x(2)*1j)))./(1+H21_21_10*(x(1)+x(2)*1j)+H21_21_01*conj((x(1)+x(2)*1j))+H21_21_11*conj((x(1)+x(2)*1j)).*(x(1)+x(2)*1j))).^2-(x(1)+x(2)*1j)*conj((x(1)+x(2)*1j)))/(Mess_Pin + real(Mess_SS_V1)*(x(1))+(-1)*imag(Mess_SS_V1)*(x(2))+real(Mess_SS1_V1)*(x(1).^2)+(-1)*imag(Mess_SS1_V1)*(x(2).^2)));
x0=[-1.2,1];
x=fminsearch(fun,x0);

a21_Pade_opt=x(1)+x(2)*1j;
b21_Pade_opt=G21+(G21_21_10*a21_Pade_opt+G21_21_01*conj(a21_Pade_opt)+G21_21_11*a21_Pade_opt.*conj(a21_Pade_opt))./(1+H21_21_10*a21_Pade_opt+H21_21_01*conj(a21_Pade_opt)+H21_21_11*conj(a21_Pade_opt).*a21_Pade_opt);
Gamma_opt_P=a21_Pade_opt./b21_Pade_opt;

%Xf = -0.7844 + 0.1040i; %10 dBm qCPHD diffLSOP
Xs = -0.5073 - 0.1693i;
Xt = 0.0026 - 0.0991i;
Xu = 0.0143 - 0.0133i;
Xv = 0.0035 + 0.0026i;
Xw =  -0.0424 - 0.0158i;

fun1 = @(x)-1*((abs(Xf + Xs*(x(1)+x(2)*1j) + Xt*conj(x(1)+x(2)*1j) + Xu*(x(1)+x(2)*1j).^2 + Xv*conj(x(1)+x(2)*1j).^2 + Xw*(x(1)+x(2)*1j).*conj(x(1)+x(2)*1j)).^2-(x(1)+x(2)*1j)*conj((x(1)+x(2)*1j)))/(Mess_Pin + real(Mess_SS)*(x(1))+(-1)*imag(Mess_SS)*(x(2))));
%x0=[-1.2,1];
x1=fminsearch(fun1,x0);

a21_Q_opt=x1(1)+x1(2)*1j;
b21_Q_opt=Xf + Xs*(a21_Q_opt) + Xt*conj(a21_Q_opt) + Xu*(a21_Q_opt).^2 + Xv*conj(a21_Q_opt).^2 + Xw*(a21_Q_opt).*conj(a21_Q_opt);
Gamma_opt_Q=a21_Q_opt./b21_Q_opt;

Vq_p = interp2(mag_mat,phase_mat,Op_gain_mod_P_tru,abs(Gamma_opt_P),167.0489);
Vq_q = interp2(mag_mat,phase_mat,Op_gain_mod_Q_tru,abs(Gamma_opt_Q),165.5255);

figure
mesh(real(Gamma_ext),imag(Gamma_ext),Op_gain_mod_P)
hold on;
mesh(real(Gamma),imag(Gamma),Op_gain_meas,'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o', 'FaceAlpha', 0)
plot3(real(Gamma_opt_P),imag(Gamma_opt_P),Vq_p,'ro')
title('Pade vs meas')

figure
mesh(real(Gamma_ext),imag(Gamma_ext),Op_gain_mod_Q)
hold on;
mesh(real(Gamma),imag(Gamma),Op_gain_meas,'LineStyle', 'none','MarkerFaceColor', 'black', 'Marker', 'o', 'FaceAlpha', 0)
plot3(real(Gamma_opt_Q),imag(Gamma_opt_Q),Vq_q,'ro')
title('QPHD vs meas')

fun_eff_Q = @(x)-1*((abs(Xf + Xs*(x(1)+x(2)*1j) + Xt*conj(x(1)+x(2)*1j) + Xu*(x(1)+x(2)*1j).^2 + Xv*conj(x(1)+x(2)*1j).^2 + Xw*(x(1)+x(2)*1j).*conj(x(1)+x(2)*1j)).^2-(x(1)+x(2)*1j)*conj((x(1)+x(2)*1j)))/(2*28*(XI+real(XY)*(x(1))+(-1)*imag(XY)*x(2))));
%x0=[-1.2,1];
x_eff_Q=fminsearch(fun_eff_Q,x0);

a21_Q_eff=x_eff_Q(1)+x_eff_Q(2)*1j;
b21_Q_eff=Xf + Xs*(a21_Q_eff) + Xt*conj(a21_Q_eff) + Xu*(a21_Q_eff).^2 + Xv*conj(a21_Q_eff).^2 + Xw*(a21_Q_eff).*conj(a21_Q_eff);
Gamma_eff_Q=a21_Q_eff./b21_Q_eff;

Xs = -0.5073 - 0.1696i;
Xt = 0.0026 - 0.0991i;
Xu = 0.0151 - 0.0151i;
Xv = 0.0035 + 0.0025i;
Xw =  -0.0424 - 0.0158i;
Xz = 0.0001 - 0.0015i;

fun_eff_C = @(x)-1*((abs(Xf + Xs*(x(1)+x(2)*1j) + Xt*conj(x(1)+x(2)*1j) + Xu*(x(1)+x(2)*1j).^2 + Xv*conj(x(1)+x(2)*1j).^2 + Xw*(x(1)+x(2)*1j).*conj(x(1)+x(2)*1j) + Xz*(x(1)+x(2)*1j).^3).^2-(x(1)+x(2)*1j)*conj((x(1)+x(2)*1j)))/(2*28*(XI+real(XY)*(x(1))+(-1)*imag(XY)*x(2))));
%x0=[-1.2,1];
x_eff_C=fminsearch(fun_eff_C,x0);

a21_C_eff=x_eff_C(1)+x_eff_C(2)*1j;
b21_C_eff=Xf + Xs*(a21_C_eff) + Xt*conj(a21_C_eff) + Xu*(a21_C_eff).^2 + Xv*conj(a21_C_eff).^2 + Xw*(a21_C_eff).*conj(a21_C_eff) + Xz*(a21_C_eff).^3;
Gamma_eff_C=a21_C_eff./b21_C_eff;

fun_eff_P = @(x)-1*((abs(G21+(G21_21_10*(x(1)+x(2)*1j)+G21_21_01*conj((x(1)+x(2)*1j))+G21_21_11*(x(1)+x(2)*1j).*conj((x(1)+x(2)*1j)))./(1+H21_21_10*(x(1)+x(2)*1j)+H21_21_01*conj((x(1)+x(2)*1j))+H21_21_11*conj((x(1)+x(2)*1j)).*(x(1)+x(2)*1j))).^2-(x(1)+x(2)*1j)*conj((x(1)+x(2)*1j)))/(2*28*(XI+real(XY)*(x(1))+(-1)*imag(XY)*x(2))));
x_eff_P=fminsearch(fun_eff_P,x0);

a21_P_eff=x_eff_P(1)+x_eff_P(2)*1j;
b21_P_eff=G21+(G21_21_10*a21_P_eff+G21_21_01*conj(a21_P_eff)+G21_21_11*a21_P_eff.*conj(a21_P_eff))./(1+H21_21_10*a21_P_eff+H21_21_01*conj(a21_P_eff)+H21_21_11*conj(a21_P_eff).*a21_P_eff);
Gamma_eff_P=a21_P_eff./b21_P_eff;

% fun_eff_Q = @(x)-1*((abs(Xf + Xs*(x(1)+x(2)*1j) + Xt*conj(x(1)+x(2)*1j) + Xu*(x(1)+x(2)*1j).^2 + Xv*conj(x(1)+x(2)*1j).^2 + Xw*(x(1)+x(2)*1j).*conj(x(1)+x(2)*1j)).^2-(x(1)+x(2)*1j)*conj((x(1)+x(2)*1j)))/(2*28*(XI+real(XY)*(x(1))+(-1)*imag(XY)*x(2))));
% x_eff_P=fminsearch(fun2,x0);
% 
% a21_P_eff=x_eff_P(1)+x_eff_P(2)*1j;
% b21_P_eff=G21+(G21_21_10*a21_P_eff+G21_21_01*conj(a21_P_eff)+G21_21_11*a21_P_eff.*conj(a21_P_eff))./(1+H21_21_10*a21_P_eff+H21_21_01*conj(a21_P_eff)+H21_21_11*conj(a21_P_eff).*a21_P_eff);
% Gamma_eff_P=a21_P_eff./b21_P_eff;
%Pdc_mod=2*28*(XI+real(XY*a21_15G));
% figure
% mesh(real(Gamma),imag(Gamma),Pout_mod)
% 
% figure
% mesh(real(Gamma),imag(Gamma),Pin_mod)
% 
% figure
% mesh(real(Gamma),imag(Gamma),Op_gain_mod)

