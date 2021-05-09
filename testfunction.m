function smith
clear all
filenames = dir('C:\Users\Ciaran Wilson\Documents\ColdFET');
filename = zeros(1,118);
% fH = figure;
% get(fH)
% set(fH, 'Menubar', 'None')
% ax = axes;
% ax.Position = [0.1500 0.0500 0.37 0.40];
% get(fH, 'Children')
% ax2 = axes;
% get(ax2)
% ax2.Position = [0.60 0.55 0.37 0.40];
% ax3 = axes;
% get(ax3)
% ax3.Position = [0.60 0.05 0.37 0.40];
% ax4 = axes;
% get(ax4)
% ax4.Position = [0.15 0.55 0.37 0.40];
fH = figure;
for ii = 3:1:118
    filename = filenames(ii).name;
%end
wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
h = read(rfdata.data, wowfile);
% S = h.S_Parameters;
% s11 = rfparam(1,1,S);
% wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
% S = sparameters(wowfile);
% s11 = rfparam(S,1,1);
%fH = figure;
%get(fH)
%set(fH, 'Menubar', 'None')
sm = smith(h,'S11');
legend off
hold on
sm.Parent.Position = [0.1300 0.0500 0.370 0.40];
end
filename = 0;
axes
for jj = 3:1:118
    filename = filenames(jj).name;
    wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
h = read(rfdata.data, wowfile);
% get(fH, 'Children')
% s12 = rfparam(S,1,2);
sm2 = smith(h,'s12');
legend off
%get(sm2)
hold on
sm2.Parent.Position = [0.600 0.5500 0.370 0.40];
end
filename = 0;
axes
for kk = 3:1:118
    filename = filenames(kk).name;
    wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
h = read(rfdata.data, wowfile);
% get(fH, 'Children')
% s21 = rfparam(S,2,1);
sm3 = smith(h,'S21');
legend off
%get(sm2)
hold on
sm3.Parent.Position = [0.600 0.0500 0.370 0.40];
end
% s21 = rfparam(S,2,1);
% sm3 = smithchart(s21);
% sm3.Parent.Position = [0.600 0.0500 0.370 0.40];
filename = 0;
axes
for ll = 3:1:118
    filename = filenames(ll).name;
    wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
h = read(rfdata.data, wowfile);
% get(fH, 'Children')
% s22 = rfparam(S,2,2);
sm4 = smith(h, 's22');
legend off
%get(sm2)
hold on
sm4.Parent.Position = [0.1300 0.5500 0.370 0.40];
end
% s22 = rfparam(S,2,2);
% sm4 = smithchart(s22);
% sm4.Parent.Position = [0.1300 0.5500 0.370 0.40];


% function slider1_Callback(hObject, eventdata, handles)
% % hObject    handle to slider1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% 
% 
% % --- Executes during object creation, after setting all properties.
% function slider1_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to slider1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end

