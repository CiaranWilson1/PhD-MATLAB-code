function f = objfunx1(x,y,var)
% G21 = -0.586689002649106 + 0.119498151170060i;             %5dBm
% G21_21_10 = -0.328287737022337 - 0.413151969571731i;
% G21_21_01 = -0.057370788150323 - 0.024674466790515i;
% G21_21_11 = 0.271755548767194 - 0.312102398555833i;
% H21_21_10 = 0.018415674218181 + 0.148951572450663i;
% H21_21_01 = 0.301897478381723 + 0.698671063302179i;
% H21_21_11 = 0.037055902237714 - 1.138173591204688i;

G21 = var(1);             %5dBm
G21_21_10 = var(2);
G21_21_01 = var(3);
G21_21_11 = var(4);
H21_21_10 = var(5);
H21_21_01 = var(6);
H21_21_11 = var(7);

% Xf = -0.586689002649106 + 0.119498151170060i;
% Xs = -0.321948684394906 - 0.417179558365281i;
% Xt =-0.056653968881955 - 0.026124610015996i;
% Xu= -0.049239763071917 + 0.056287120588612i;
% Xv= -0.003247137284686 + 0.047192507332606i;
% Xw=0.078041604825163 + 0.037536121980198i;

% Xf = -0.586689002649106 + 0.119498151170060i;
% Xs = -0.290715863842733 - 0.435794622858921i;
% Xt = -0.046627479973793 - 0.041623852475762i;
% Xu= 0.022644523779474 + 0.036923563145155i;
% Xv= -0.005430401611282 + 0.005483964184558i;
% Xw= 0.012416861234907 + 0.008435977514641i;

% Xf = var(1);
% Xs = var(2);
% Xt = var(3);
% Xu= var(4);
% Xv= var(5);
% Xw= var(6);

XI = 0.0843551;
%XY = 0.030155554126115 - 0.038243323198444i;
XY=0.0478 - 0.0652i;

% XI = 0.6517;                %30dBm
% XY = 0.0938 + j*-0.0990;
% % 
% b21s(x,y) = G21 + (G21_21_10*x + G21_21_01*y + G21_21_11*x*y)./(1 + H21_21_10*x + H21_21_01*y + H21_21_11*x*y);
% 
% f = b21s(x,y)*conj(b21s(y,x)) - x*y;

%f=(abs(Xf + Xs*(x+y*1i) + Xt*conj(x+y*1i) + Xu*(x+y*1i)^2 + Xv*conj(x+y*1i) + Xw*(x+y*1i)*conj(x+y*1i)).^2 - (x+y*1i)*conj(x+y*1i))./(2*28*(XI + real(XY)*(x)+(-1)*imag(XY)*y));

%f=abs(G21 + ((G21_21_10)*x + (G21_21_01)*y + (G21_21_11)*x*y)./(1 + (H21_21_10)*x + (H21_21_01)*y + (H21_21_11)*x*y)).^2 - x*y;
%f=abs(G21 + ((G21_21_10)*(x+y*1i) + (G21_21_01)*conj((x+y*1i)) + (G21_21_11)*(x+y*1i)*conj((x+y*1i)))./(1 + (H21_21_10)*(x+y*1i) + (H21_21_01)*conj((x+y*1i)) + (H21_21_11)*(x+y*1i)*conj((x+y*1i)))).^2 - (x+y*1i)*conj((x+y*1i));
%f=(abs(G21 + ((G21_21_10)*(x+y*1i) + (G21_21_01)*conj((x+y*1i)) + (G21_21_11)*(x+y*1i)*conj((x+y*1i)))./(1 + (H21_21_10)*(x+y*1i) + (H21_21_01)*conj((x+y*1i)) + (H21_21_11)*(x+y*1i)*conj((x+y*1i)))).^2 - (x+y*1i)*conj((x+y*1i)))./(2*28*(XI + real(XY*(x*y*1i))));
f=(abs(G21 + ((G21_21_10)*(x+y*1i) + (G21_21_01)*conj((x+y*1i)) + (G21_21_11)*(x+y*1i)*conj((x+y*1i)))./(1 + (H21_21_10)*(x+y*1i) + (H21_21_01)*conj((x+y*1i)) + (H21_21_11)*(x+y*1i)*conj((x+y*1i)))).^2 - (x+y*1i)*conj((x+y*1i)))./(2*28*(XI + real(XY)*(x)+(-1)*imag(XY)*y));
%Pdc = 2*15*Id;
%Pdc = 2*28*Id;
% f = exp(x).*(4*x.^2 + 2*y.^2 + 4*x.*y + 2*y - 1);
end