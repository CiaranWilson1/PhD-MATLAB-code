close all
clear all

t=0:0.1:10;
Tau = 0.6;
beta = 0.3;
it = exp((-t/Tau)*beta);
plot(t,it); hold on;

% A(1) = 0.1;
% A(2) = 0.1;
% A(3) = 0.1;
% A(4) = 0.1;
% A(5) = 0.1;
% A(6) = 0.1;
% A(7) = 0.1;
% A(8) = 0.1;
% A(9) = 0.1;
% A(10) = 0.1;
% A(11) = 0.1;
% A(12) = 0.1;
% A(13) = 0.1;
% A(14) = 0.1;
% A(15) = 0.1;
% A(16) = 0.1;
% A(17) = 0.1;
% A(18) = 0.1;
% A(19) = 0.1;
% A(20) = 0.1;

pree = 0.1:0.1:1; 

for ii =1:1:length(t)
    E(ii,:) = exp(pree*t(ii));
end

A=E\it';

X = E*A;

plot(t,X'); hold off;
% options = optimoptions('lsqnonlin','Jacobian','off','Algorithm', 'trust-region-reflective',...
%     'MaxIter',10000,'Display', 'iter', 'MaxFunEvals', 10000,  'TolFun', 1E-100,...
%     'DerivativeCheck', 'on', 'FinDiffType','central')
% 
% Aopt = lsqnonlin(@errorCalc,A,options);
% 
%     function [Error] = errorCalc(A)
%         Aopt = A;
%         Error = it - E*Aopt;
%     end
% end