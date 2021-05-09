function annFitXparam
%File paths will need to be adjusted
%Models the drain current of the device

%Create ANN
net = NeuralNetwork3(2,10,14);

%% Read in data
%Rth = [200 0 5 0 10 0];
Rth = [[200 0]; [5 0]; [10 0]];
X = [0.0983153+j*0 0.198037+j*0; -0.0431728+j*0.0203328 -0.110064+j*0.051798; -7.6909+j*3.62424 -19.606+j*9.23891; -0.0154982+j*0.000955133 -0.0444157+j*-0.0151582; 0.00604332+j*8.43738e-05 0.129031+j*0.000272334; 1.42698+j*1.05064e-06 1.03003+j*-1.50362e-07; 0.000306524+j*-0.000415071 0.00130225+j*-0.000213951];
%Xnoncomplex = [0.0983153 0 0.198037 0 0.18991 0; -0.0431728 0.0203328 -0.110064 0.051798 -0.105491 0.0496443; -7.6909 3.62424 -19.606 9.23891 -18.7963 8.85739; -0.0154982 0.000955133 -0.0444157 -0.0151582 -0.0478438 -0.0128453; 0.00604332 8.43738e-05 0.129031 0.000272334 0.131039 0.000164118; 1.42698 1.05064e-06 1.03003 -1.50362e-07 1.10555 1.76581e-07; 0.000306524 -0.000415071 0.00130225 -0.000213951 0.00172755 -0.000383605];
Xnoncomplex = [[0.0983153 0 -0.0431728 0.0203328 -7.6909 3.62424 -0.0154982 0.000955133 0.00604332 8.43738e-05 1.42698 1.05064e-06 0.000306524 -0.000415071];[0.198037 0 -0.110064 0.051798 -19.606 9.23891 -0.0444157 -0.0151582 0.129031 0.000272334 1.03003 -1.50362e-07 0.00130225 -0.000213951];[0.18991 0 -0.105491 0.0496443 -18.7963 8.85739 -0.0478438 -0.0128453 0.131039 0.000164118 1.10555 1.76581e-07 0.00172755 -0.000383605]];

%% Optimize

xData = Rth;
x0 = net.getW;


options = optimoptions('lsqnonlin','Jacobian','off','Algorithm', 'levenberg-marquardt',...
    'MaxIter',10000,'Display', 'iter', 'MaxFunEvals', 100000,  'TolFun', 1E-10,...
    'DerivativeCheck', 'on', 'FinDiffType','central');


wHat = lsqnonlin(@errorCalc,x0,[],[],options);
net.setW(wHat);

%Id_sim = reshape(net.sim(xData),size(ID));

% mesh(Vgs,Vds,ID, 'Marker','o','FaceColor','none','LineStyle', 'none', 'MarkerFaceColor', 'black'); hold on;
% mesh(Vgs,Vds,Id_sim); hold off;
% 
% figure
% plot(Vds(1:2:end,:).',ID(1:2:end,:).','rx'); hold on;
% plot(Vds(1:2:end,:).',Id_sim(1:2:end,:).'); hold off;

Wcoeff = net.getW;

save Wcoeff
save samp


    function [Fvec,J] = errorCalc(W)
        % Evaluate the vector function and the Jacobian matrix for
        % an ANN
        % W are the input ANN weights
        % yData are the measured data we are trying to model
        % net is the NeuralNetwork object
        samp=net.sim2(xData,W);
        %Id_sim = reshape(net.sim2(xData, W),size(X));
        Fvec = Xnoncomplex - samp;
%         Fvec(31,:) = Fvec1(31,:)*3;
%         Fvec(30,:) = Fvec1(30,:)*2.9;
%         Fvec(29,:) = Fvec1(29,:)*2.8;
%         Fvec(28,:) = Fvec1(28,:)*2.7;
%         Fvec(27,:) = Fvec1(27,:)*2.6;
%         Fvec(26,:) = Fvec1(26,:)*2.5;
%         Fvec(25,:) = Fvec1(25,:)*2.4;
%         Fvec(24,:) = Fvec1(24,:)*2.3;
%         Fvec(23,:) = Fvec1(23,:)*2.2;
%         Fvec(22,:) = Fvec1(22,:)*2.1;
%         Fvec(21,:) = Fvec1(21,:)*2;
%         Fvec(20,:) = Fvec1(20,:)*1.9;
%         Fvec(19,:) = Fvec1(19,:)*1.8;
%         Fvec(18,:) = Fvec1(18,:)*1.7;
%         Fvec(17,:) = Fvec1(17,:)*1.6;
%         Fvec(16,:) = Fvec1(16,:)*1.5;
%         Fvec(15,:) = Fvec1(15,:)*1.4;
%         Fvec(14,:) = Fvec1(14,:)*1.3;
%         Fvec(13,:) = Fvec1(13,:)*1.2;
%         Fvec(12,:) = Fvec1(12,:)*1.1;
%         Fvec(11,:) = Fvec1(11,:)*1;
%         Fvec(10,:) = Fvec1(10,:)*0.9;
%         Fvec(9,:) = Fvec1(9,:)*0.8;
%         Fvec(8,:) = Fvec1(8,:)*0.7;
%         Fvec(7,:) = Fvec1(7,:)*0.6;
%         Fvec(6,:) = Fvec1(6,:)*0.5;
%         Fvec(5,:) = Fvec1(5,:)*0.4;
%         Fvec(4,:) = Fvec1(4,:)*0.3;
%         Fvec(3,:) = Fvec1(3,:)*0.2;
%         Fvec(2,:) = Fvec1(2,:)*0.1;
%         Fvec(1) = Fvec1(1)*0.05;
%         Fvec = sum(Fvec);
        % Evaluate the Jacobian matrix if nargout > 1
        if nargout > 1
            J = net.jacobian(xData);
        end
    end
end
