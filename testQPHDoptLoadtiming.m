Xf = -0.717162403625494 + 0.781343504711223i;
Xs =  0.400783307638738 - 0.090547753903487i;
Xt = -0.072592344416809 + 0.000942486974892i;
Xu=0.154136098429173 + 0.100155760211341i;
Xv=0.152047814377075 + 0.198493846060241i;
Xw=0.270588756336462 - 0.362254940849469i;

syms a21 a21conj a21R a21I
assume(a21,'real')
assume(a21conj,'real')

f = ((Xf + Xs*a21 + Xt*a21conj + Xu*a21^2 + Xv*a21conj^2 + Xw*a21*a21conj)*(conj(Xf) + conj(Xs)*a21conj + conj(Xt)*a21 + conj(Xu)*a21conj^2 + conj(Xv)*a21^2 + conj(Xw)*a21conj*a21)) - a21*a21conj;
df11 = diff(f,a21);
df12 = diff(f,a21conj);
eqns1 = [df11 ==0,df12==0];
[solx11] = solve(eqns1,[a21 a21conj],'ReturnConditions',true);
a21opt=vpa(solx11.a21);
a21opt1=vpa(solx11.a21conj);
b21opt1_Q = Xf + Xs*a21opt + Xt*conj(a21opt) + Xu*(a21opt).^2 + Xv*conj(a21opt).^2 + Xw*abs(a21opt).^2;
gammaOpt = a21opt./b21opt1_Q;
gammaOptQ = double(gammaOpt);
figure
sm1=smithchart;
hold all;plot(real(gammaOptQ),imag(gammaOptQ),'ro','LineWidth',1.5);

XI = 0.151;
XY = 0.072 + 0.043i;

Id = XI + real(XY*a21);
Pdc = 2*15*Id;

Id1 = XI + real(XY*a21conj);
Pdc1 = 2*15*Id1;

b21s(a21,a21conj) = Xf + Xs*a21 + Xt*a21conj + Xu*(a21).^2 + Xv*(a21conj).^2 + Xw*(a21.*a21conj);
Pouts(a21,a21conj) = b21s(a21,a21conj)*conj(b21s(a21conj,a21)) - a21*a21conj;

eqn1(a21,a21conj) = diff(Pouts,a21) == 0;
eqn2(a21,a21conj) = diff(Pouts,a21conj) == 0;

eqn3 = eqn1(a21R+1j*a21I, a21R-1j*a21I);
eqn4 = eqn2(a21R+1j*a21I, a21R-1j*a21I);

digits(8)
tic;
soln = vpasolve(eqn3, eqn4);
toc;
a21s = soln.a21R + 1j*soln.a21I;

Pouts_Pdc(a21,a21conj) = (b21s(a21,a21conj)*conj(b21s(a21conj,a21)) - a21*a21conj)./(2*15*(real(XI+XY*a21)));
Pouts_Pdc1(a21,a21conj) = (b21s(a21,a21conj)*conj(b21s(a21conj,a21)) - a21*a21conj)./(2*15*(real(XI+XY*a21)));

eqn5(a21,a21conj) = diff(Pouts_Pdc,a21) == 0;
eqn6(a21,a21conj) = diff(Pouts_Pdc1,a21conj) == 0;

eqn7 = eqn5(a21R+1j*a21I, a21R-1j*a21I);
eqn8 = eqn6(a21R+1j*a21I, a21R-1j*a21I);

tic;
soln1 = vpasolve(eqn7, eqn8);
toc;

a21s = soln1.a21R + 1j*soln1.a21I;
b21opt1_P_eff = Xf + Xs*a21s + Xt*conj(a21s) + Xu*(a21s).^2 + Xv*conj(a21s).^2 + Xw*abs(a21s).^2;
gammaOpt_P = a21s./b21opt1_P_eff;
figure
sm2=smithchart;
hold all;plot(real(gammaOpt_P),imag(gammaOpt_P),'ro','LineWidth',1.5);

filename = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\drain_eff.txt';

fp1 = fopen(filename);

C3 = textscan(fp1,'%f %f %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','X1');

drain_eff = C3{3}(:);
drain_eff_mat = reshape(real(drain_eff),size,size)';

filename1 = 'C:\Users\Ciaran Wilson\Documents\UMS_PDK_v1_wrk\a21_test.txt';
fp2 = fopen(filename1);
C1 = textscan(fp2,'%f %f %f / %f','Delimiter',{',','<invalid>'},...
'TreatAsEmpty',{'NA','na'},'CommentStyle','X1');

a21_mag = C1{3}(:);
a21_phase = C1{4}(:);
a21_meas=a21_mag.*exp(1j*(pi/180).*a21_phase);
size=20;
imag_a211 = reshape(imag(a21_meas),size,size)';
real_a211 = reshape(real(a21_meas),size,size)';

figure
contourf(imag_a211,real_a211, Pdel_Pade)
hold on;
%plot(imag(a21s),real(a21s),'ro','Linewidth',1.5)

a21s_mod=find(imag(a21s) > min_imag & imag(a21s) < max_imag & real(a21s) > min_real & real(a21s) < max_real);
new_a21s = a21s(a21s_mod);
new_b21s = b21opt1_P_eff(a21s_mod);
gamma_opt_new=new_a21s./new_b21s;

plot(imag(new_a21s),real(new_a21s),'ro','Linewidth',1.5)
hold off;

figure
sm2=smithchart;
hold all;plot(real(gamma_opt_new),imag(gamma_opt_new),'ro','LineWidth',1.5);
plot(real(gammaOpt_eff(1)),imag(gammaOpt_eff(1)),'go','LineWidth',1.5);
plot(0.6053,0.0211,'bx','Linewidth',1.5)
hold off;


df11_eff = diff(f./Pdc,a21);
df12_eff = diff(f./Pdc1,a21conj);
eqns1_eff = [df11_eff ==0,df12_eff==0];
[solx11_eff] = vpasolve(eqns1_eff,[a21 a21conj],'ReturnConditions',true);
a21opt_eff=vpa(solx11_eff.a21);
a21opt1_eff=vpa(solx11_eff.a21conj);
b21opt1_Q_eff = Xf + Xs*a21opt_eff + Xt*conj(a21opt_eff) + Xu*(a21opt_eff).^2 + Xv*conj(a21opt_eff).^2 + Xw*abs(a21opt_eff).^2;
gammaOpt_eff = a21opt_eff./b21opt1_Q_eff;
gammaOptQ_eff = double(gammaOpt_eff);
figure
sm2=smithchart;
hold all;plot(real(gammaOptQ_eff),imag(gammaOptQ_eff),'ro','LineWidth',1.5);