type objfunx

% a21 = optimvar('a21');
% a21conj = optimvar('a21conj');

x = optimvar('x');
y = optimvar('y');

% G21 = -0.586689002649106 + 0.119498151170060i;             %5dBm
% G21_21_10 = -0.321860941174793 - 0.409654852167480i;
% G21_21_01 = -0.052885661920374 - 0.035696187937631i;
% G21_21_11 = 0.050748946513414 - 0.047951602220206i;
% H21_21_10 =  0.027221369822955 + 0.039298387749102i;
% H21_21_01 = 0.110789435385194 + 0.147112895227818i;
% H21_21_11 = -0.040221169168618 - 0.240045542246385i;
% Xf = -0.586689002649106 + 0.119498151170060i;
% Xs = -0.298850935342029 - 0.426174195983382i;
% Xt = -0.048800896077631 - 0.039778779368374i;
% Xu= -0.000364770159219 + 0.043508243408522i;
% Xv= -0.009743533994949 + 0.002448022954559i;
% Xw= 0.038753856045761 + 0.019813506547375i;
% 
% var=[Xf Xs Xt Xu Xv Xw];

%b21s(a21,a21conj) = G21 + (G21_21_10*a21 + G21_21_01*a21conj + G21_21_11*a21*a21conj)./(1 + H21_21_10*a21 + H21_21_01*a21conj + H21_21_11*a21*a21conj);

%obj = fcn2optimexpr(@objfunx,x,y);
obj = fcn2optimexpr(@objfunx,x,y);

prob = optimproblem('Objective',-obj);

% % The largest |A21| will occur at the largest gamma
% a21max = A21MXM(end,:);
% 
% % Find distance of optima from centre
% a21s_opt_dist = abs(a21s_opts_pade);
% 
% % Find distance to a21 region boundary along same direction
% a21s_boundary_dist = interp1([angle(a21max)-2*pi, angle(a21max),angle(a21max)+2*pi], abs([a21max, a21max, a21max]),angle(double(a21s_opt_vec)));
% 
% % Compare distances
% a21s_dist = a21s_boundary_dist - a21s_opt_dist;
% 
% % Find those a21 values that are inside the boundary
% a21s_inside = a21s_opts_pade(a21s_dist>0);

%TiltEllipse = x.*y/2 + (x+2).^2 + (y-2).^2/2 <= 2;

%RectBoundary = 2*pi*x*conj(x) <= max(abs(a21_15G));
%RectBoundary = x.^2 + (y).^2 <= max(abs(a21_15G));
RectBoundary = x.^2 + (y).^2 <= max(abs(a21));

%RectBoundary = x.^2 + (y).^2 <= max(abs(VD_1rstd));

%prob.Constraints.constr = TiltEllipse;
prob.Constraints.constr = RectBoundary;

x0.x = 0.2;
x0.y = 0.8;

showproblem(prob)

[sol,fval] = solve(prob,x0)

x0.x = -0.1;
x0.y = -0.4;
[sol2,fval2] = solve(prob,x0)

f = @objfunx;
%g = @(x,y) x.*y/2+(x+2).^2+(y-2).^2/2-2;
%g = @(x)2*pi*abs(x) - max(abs(a21_15G));
%g = @(x,y)x.^2 + (y).^2 - max(abs(a21_15G))^2;
g = @(x,y)x.^2 + (y).^2 - max(abs(a21))^2;
%g = @(x,y)x.^2 + (y).^2 - max(abs(VD_1rstd))^2;
rnge = [-5.5 -0.25 -0.25 7];
fimplicit(g,'k-')
%axis(rnge);
hold on
fcontour(f,'LevelList',logspace(-1,1))
plot(sol.x,sol.y,'ro','LineWidth',2)
plot(sol2.x,sol2.y,'ko','LineWidth',2)
legend('Constraint','f Contours','Global Solution','Local Solution','Location','northeast');
hold off