clear all;
stepx = 0.001;
stepy = 0.001;
Nx = 2*(2/stepx)+1;
Ny = 2*(2/stepx)+1;
[re,im] = meshgrid([-2:stepx:2], [-2:stepy:2]);
cplx = re + 1i*im;

Xf = -0.71999824 + 1j*0.86902761;
Xs = -0.74263136 + 1j*0.02878290;
Xt = 0.03285265 - 1j*0.01770515;

z2 = abs(Xf + Xs.*cplx + Xt.*conj(cplx)).^2 - abs(cplx).^2;



f_real2=diff(z2)/stepx;
f_imag2=diff(z2,1,2)/stepx;
% [f_real_min2, index]=min(abs(f_real2(:)));
% [index_real1, col] = ind2sub(size(f_real2), index);
f1i = interp1(1 : Ny, f_imag2,1.5 : Ny);
f2i = interp1(1 : Nx, f_real2.', 1.5 : Nx) .';

comp=abs(f1i)+abs(f2i);
[comp_min2,index2]=min(abs(comp(:)));
[row, col] = ind2sub(size(comp), index2);
a21opt=cplx(row,col);

temp=load('var1.mat');

Xf = temp.var1(1);
Xs = temp.var1(2);
Xt = temp.var1(3);
Xu = temp.var1(4);
Xv = temp.var1(5);
Xw = temp.var1(6);

f = abs(Xf + Xs*cplx + Xt*conj(cplx) + Xu*(cplx).^2 + Xv*conj(cplx).^2 + Xw*abs(cplx).^2).^2 - abs(cplx).^2;

f_real2_Q=diff(f)/stepx;
f_imag2_Q=diff(f,1,2)/stepx;
f1i_Q = interp1(1 : Ny, f_imag2_Q,1.5 : Ny);
f2i_Q = interp1(1 : Nx, f_real2_Q.', 1.5 : Nx) .';
comp_Q=abs(f1i_Q)+abs(f2i_Q);
[comp_min2_Q,index2_Q]=min(abs(comp_Q(:)));
[row_Q, col_Q] = ind2sub(size(comp_Q), index2_Q);
a21opt_Q=cplx(row_Q,col_Q);
b21opt1_Q = Xf + Xs*a21opt_Q + Xt*conj(a21opt_Q) + Xu*(a21opt_Q).^2 + Xv*conj(a21opt_Q).^2 + Xw*abs(a21opt_Q).^2;
gamma_opt_Q = a21opt_Q/b21opt1_Q;

[A2,index_JIC] = sort(abs(comp_Q(:)));
[row_JIC,col_JIC]=ind2sub(size(comp_Q),index_JIC(3));
a21opt_Q_JIC=cplx(row_JIC,col_JIC);
b21opt1_Q_JIC = Xf + Xs*a21opt_Q_JIC + Xt*conj(a21opt_Q_JIC) + Xu*(a21opt_Q_JIC).^2 + Xv*conj(a21opt_Q_JIC).^2 + Xw*abs(a21opt_Q_JIC).^2;
gamma_opt_Q_JIC = a21opt_Q_JIC/b21opt1_Q_JIC;

% f_real_min2_Q=min(abs(f_real2_Q(:)));
% temp_real2_Q=ismembertol(f_real2_Q(:),f_real_min2_Q,0.00000008);
% index_temp_r_Q=find(temp_real2_Q);
% mat_size_r_Q = size(f_real2_Q);
% index_real1_Q=mod(index_temp_r_Q,mat_size_r_Q(1));
% 
% f_imag2_Q=diff(f,1,2)/stepx;
% f_imag2_col_Q=f_imag2_Q;
% f_imag_min2_Q=min(abs(f_imag2_Q(:)));
% temp_imag2_Q=ismembertol(f_imag2_Q(:),f_imag_min2_Q,0.00000001);
% index_imag_r_Q=find(temp_imag2_Q);
% % if size_i(1) > 1
% %     temp_imag2=ismembertol(f_imag2(:),f_imag_min2,0.000005);
% %     index_imag_r=find(temp_imag2);
% %     mat_imag_r = size(f_imag2);
% %     index_imag1=mod(index_imag_r,mat_size_r(1));
% % else
%     mat_imag_r_Q = size(f_imag2_Q);
%     %index_imag1=mod(index_imag_r,mat_imag_r(1));
%     index_imag1_Q=ceil(index_imag_r_Q/mat_imag_r_Q(1));
% %end
% 
% a21opt1_Q = cplx(index_real1_Q-1,index_imag1_Q-1);
% b21opt1_Q = Xf + Xs*a21opt_Q + Xt*conj(a21opt_Q) + Xu*(a21opt_Q).^2 + Xv*conj(a21opt_Q).^2 + Xw*abs(a21opt_Q).^2;
% 
% gamma_opt_Q = a21opt_Q/b21opt1_Q;

% G21 =  -0.094237830519867 + 0.039953772853403i;                  %0dBm
% G21_21_10 =  0.283492558382193 - 0.739157310445064i;
% G21_21_01 = 0.196717498732184 + 0.385758698792531i;
% G21_21_11 = -1.144958508932638 + 2.336036140325407i;
% H21_21_10 =  -0.873521934681815 - 0.196360905109169i;
% H21_21_01 = -1.901143670008115 - 2.247891583460143i;
% H21_21_11 = 0.459739435824496 - 3.391083597211317i;
temp1 = load('P.mat');

G21 =  temp1.P(1);                  %5dBm
G21_21_10 = temp1.P(2);
G21_21_01 = temp1.P(3);
G21_21_11 = temp1.P(4);
H21_21_10 = temp1.P(5);
H21_21_01 = temp1.P(6);
H21_21_11 = temp1.P(7);

% G21 =  -0.524091197192612 + 0.422639643833792i;                  %10dBm
% G21_21_10 =  0.082399455394669 - 0.574733931289463i;
% G21_21_01 = -0.258673547836355 + 0.065229739300414i;
% G21_21_11 = 0.654534537495261 - 0.813848763901576i;
% H21_21_10 =  -0.168573444825493 + 0.004448759835583i;
% H21_21_01 = 0.222087567006629 + 0.180213173235506i;
% H21_21_11 = -0.542888872356165 + 0.438581957239720i;

f = abs((G21+G21_21_10*cplx+G21_21_01*conj(cplx)+G21_21_11*cplx.*conj(cplx))./(1+H21_21_10*cplx+H21_21_01*conj(cplx)+H21_21_11*cplx.*conj(cplx))).^2 - abs(cplx).^2;

f_real2_P=diff(f)/stepx;
f_imag2_P=diff(f,1,2)/stepx;
f1i_P = interp1(1 : Ny, f_imag2_P,1.5 : Ny);
f2i_P = interp1(1 : Nx, f_real2_P.', 1.5 : Nx) .';
comp_P=abs(f1i_P)+abs(f2i_P);
[comp_min2_P,index2_P]=min(abs(comp_P(:)));
[row_P, col_P] = ind2sub(size(comp_P), index2_P);
a21opt_P=cplx(row_P,col_P);

b21opt1_P = (G21+G21_21_10*a21opt_P+G21_21_01*conj(a21opt_P)+G21_21_11*a21opt_P*conj(a21opt_P))/(1+H21_21_10*a21opt_P+H21_21_01*conj(a21opt_P)+H21_21_11*a21opt_P*conj(a21opt_P));

gamma_opt_P = a21opt_P/b21opt1_P;

[A3,index_JIC_P] = sort(abs(comp_P(:)));
[row_JIC_P,col_JIC_P]=ind2sub(size(comp_P),index_JIC_P(5));
a21opt_P_JIC=cplx(row_JIC_P,col_JIC_P);
b21opt1_P_JIC = Xf + Xs*a21opt_P_JIC + Xt*conj(a21opt_P_JIC) + Xu*(a21opt_P_JIC).^2 + Xv*conj(a21opt_P_JIC).^2 + Xw*abs(a21opt_P_JIC).^2;
gamma_opt_P_JIC = a21opt_P_JIC/b21opt1_P_JIC;

% f1i = interp1(1 : Ny, f_imag2,1.5 : Ny);
% f2i = interp1(1 : Nx, f_real2.', 1.5 : Nx) .';
% 
% comp=f1i+f2i;
% comp_min2=min(abs(comp(:)));
% temp_comp2=ismembertol(comp(:),comp_min2,0.00000005);
% index_comp=find(temp_comp2);
actual_opt = 0.231+0.015i;
distanceQ = abs(actual_opt-gamma_opt_Q);
distanceQ_JIC = abs(actual_opt-gamma_opt_Q_JIC);
distanceP = abs(actual_opt-gamma_opt_P);
distanceP_JIC = abs(actual_opt-gamma_opt_P_JIC);