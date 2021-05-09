t=[0:1/2000:2];
timevec=size(t);
w0 = [2*pi 50*2*pi 100*2*pi]';
% w0 = [2*pi];
C = 1E-5;
R = 1E3;
Vin=sin(w0*t);
vo = (1/(1+j*w0*R*C))*Vin;
magVo = max(Vin')'./sqrt(1+(w0*R*C).^2);
phaseVo = -atan(w0*R*C);
phaseVo1 = phaseVo*180/pi;
mVo=repmat(magVo',timevec(2),1);
pVo=repmat(phaseVo',timevec(2),1);
A = w0/((1/R*C)+ R*C*(w0.^2));
A=A(:,3);
% magVo = abs(vo);
vout = mVo'.*sin(w0*t - pVo') + A*exp(-t/(R*C));
% phaseVo = angle(vo);;
% phaseVo1 = phaseVo*180/pi;
% vout = magVo.*sin(w0*t - phaseVo);
% figure
% plot(t,Vin(1,:))
% hold on;
% plot(t,vout(1,:))
% hold off;
% figure
% plot(t,Vin(2,:))
% hold on;
% plot(t,vout(2,:))
% hold off;
% figure
% plot(t,vout(3,:))
% hold on;
% plot(t,Vin(3,:))
% hold off;

save vout Vin

d1 = [0];
d2 = [1];
narx_net = narxnet(d1,d2,10);
% narx_net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
% narx_net.inputs{2}.processFcns = {'removeconstantrows','mapminmax'};
narx_net.divideFcn = 'dividerand'; 
% narx_net = closeloop(narx_net);
narx_net.trainParam.min_grad = 1e-10;
columnSamples = true; % samples are by columns.
cellTime = false;
Vin = VinNL;
vout = VoutNL;
t = time;
[y,wasMatrix] = tonndata(vout,columnSamples,cellTime);
[x,wasMatrix] = tonndata(Vin,columnSamples,cellTime);
[p,Pi,Ai,t1] = preparets(narx_net,x,{},y);

narx_net = train(narx_net,p,t1,Pi,Ai);
yp = sim(narx_net,p,Pi);
yp1 = cell2mat(yp);
yp2 = [NaN(size(yp1,1),1) yp1];

figure
plot(t,Vin(1,:))
hold on;
plot(t,vout(1,:))
plot(t,yp2(1,:))
hold off;
% legend('Vin','vout','voutNN')
% figure
% plot(t,Vin(2,:))
% hold on;
% plot(t,vout(2,:))
% plot(t,yp2(2,:))
% hold off;
% legend('Vin','vout','voutNN')
% figure
% plot(t,Vin(3,:))
% hold on;
% plot(t,vout(3,:))
% plot(t,yp2(3,:))
% hold off;
% 
% legend('Vin','vout','voutNN')
% 
% t=[0:1/2000:2];
% timevec=size(t);
% w0 = [200*pi 50*2*pi 100*2*pi]';
% % w0 = [2*pi];
% C = 1E-5;
% R = 1E3;
% Vin=sin(w0*t);
% vo = (1/(1+j*w0*R*C))*Vin;
% magVo = max(Vin')'./sqrt(1+(w0*R*C).^2);
% phaseVo = -atan(w0*R*C);
% phaseVo1 = phaseVo*180/pi;
% mVo=repmat(magVo',timevec(2),1);
% pVo=repmat(phaseVo',timevec(2),1);
% A = w0/((1/R*C)+ R*C*(w0.^2));
% A=A(:,1);
% % magVo = abs(vo);
% vout = mVo'.*sin(w0*t - pVo') + A*exp(-t/(R*C));
% [y,wasMatrix] = tonndata(vout,columnSamples,cellTime);
% [x,wasMatrix] = tonndata(Vin,columnSamples,cellTime);
% [p1,Pi1,Ai1,t11] = preparets(narx_net,x,{},y);
% outputs = sim(narx_net,p1,Pi1);
% outputs = cell2mat(outputs);
% outputs = [NaN(size(outputs,1),1) outputs];
% 
% figure
% plot(t,Vin(1,:))
% hold on;
% plot(t,vout(1,:))
% plot(t,outputs(1,:))
% hold off;
% legend('Vin','vout','voutNN')
% % %view(net)