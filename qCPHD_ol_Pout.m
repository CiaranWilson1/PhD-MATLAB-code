Xf = -0.586689002649106 + 0.119498151170060i;
Xs = -0.298994963918691 - 0.427095595260937i;
Xt = -0.048770831902777 - 0.039710137307908i;
Xu= -0.008355135380771 + 0.047469212849975i;
Xv= -0.010509929539771 + 0.002425163767193i;
Xw= 0.039105105910569 + 0.019886202729734i;
Xz= 0.024811323700503 + 0.013775086188702i;

% Xf = -0.586689002649106 + 0.119498151170060i;
% Xs = -0.321948684394906 - 0.417179558365281i;
% Xt =-0.056653968881955 - 0.026124610015996i;
% Xu= -0.049239763071917 + 0.056287120588612i;
% Xv= -0.003247137284686 + 0.047192507332606i;
% Xw=0.078041604825163 + 0.037536121980198i;

syms a21 a21conj a21R a21I;
assume(a21, 'real');
assume(a21conj, 'real');

%% Pade

b21s(a21,a21conj) = Xf + Xs*a21 + Xt*a21conj + Xu*a21^2 + Xv*a21conj^2 + Xw*a21*a21conj + Xz*a21^3;
Pouts(a21,a21conj) = b21s(a21,a21conj)*conj(b21s(a21conj,a21)) - a21*a21conj;

eqn1(a21,a21conj) = diff(Pouts,a21) == 0;
eqn2(a21,a21conj) = diff(Pouts,a21conj) == 0;

eqn3 = eqn1(a21R+1j*a21I, a21R-1j*a21I);
eqn4 = eqn2(a21R+1j*a21I, a21R-1j*a21I);

soln = vpasolve(eqn3, eqn4);
a21s = soln.a21R + 1j*soln.a21I;

gammaL_opts_all_QPHD = a21s./b21s(a21s,conj(a21s));
gammaL_opts_pade = gammaL_opts_all_QPHD(abs(gammaL_opts_all_QPHD)<1);
a21s_opts_pade = a21s(abs(gammaL_opts_all_QPHD)<1);

Pout_opts_pade = Pouts(a21s(abs(gammaL_opts_all_QPHD)<1),conj(a21s(abs(gammaL_opts_all_QPHD)<1)));

%vpa((soln.a21R + 1j*soln.a21I)/b21s(soln.a21R + 1j*soln.a21I,soln.a21R - 1j*soln.a21I))

figure
sm1=smithchart;
hold all;plot(real(gammaL_opts_all_QPHD),imag(gammaL_opts_all_QPHD),'ro','LineWidth',1.5);