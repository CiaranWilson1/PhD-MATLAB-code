clear all
filenames = dir('C:\Users\Ciaran Wilson\Documents\S-Parameter data\1-7-2016\ColdFET');
filename = zeros(1,118);

fH = figure;
hAx = axes;
ds=draw_smith_chart(hAx);
hAx.Position = [0.1300 0.0500 0.370 0.40];
hAx1 = axes;
ds1=draw_smith_chart(hAx1);
hAx1.Position = [0.600 0.5500 0.370 0.40];
hAx2 = axes;
ds2=draw_smith_chart(hAx2);
hAx2.Position = [0.600 0.0500 0.370 0.40];
hAx3 = axes;
ds3=draw_smith_chart(hAx3);
hAx3.Position = [0.1300 0.5500 0.370 0.40];
samplepointz= zeros(201,115);
samplepointz2= zeros(201,115);
samplepointz3= zeros(201,115);
samplepointz4= zeros(201,115);
for ii = 3:1:118
    filename = filenames(ii).name;
%end
wowfile = ['C:\Users\Ciaran Wilson\Documents\S-Parameter data\1-7-2016\ColdFET\' filename];
bias(ii-2) = getBias(wowfile);
VGS(ii-2) = bias(ii-2).VGS;
VDS(ii-2) = bias(ii-2).VDS;
IG(ii-2) = bias(ii-2).IG;
ID(ii-2) = bias(ii-2).ID;
h = read(rfdata.data, wowfile);
freq = h.Freq;
samplepoints=h.S_Parameters(1,1,:);
samplepointz(:,ii-2) = squeeze(samplepoints);
% ds=draw_smith_chart(hAx);
% sm=plot(hAx,real(samplepointz(:,ii-2)),imag(samplepointz(:,ii-2)));
legend off
%hold on
% ds.Parent.Position = [0.1300 0.0500 0.370 0.40];
samplepoints2=h.S_parameters(1,2,:);
samplepointz2(:,ii-2)=squeeze(samplepoints2);
% ds1=draw_smith_chart(hAx1);
% sm2=plot(hAx1,real(samplepointz2(:,ii-2)),imag(samplepointz2(:,ii-2)));
legend off
% ds1.Parent.Position = [0.600 0.5500 0.370 0.40];
samplepoints3=h.S_parameters(2,1,:);
samplepointz3(:,ii-2)=squeeze(samplepoints3);
% ds2=draw_smith_chart(hAx2);
% sm3=plot(hAx2,real(samplepointz3(:,ii-2)),imag(samplepointz3(:,ii-2)));
legend off
% ds2.Parent.Position = [0.600 0.0500 0.370 0.40];
samplepoints4=h.S_parameters(2,2,:);
samplepointz4(:,ii-2)=squeeze(samplepoints4);
% ds3=draw_smith_chart(hAx3);
% sm4=plot(hAx3,real(samplepointz4(:,ii-2)),imag(samplepointz4(:,ii-2)));
legend off
% ds3.Parent.Position = [0.600 0.0500 0.370 0.40];
%hold on
end
sm=plot(hAx,real(samplepointz),imag(samplepointz));
sm2=plot(hAx1,real(samplepointz2),imag(samplepointz2));
sm3=plot(hAx2,real(samplepointz3),imag(samplepointz3));
sm4=plot(hAx3,real(samplepointz4),imag(samplepointz4));
value = 1.5*1e9;
c = (h.Freq >= value);
d = find(c);
a = size(sm);
for jj=1:1:a(1)
    sm(jj).XData = sm(jj).XData(d(1):d(end));
    sm(jj).YData = sm(jj).YData(d(1):d(end));
end
wowfile = ['C:\Users\Ciaran Wilson\Documents\S-Parameter data\26-7-2016\ActiveBias\2\SFile_10800_00000_00000_0229.s2p'];
h = read(rfdata.data, wowfile);
z_params = s2z(h.S_Parameters, 50);
testZ11=z_params(1,1,:);
Z11 = squeeze(testZ11);
testZ12=z_params(1,2,:);
Z12 = squeeze(testZ12);
testZ21=z_params(2,1,:);
Z21 = squeeze(testZ21);
testZ22=z_params(2,2,:);
Z22 = squeeze(testZ22);
y_params = s2y(h.S_Parameters, 50);
testY11=y_params(1,1,:);
Y11 = squeeze(testY11);
testY12=y_params(1,2,:);
Y12 = squeeze(testY12);
testY21=y_params(2,1,:);
Y21 = squeeze(testY21);
testY22=y_params(2,2,:);
Y22 = squeeze(testY22);
% n = 1.5;
% k = 1.38064852*10-23;
% T = 300;
% q = 1.60217662*10-19;
w = 2*pi*h.Freq;
bias = getBias(wowfile);
Ig = bias.IG;
syms Rs Rg Rc Rd Ls Lg Ld
% eqn1 = Rs + Rg + Rc/3 + (n*k*T)/(q*Ig) + 1i*w*(Ls + Lg) == Z11;
% eqn2 = Rs + Rc/2 + 1i*w*Ls == Z12;
% eqn3 = Rs + Rc/2 + 1i*w*Ls == Z21;
% eqn4 = Rs + Rd + Rc + 1i*w*(Ls + Ld) == Z22;
% [A,B] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4], [Rs, Rg, Rc, Rd, Ls, Ld, Lg]);
% X = linsolve(A,B);
% eqn1 = Rs + Rg + Rc/3 + (n*k*T)/(q*Ig(1)) == real(Z11(1));
% eqn2 = Rs + Rc/2 == real(Z12(1));
% eqn3 = Rs + Rc/2 == real(Z21(1));
% eqn4 = Rs + Rd + Rc == real(Z22(1));
% % [A,B] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4], [Rs, Rg, Rc, Rd]);
% % X = linsolve(A,B);
% sol = solve([eqn1, eqn2, eqn3, eqn4], [Rs, Rg, Rd, Rc]);
% filename = 0;
% axes
% for jj = 3:1:118
%     filename = filenames(jj).name;
%     wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
% h = read(rfdata.data, wowfile);
% % get(fH, 'Children')
% % s12 = rfparam(S,1,2);
% sm2 = smith(h,'s12');
% legend off
% %get(sm2)
% hold on
% sm2.Parent.Position = [0.600 0.5500 0.370 0.40];
% end
% filename = 0;
% axes
% for kk = 3:1:118
%     filename = filenames(kk).name;
%     wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
% h = read(rfdata.data, wowfile);
% % get(fH, 'Children')
% % s21 = rfparam(S,2,1);
% sm3 = smith(h,'S21');
% legend off
% %get(sm2)
% hold on
% sm3.Parent.Position = [0.600 0.0500 0.370 0.40];
% end
% % s21 = rfparam(S,2,1);
% % sm3 = smithchart(s21);
% % sm3.Parent.Position = [0.600 0.0500 0.370 0.40];
% filename = 0;
% axes
% for ll = 3:1:118
%     filename = filenames(ll).name;
%     wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
% h = read(rfdata.data, wowfile);
% % get(fH, 'Children')
% % s22 = rfparam(S,2,2);
% sm4 = smith(h, 's22');
% legend off
% %get(sm2)
% hold on
% sm4.Parent.Position = [0.1300 0.5500 0.370 0.40];
% end
% % s22 = rfparam(S,2,2);
% % sm4 = smithchart(s22);
% % sm4.Parent.Position = [0.1300 0.5500 0.370 0.40];
% 
% 
% % function slider1_Callback(hObject, eventdata, handles)
% % % hObject    handle to slider1 (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    structure with handles and user data (see GUIDATA)
% % 
% % % Hints: get(hObject,'Value') returns position of slider
% % %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% % 
% % 
% % % --- Executes during object creation, after setting all properties.
% % function slider1_CreateFcn(hObject, eventdata, handles)
% % % hObject    handle to slider1 (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    empty - handles not created until after all CreateFcns called
% % 
% % % Hint: slider controls usually have a light gray background.
% % if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
% %     set(hObject,'BackgroundColor',[.9 .9 .9]);
% % end

