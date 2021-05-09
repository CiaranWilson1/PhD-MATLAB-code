function SmithTool
close all;
hFigure = figure('Visible','on','name','SmithTool', 'numbertitle','off', 'menubar', 'none');
tgroup = uitabgroup('Parent',hFigure);
tab1 = uitab('Parent', tgroup, 'Title', 'Smith Chart','Units', 'pixels');
tab2 = uitab('Parent', tgroup, 'Title', 'Frequency Response');
tab3 = uitab('Parent', tgroup, 'Title', 'Load Pull');

hMenu1 = uimenu(hFigure,'Label','File');
hMenu2 = uimenu(hFigure,'Label', 'View');
hMenu3 = uimenu(hFigure,'Label', 'Elements');
eh1 = uimenu(hMenu2,'Label','Grids');

seh1 = uimenu(eh1,'Label','Admittance Grid','Accelerator','Y','Callback', @toggleChartGridsMenu, 'Tag', 'hAdmittanceChart');
seh2 = uimenu(eh1,'Label','Impedance Grid','Accelerator','Z', 'Callback', @toggleChartGridsMenu, 'Tag', 'hImpedanceChart');


hSmithPanel = uipanel('Parent',tab1,'Units', 'pixels');

Smith = SmithChart(tab1);
Smith.hAxes.Position = [0.1300 0.0000 0.370 0.40];
Smith2 = SmithChart(tab1);
Smith2.hAxes.Position = [0.600 0.350 0.370 0.40];
Smith3 = SmithChart(tab1);
Smith3.hAxes.Position = [0.600 0.0000 0.370 0.40];
Smith4 = SmithChart(tab1);
Smith4.hAxes.Position = [0.1300 0.350 0.370 0.40];


set(tab1,'ResizeFcn',@match_width);

    function match_width(hObject,eventdata)     
       %Save current tab units
       tabUnits = get(tab1,'Units');
       %Change tab units to be pixels
       set(tab1, 'Units', 'pixels');
       %Get tab position in pixels
       tabPos = get(tab1,'Position');
       %Set 
       panelPos = [10, tabPos(4) - 100, tabPos(3) - 20, 100];
       set(hSmithPanel,'Position', panelPos);

       %Restore original tab units
       set(tab1, 'Units', tabUnits);
      
    end 
[S11, S12, S21, S22, frequencies, smithplot, smithplot2, smithplot3, smithplot4, VGS, VDS, IG, ID] =read_files;
figure
plot(IG, VDS)
maxVGS = max(VGS);
freqplot_old = plot(0,0);
freqplot_old2 = plot(0,0);
freqplot_old3 = plot(0,0);
freqplot_old4 = plot(0,0);
freqplot=plot(Smith.hAxes,real(S11),imag(S11));
freqplot2=plot(Smith2.hAxes,real(S12),imag(S12));
freqplot3=plot(Smith3.hAxes,real(S21),imag(S21));
freqplot4=plot(Smith4.hAxes,real(S22),imag(S22));
% biasplot=plot(Smith.hAxes,real(S11),imag(S11));
% biasplot2=plot(Smith2.hAxes,real(S12),imag(S12));
% biasplot3=plot(Smith3.hAxes,real(S21),imag(S21));
% biasplot4=plot(Smith4.hAxes,real(S22),imag(S22));
%% Install Z/Y grid checkboxes
bg = uibuttongroup('Visible','on',...
                   'Units', 'pixels',...
                   'Title', 'Grids',...
                   'Parent', hSmithPanel,...
                   'Position', [10 10 100 80]);
              
% Create three radio buttons in the button group.
r1 = uicontrol(bg,'Style','checkbox',...
                  'String','Z grid',...
                  'Position', [1 40 80 20],...
                  'HandleVisibility','off',...
                  'Tag', 'hImpedanceChart',...
                  'Value', 1,...
                  'CreateFcn',@toggleChartGrids,...
                  'Callback', @toggleChartGrids);
              
r2 = uicontrol(bg,'Style','checkbox',...
                  'String','Y grid',...
                  'Position', [1 10 80 20],...
                  'HandleVisibility','off',...
                  'Tag', 'hAdmittanceChart',...
                  'Callback', @toggleChartGrids);
              
bg2 = uibuttongroup('Visible','on',...
                   'Units', 'pixels',...
                   'Title', 'Minimum Freq',...
                   'Parent', hSmithPanel,...
                   'Position', [110 10 100 80]);
               
txt = uicontrol(bg2,'Style','text',...
                'Position',[1 40 80 20]);

sld = uicontrol(bg2,'Style', 'slider',...
                'Min',frequencies(1),'Max',frequencies(end - 1),'Value', frequencies(1),...
                'SliderStep', [0.066711140760507 0.066711140760507],...
                'Position', [1 10 90 20],...
                'Tag', 'slider1',...
                'Callback', @surfzlim1); 
            
bg3 = uibuttongroup('Visible','on',...
                   'Units', 'pixels',...
                   'Title', 'VGS',...
                   'Parent', hSmithPanel,...
                   'Position', [210 10 100 80]);
            
sld1 = uicontrol(bg3,'Style', 'slider',...
                'Min',min(VGS),'Max',max(VGS),'Value', min(VGS),...
                'SliderStep', [0.0870 0.0870],...
                'Position', [1 10 90 20],...
                'Tag', 'slider2',...
                'Callback', @surfzlim1); 
            
bg4 = uibuttongroup('Visible','on',...
                   'Units', 'pixels',...
                   'Title', 'VDS',...
                   'Parent', hSmithPanel,...
                   'Position', [310 10 100 80]);
             
sld2 = uicontrol(bg4,'Style', 'slider',...
                'Min',min(VDS),'Max',max(VDS),'Value', min(VDS),...
                'SliderStep', [0.0870 0.0870],...
                'Position', [1 10 90 20],...
                'Tag', 'slider3',...
                'Callback', @surfzlim1); 
            
bg5 = uibuttongroup('Visible','on',...
                   'Units', 'pixels',...
                   'Title', 'IG',...
                   'Parent', hSmithPanel,...
                   'Position', [410 10 100 80]);
               
sld3 = uicontrol(bg5,'Style', 'slider',...
                'Min',min(IG),'Max',max(IG),'Value', min(IG),...
                'SliderStep', [0.0870 0.0870],...
                'Position', [1 10 90 20],...
                'Tag', 'slider4',...
                'Callback', @surfzlim1); 
              
bg6 = uibuttongroup('Visible','on',...
                   'Units', 'pixels',...
                   'Title', 'ID',...
                   'Parent', hSmithPanel,...
                   'Position', [510 10 100 80]);
               
sld4 = uicontrol(bg6,'Style', 'slider',...
                'Min',min(ID),'Max',max(ID),'Value', min(ID),...
                'SliderStep', [0.0870 0.0870],...
                'Position', [1 10 90 20],...
                'Tag', 'slider5',...
                'Callback', @surfzlim1);                
               
    function toggleChartGrids(hObject,~)
        if get(hObject,'Value') == 1
            set(Smith.(get(hObject,'Tag')),'Visible', 'on');
            set(Smith2.(get(hObject,'Tag')),'Visible', 'on');
            set(Smith3.(get(hObject,'Tag')),'Visible', 'on');
            set(Smith4.(get(hObject,'Tag')),'Visible', 'on');
        elseif get(hObject,'Value') == 0
            set(Smith.(get(hObject,'Tag')),'Visible', 'off');
            set(Smith2.(get(hObject,'Tag')),'Visible', 'off');
            set(Smith3.(get(hObject,'Tag')),'Visible', 'off');
            set(Smith4.(get(hObject,'Tag')),'Visible', 'off');
        end
    end
    function toggleChartGridsMenu(hObject,~)
        status = get(Smith.(get(hObject,'Tag')),'Visible');
        if strcmp(status, 'on')
            set(Smith.(get(hObject,'Tag')),'Visible', 'off');
            set(Smith2.(get(hObject,'Tag')),'Visible', 'off');
            set(Smith3.(get(hObject,'Tag')),'Visible', 'off');
            set(Smith4.(get(hObject,'Tag')),'Visible', 'off');
            if strcmp(get(hObject,'Tag'),'hAdmittanceChart')
                set(r2,'Value',0);
            else 
                set(r1,'Value',0);
            end
        end
        if strcmp(status, 'off')
            set(Smith.(get(hObject,'Tag')),'Visible', 'on');
            set(Smith2.(get(hObject,'Tag')),'Visible', 'on');
            set(Smith3.(get(hObject,'Tag')),'Visible', 'on');
            set(Smith4.(get(hObject,'Tag')),'Visible', 'on');
            if strcmp(get(hObject,'Tag'),'hAdmittanceChart')
                set(r2,'Value',1);
            else
                set(r1,'Value',1);
            end
        end
    end
    function [samplepointz, samplepointz2, samplepointz3, samplepointz4, freq, sm, sm2, sm3, sm4, VGS, VDS, IG, ID]= read_files
        filepath = 'C:\Users\Ciaran Wilson\Documents\S-Parameter data\26-7-2016\ActiveBias\1\';
        filenames = dir(filepath);
        a=size(filenames);
        filename = zeros(1,a(1));
        filename = filenames(3).name;
        wowfile = [filepath filename];
%         bias(ii-2) = getBias(wowfile);
%         VGS(ii-2) = bias(ii-2).VGS;
%         VDS(ii-2) = bias(ii-2).VDS;
%         IG(ii-2) = bias(ii-2).IG;
%         ID(ii-2) = bias(ii-2).ID;
        h = read(rfdata.data, wowfile);
        b=size(h.Freq);
        samplepointz= zeros(b(1),a(1)-3);
        samplepointz2= zeros(b(1),a(1)-3);
        samplepointz3= zeros(b(1),a(1)-3);
        samplepointz4= zeros(b(1),a(1)-3);
        for ii = 3:1:a(1)-1                                             
            filename = filenames(ii).name;
            wowfile = [filepath filename];
            bias(ii-2) = getBias(wowfile);
            VGS(ii-2) = bias(ii-2).VGS;
            VDS(ii-2) = bias(ii-2).VDS;
            IG(ii-2) = bias(ii-2).IG;
            ID(ii-2) = bias(ii-2).ID;
            h = read(rfdata.data, wowfile);
            freq = h.Freq;
            samplepoints=h.S_Parameters(1,1,:);
            samplepointz(:,ii-2) = squeeze(samplepoints);
%             sm=plot(Smith.hAxes,real(samplepointz(:,ii-2)),imag(samplepointz(:,ii-2)));
            samplepoints2=h.S_parameters(1,2,:);
            samplepointz2(:,ii-2)=squeeze(samplepoints2);
%             sm2=plot(Smith2.hAxes,real(samplepointz2(:,ii-2)),imag(samplepointz2(:,ii-2)));
            samplepoints3=h.S_parameters(2,1,:);
            samplepointz3(:,ii-2)=squeeze(samplepoints3);
%             sm3=plot(Smith3.hAxes,real(samplepointz3(:,ii-2)),imag(samplepointz3(:,ii-2)));
            samplepoints4=h.S_parameters(2,2,:);
            samplepointz4(:,ii-2)=squeeze(samplepoints4);
%             sm4=plot(Smith4.hAxes,real(samplepointz4(:,ii-2)),imag(samplepointz4(:,ii-2)));
        end
        sm=plot(Smith.hAxes,real(samplepointz),imag(samplepointz));
        sm2=plot(Smith2.hAxes,real(samplepointz2),imag(samplepointz2));
        sm3=plot(Smith3.hAxes,real(samplepointz3),imag(samplepointz3));
        sm4=plot(Smith4.hAxes,real(samplepointz4),imag(samplepointz4));
        
        w = 2*pi*h.Freq.';
%         
%         Cpgs = 0.13591E-12;
%         Rpgs = 1.07E3;
%         Cpds = 0.48E-12;
%         Rpds = 0.8583E3;
%         Cpg = 0.0798E-12;
%         Cpd = 0.607E-12;
%         
%         Ypar(1,1,:) = par(1j.*w.*Cpgs + 1/Rpgs,1j.*w.*Cpg);
%         Ypar(2,2,:) = par(1j.*w.*Cpds + 1/Rpds,1j.*w.*Cpd);
%         
%         Cgd     =   (-Im_Y12./w ).*(1+((Re_Y12+GLGD)./Im_Y12).^2);
%         Cgs     =   ((Im_Y11+Im_Y12)./w ).*(1.0+((Re_Y11+Re_Y12-GLGS)./(Im_Y11+Im_Y12)).^2);
%         Rgd     =   (1./(w .*Cgd)).*(Re_Y12+GLGD)./Im_Y12;    
%         Rgs     =   (1./(w.*Cgs)).*(Re_Y11+Re_Y12-GLGS)./(Im_Y11+Im_Y12);   
%         gm      =   (((Re_Y21-Re_Y12).^2+(Im_Y21-Im_Y12).^2).*(1+w .*w .*Cgs.*Cgs.*Rgs.*Rgs)).^0.5;
%         tau     =   -(1.0./w).*atan((w.*Cgs.*Rgs.*Re_Y21+Im_Y21-Re_Y12.*w.*Rgs.*Cgs-Im_Y12)./(Re_Y21-Im_Y21.*w.*Rgs.*Cgs-Re_Y12+Im_Y12.*w.*Rgs.*Cgs));
%         Cds     =   (Im_Y22)./w -Cgd./(1+w .*w .*Cgd.*Cgd.*Rgd.*Rgd);
%         Cds3    =   (Im_Y12 + Im_Y22)./w;
%         gds     =   Re_Y22+Re_Y12;
    end
%     function surfzlim(source,callbackdata, handles)
%         set(smithplot,'Visible','off')
%         set(smithplot2,'Visible','off')
%         set(smithplot3,'Visible','off')
%         set(smithplot4,'Visible','off')
% %         set(freqplot,'Visible','on')
% %         set(freqplot2,'Visible','on')
% %         set(freqplot3,'Visible','on')
% %         set(freqplot4,'Visible','on')
% %         set(biasplot,'Visible','off')
% %         set(biasplot2,'Visible','off')
% %         set(biasplot3,'Visible','off')
% %         set(biasplot4,'Visible','off')
%         display(source.Value);
%         c = (frequencies >= source.Value);
% %         frequencySliderValue = get(handles.slider1, 'Value');
%         d = find(c);
%         VGSSliderValue = get(sld1, 'Value');
%         aboveVGS = (VGS >= VGSSliderValue);
%         indexVGS = find(aboveVGS);
%         
%         sizeplot = size(smithplot);
%             for jj=1:1:sizeplot(1)
%                 if(max(indexVGS) >= jj)
%                   freqplot(jj).XData = smithplot(jj).XData(d(1):d(end));
%                   freqplot(jj).YData = smithplot(jj).YData(d(1):d(end));
%                   freqplot2(jj).XData = smithplot2(jj).XData(d(1):d(end));
%                   freqplot2(jj).YData = smithplot2(jj).YData(d(1):d(end));
%                   freqplot3(jj).XData = smithplot3(jj).XData(d(1):d(end));
%                   freqplot3(jj).YData = smithplot3(jj).YData(d(1):d(end));
%                   freqplot4(jj).XData = smithplot4(jj).XData(d(1):d(end));
%                   freqplot4(jj).YData = smithplot4(jj).YData(d(1):d(end));
%                 else
%                   freqplot(jj).XData = 0;
%                   freqplot(jj).YData = 0;
%                   freqplot2(jj).XData = 0;
%                   freqplot2(jj).YData = 0;
%                   freqplot3(jj).XData = 0;
%                   freqplot3(jj).YData = 0;
%                   freqplot4(jj).XData = 0;
%                   freqplot4(jj).YData = 0;
%                 end
%             end
% %         delete(freqplot_old);
% %         delete(freqplot_old2);
% %         delete(freqplot_old3);
% %         delete(freqplot_old4);
% %         freqplot=plot(Smith.hAxes,real(S11(d(1):d(end),:)),imag(S11(d(1):d(end),:)));
% %         freqplot2=plot(Smith2.hAxes,real(S12(d(1):d(end),:)),imag(S12(d(1):d(end),:)));
% %         freqplot3=plot(Smith3.hAxes,real(S21(d(1):d(end),:)),imag(S21(d(1):d(end),:)));
% %         freqplot4=plot(Smith4.hAxes,real(S22(d(1):d(end),:)),imag(S22(d(1):d(end),:)));
% %         freqplot_old=freqplot;
% %         freqplot_old2=freqplot2;
% %         freqplot_old3=freqplot3;
% %         freqplot_old4=freqplot4;
% %         drawnow;
%     end
    function surfzlim1(source,callbackdata)
        set(smithplot,'Visible','off')
        set(smithplot2,'Visible','off')
        set(smithplot3,'Visible','off')
        set(smithplot4,'Visible','off')
%         set(freqplot,'Visible','off')
%         set(freqplot2,'Visible','off')
%         set(freqplot3,'Visible','off')
%         set(freqplot4,'Visible','off')
%         set(biasplot,'Visible','on')
%         set(biasplot2,'Visible','on')
%         set(biasplot3,'Visible','on')
%         set(biasplot4,'Visible','on')
        display(source.Value);
        VGSSliderValue = get(sld1, 'Value');
        c = (VGS >= VGSSliderValue);
        d = find(c);
        
        VDSSliderValue = get(sld2, 'Value');
        aboveVDS = (VDS >= VDSSliderValue);
        
        IGSliderValue = get(sld3, 'Value');
        aboveIG = (IG >= IGSliderValue);
        
        IDSliderValue = get(sld4, 'Value');
        aboveID = (ID >= IDSliderValue);

        combine = c&aboveVDS&aboveIG&aboveID;
        values = find(combine);
        frequencySliderValue = get(sld, 'Value');
        set(txt,'String',num2str(frequencySliderValue));
        aboveFreq = (frequencies >= frequencySliderValue);
        indexFreqs = find(aboveFreq);
        sizeplot = size(smithplot);
            for jj=1:1:sizeplot(1)
                if(max(values) >= jj)
                  freqplot(jj).XData = smithplot(jj).XData(indexFreqs(1):indexFreqs(end));
                  freqplot(jj).YData = smithplot(jj).YData(indexFreqs(1):indexFreqs(end));
                  freqplot2(jj).XData = smithplot2(jj).XData(indexFreqs(1):indexFreqs(end));
                  freqplot2(jj).YData = smithplot2(jj).YData(indexFreqs(1):indexFreqs(end));
                  freqplot3(jj).XData = smithplot3(jj).XData(indexFreqs(1):indexFreqs(end));
                  freqplot3(jj).YData = smithplot3(jj).YData(indexFreqs(1):indexFreqs(end));
                  freqplot4(jj).XData = smithplot4(jj).XData(indexFreqs(1):indexFreqs(end));
                  freqplot4(jj).YData = smithplot4(jj).YData(indexFreqs(1):indexFreqs(end));
                else
                  freqplot(jj).XData = 0;
                  freqplot(jj).YData = 0;
                  freqplot2(jj).XData = 0;
                  freqplot2(jj).YData = 0;
                  freqplot3(jj).XData = 0;
                  freqplot3(jj).YData = 0;
                  freqplot4(jj).XData = 0;
                  freqplot4(jj).YData = 0;
                end
            end
%         delete(freqplot_old);
%         delete(freqplot_old2);
%         delete(freqplot_old3);
%         delete(freqplot_old4);
%         freqplot=plot(Smith.hAxes,real(S11(d(1):d(end),:)),imag(S11(d(1):d(end),:)));
%         freqplot2=plot(Smith2.hAxes,real(S12(d(1):d(end),:)),imag(S12(d(1):d(end),:)));
%         freqplot3=plot(Smith3.hAxes,real(S21(d(1):d(end),:)),imag(S21(d(1):d(end),:)));
%         freqplot4=plot(Smith4.hAxes,real(S22(d(1):d(end),:)),imag(S22(d(1):d(end),:)));
%         freqplot_old=freqplot;
%         freqplot_old2=freqplot2;
%         freqplot_old3=freqplot3;
%         freqplot_old4=freqplot4;
%         drawnow;
    end
%     function edittext(source,callbackdata)
%         textValue = get(sld, 'Value');
%         set('Value',textValue);
%         
%     end
end