%clear all;
% X parameter optim load

% Xf = -0.693095423293088 + 0.421923668004367i;
% Xs = 0.543367790203262 - 0.157670247073378i;
% Xt = -0.072484899492155 - 0.030324837305735i;

% Xf = -0.5867 + 0.1195i; %10 dBm
% Xs = -0.2924 - 0.4151i;
% Xt = -0.0438 - 0.0442i;

% Xf = -2.0466 + 0.3289i; %20 dBm
% Xs = -0.3192 - 0.3262i;
% Xt = -0.0585 - 0.0538i;

% Xf = -3.3787 + 0.4349i; %25 dBm
% Xs = -0.3623 - 0.2598i;
% Xt = -0.0752 - 0.0548i;

Xf = -4.4502 + 0.4315i; %25 dBm
Xs = -0.4585 - 0.1378i;
Xt = -0.1254 - 0.0813i;


% XI = 0.151;
% XY = 0.072 + 0.043i;

XI = 0.151;
XY = 0.072 + 0.043i;



syms a21 a21conj
assume(a21,'real')
assume(a21conj,'real')

Id = XI + real(XY*a21);
Pdc = 2*15*Id;

b21s(a21,a21conj) = Xf + Xs*a21 + Xt*a21conj;
Pouts(a21,a21conj) = b21s(a21,a21conj)*conj(b21s(a21conj,a21)) - a21*a21conj;
f100 = ((Xf + Xs*a21 + Xt*a21conj)*(conj(Xf) + conj(Xs)*a21conj + conj(Xt)*a21)) - a21*a21conj;
f101 = expand(f100);
df101 = diff(f101,a21);
df102 = diff(f101,a21conj);
eqns = [df101 ==0,df102==0,a21conj == conj(a21)];
solx101 = solve(eqns,[a21 a21conj]);
a21opt=vpa(solx101.a21);
a21opt1=vpa(solx101.a21conj);
b21optX = Xf + Xs*a21opt + Xt*conj(a21opt);
gammaOptX = a21opt/b21optX;

syms a21 a21conj a21R a21I
assume(a21,'real')
assume(a21conj,'real')

Pouts(a21,a21conj) = (b21s(a21,a21conj)*conj(b21s(a21conj,a21)) - a21*a21conj);

eqn1(a21,a21conj) = diff(Pouts,a21) == 0;
eqn2(a21,a21conj) = diff(Pouts,a21conj) == 0;

eqn3 = eqn1(a21R+1j*a21I, a21R-1j*a21I);
eqn4 = eqn2(a21R+1j*a21I, a21R-1j*a21I);

digits(8)
tic;
soln = vpasolve(eqn3, eqn4);
toc;
a21s = soln.a21R + 1j*soln.a21I;
b21optX = Xf + Xs*a21s + Xt*conj(a21s);
gammaOptX = a21s/b21optX;

Pouts_Pdc(a21,a21conj) = (b21s(a21,a21conj)*conj(b21s(a21conj,a21)) - a21*a21conj)./(2*15*(XI+real(XY*a21)));
Pouts_Pdc1(a21,a21conj) = (b21s(a21,a21conj)*conj(b21s(a21conj,a21)) - a21*a21conj)./(2*15*(XI+real(XY*a21conj)));

eqn5(a21,a21conj) = diff(Pouts_Pdc,a21) == 0;
eqn6(a21,a21conj) = diff(Pouts_Pdc1,a21conj) == 0;

eqn7 = eqn5(a21R+1j*a21I, a21R-1j*a21I);
eqn8 = eqn6(a21R+1j*a21I, a21R-1j*a21I);

tic;
soln1 = vpasolve(eqn7, eqn8);
toc;

a21s_eff = soln1.a21R + 1j*soln1.a21I;
b21opt1_X_eff = Xf + Xs*a21s_eff + Xt*conj(a21s_eff);
gammaOpt_X_eff = a21s_eff./b21opt1_X_eff;

%QPHD optim load

Xf = -0.717162403598043 + 0.781343504680774i;
Xs = 0.401007003073681 - 0.091676835758963i;
Xt = -0.073691669993435 + 0.000601387633707i;
Xu=0.153738925150484 + 0.100409907634637i;
Xv=0.152460457389161 + 0.198265672287320i;
Xw=0.258126588485069 - 0.383178894894214i;

syms a21 a21conj
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
sm1=smithchart;
hold all;plot(real(gammaOptQ),imag(gammaOptQ),'ro','LineWidth',1.5);

f_test = ((Xf + Xs*a21 + Xt*a21conj + Xu*a21^2 + Xv*a21conj^2 + Xw*a21*a21conj)*(conj(Xf) + conj(Xs)*a21conj + conj(Xt)*a21 + conj(Xu)*a21conj^2 + conj(Xv)*a21^2 + conj(Xw)*a21*a21conj)) - a21*a21conj;
f1_test = expand(f_test);
df11_test = diff(f1_test,a21);
df12_test = diff(f1_test,a21conj);
eqns1_test = [df11_test ==0,df12_test==0];
[solx11_test] = vpasolve(df11_test,df12_test);
b21opt1_Qtest = Xf + Xs*solx11_test.a21 + Xt*conj(solx11_test.a21) + Xu*(solx11_test.a21).^2 + Xv*conj(solx11_test.a21).^2 + Xw*abs(solx11_test.a21).^2;
gammaOpt_test = solx11_test.a21./b21opt1_Qtest;
gammaOptQ_test = double(gammaOpt_test);
plot(real(gammaOptQ_test),imag(gammaOptQ_test),'bo','LineWidth',1.5);
xyz=1;
plot(real(0.242),imag(0.021),'x')
% Padé 11/11 optim load

G21 = -0.717162403598043 + 0.781343504680774i;             %5dBm
G21_21_10 = 0.262488074794491 - 0.060102679125166i;
G21_21_01 = -0.035696694394138 - 0.027589727443544i;
G21_21_11 = 0.307136647596647 - 0.264393668724419i;
H21_21_10 = -0.302102537146003 - 0.210601202261505i;
H21_21_01 = 0.283953165751096 + 0.124239155559639i;
H21_21_11 = -2.370545432262354 - 0.219051551416814i;

% G21_21_10 = 0.399073107887751 - 0.079026750514570i;
% G21_21_01 = -0.047461945877245 - 0.019440247393239i;
% G21_21_11 = 0.403718199094166 - 0.335199870437252i;
% H21_21_01 = 0.361595268628598 + 0.215593296672353i;

syms a21 a21conj a21R a21I
assume(a21,'real')
assume(a21conj,'real')

b21s(a21,a21conj) = G21 + (G21_21_10*a21 + G21_21_01*a21conj + G21_21_11*a21*a21conj)./(1 + H21_21_10*a21 + H21_21_01*a21conj + H21_21_11*a21*a21conj);
Pouts(a21,a21conj) = b21s(a21,a21conj)*conj(b21s(a21conj,a21)) - a21*a21conj;

eqn1(a21,a21conj) = diff(Pouts,a21) == 0;
eqn2(a21,a21conj) = diff(Pouts,a21conj) == 0;

eqn3 = eqn1(a21R+1j*a21I, a21R-1j*a21I);
eqn4 = eqn2(a21R+1j*a21I, a21R-1j*a21I);

digits(8)
soln = vpasolve(eqn3, eqn4);
a21s = soln.a21R + 1j*soln.a21I;
b21opt1_P = (G21+G21_21_10*a21s+G21_21_01*conj(a21s)+G21_21_11*a21s.*conj(a21s))./(1+H21_21_10*a21s+H21_21_01*conj(a21s)+H21_21_11*conj(a21s).*a21s);
gammaOpt_P = a21s./b21opt1_P;
gammaOptP = double(gammaOpt_P);

sm2=smithchart;
hold all;plot(real(gammaOptP),imag(gammaOptP),'ro','LineWidth',1.5);

% fP = G21*conj(G21)+(((G21_21_10*a21+G21_21_01*a21conj+G21_21_11*a21*a21conj)./(1+H21_21_10*a21+H21_21_01*a21conj+H21_21_11*a21conj*a21))*((conj(G21_21_10)*a21conj+conj(G21_21_01)*a21+conj(G21_21_11)*a21*a21conj)./(1+conj(H21_21_10)*a21conj+conj(H21_21_01)*a21+conj(H21_21_11)*a21*a21conj))) - a21*a21conj;
% f1P = expand(fP);
% df11P = diff(f1P,a21);
% df12P = diff(f1P,a21conj);
% eqns1P = [df11P ==0,df12P==0];
% solx11P = vpasolve(df11P,df12P);
% % a21opt_P=vpa(solx11P.a21);
% % a21opt1P=vpa(solx11P.a21conj);
% b21opt1_P = (G21+G21_21_10*a21opt_P+G21_21_01*conj(a21opt_P)+G21_21_11*a21opt_P*conj(a21opt_P))/(1+H21_21_10*a21opt_P+H21_21_01*conj(a21opt_P)+H21_21_11*conj(a21opt_P)*a21opt_P);
% gammaOpt_P = a21opt_P./b21opt1_P;
% gammaOptP = double(gammaOpt_P);


% fP = (((G21+G21_21_10*a21+G21_21_01*a21conj+G21_21_11*a21*a21conj)/(1+H21_21_10*a21+H21_21_01*a21conj+H21_21_11*a21*a21conj))*(conj(G21)+conj(G21_21_10)*a21conj+conj(G21_21_01)*a21+conj(G21_21_11)*a21*a21conj)/(1+conj(H21_21_10)*a21conj+conj(H21_21_01)*a21+conj(H21_21_11)*a21*a21conj)) - a21*a21conj;
% f1P = expand(fP);
% df11P = diff(f1P,a21);
% df12P = diff(f1P,a21conj);
% eqns1P = [df11P ==0,df12P==0];
% solx11P = solve(eqns1P,[a21 a21conj]);
% a21opt_P=vpa(solx11P.a21);
% a21opt1P=vpa(solx11P.a21conj);
% b21opt1_P = (G21+G21_21_10*a21opt_P+G21_21_01*conj(a21opt_P)+G21_21_11*a21opt_P*conj(a21opt_P))/(1+H21_21_10*a21opt_P+H21_21_01*conj(a21opt_P)+H21_21_11*a21opt_P*conj(a21opt_P));
% gammaOpt_P = a21opt_P./b21opt1_P;
% gammaOptP = double(gammaOpt_P);
% figure
% sm2=smithchart;
% hold all;plot(real(gammaOptP),imag(gammaOptP),'ro','LineWidth',1.5);