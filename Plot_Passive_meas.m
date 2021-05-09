% fileLoc = 'C:\Users\Ciaran Wilson\Documents\Mesurement_data_IIIV_Lab\Mesurement_data\Embase-Carrier_2_S90_K16L16\TS958W3_CO#G2_S90_K16L16_1.s2p';
% rfObj = read(rfdata.data,fileLoc);
% 
% fileLoc1 = 'C:\Users\Ciaran Wilson\Documents\Mesurement_data_IIIV_Lab\Mesurement_data\Embase-Carrier_4_S222_Y15Z15\TS958W3_CO#G2_S222_Y15Z15_1.s2p';
% rfObj1 = read(rfdata.data,fileLoc1);
% 
% fileLoc2 = 'C:\Users\Ciaran Wilson\Documents\Mesurement_data_IIIV_Lab\Mesurement_data\Embase-Carrier_6_S199_W11X11\TS958W3_CO#G2_S199_W11X11_1.s2p';
% rfObj2 = read(rfdata.data,fileLoc2);
% 
% Smeas = rfObj.S_Parameters;
% Smeas1 = rfObj1.S_Parameters;
% Smeas2 = rfObj2.S_Parameters;
% 
% figure
% subplot(2,2,1)
% smithchart(reshape(Smeas(1,1,:),1,length(Smeas(1,1,:)))); hold on;
% smithchart(reshape(Smeas2(1,1,:),1,length(Smeas2(1,1,:))));
% smithchart(reshape(Smeas1(1,1,:),1,length(Smeas1(1,1,:)))); hold off;
% title(sprintf('S11\n'));
% 
% subplot(2,2,2)
% S12meas = reshape(Smeas(1,2,:),1,length(Smeas(1,1,:)));
% S12meas1 = reshape(Smeas1(1,2,:),1,length(Smeas1(1,1,:)));
% S12meas2 = reshape(Smeas2(1,2,:),1,length(Smeas2(1,1,:)));
% polar(angle(S12meas), abs(S12meas)); hold on;
% polar(angle(S12meas2), abs(S12meas2));
% polar(angle(S12meas1), abs(S12meas1)); hold off;
% title('S12');
% 
% subplot(2,2,3)
% S21meas = reshape(Smeas(2,1,:),1,length(Smeas(1,1,:)));
% S21meas1 = reshape(Smeas1(2,1,:),1,length(Smeas1(1,1,:)));
% S21meas2 = reshape(Smeas2(2,1,:),1,length(Smeas2(1,1,:)));
% polar(angle(S21meas), abs(S21meas)); hold on;
% polar(angle(S21meas2), abs(S21meas2));
% polar(angle(S21meas1), abs(S21meas1)); hold off;
% title('S21');
% 
% subplot(2,2,4)
% smithchart(reshape(Smeas(2,2,:),1,length(Smeas(2,2,:))));hold on;
% smithchart(reshape(Smeas2(2,2,:),1,length(Smeas2(2,2,:))));
% smithchart(reshape(Smeas1(2,2,:),1,length(Smeas1(2,2,:)))); hold off;
% title(sprintf('S22\n'));

fileLoc = 'C:\Users\Ciaran Wilson\Documents\UMS-Measurement-20191008\TZ1_0210\TZ1_0210_Vg0V_Vd20V_Id95p3mA.S2P';
rfObj = read(rfdata.data,fileLoc);

fileLoc1 = 'C:\Users\Ciaran Wilson\Documents\UMS-Measurement-20191008\TZ1_0420\TZ1_0420_Vg0V_Vd20V_Id172mA.S2P';
rfObj1 = read(rfdata.data,fileLoc1);

fileLoc2 = 'C:\Users\Ciaran Wilson\Documents\UMS-Measurement-20191008\TZ1_0630\TZ1_0630_Vg0V_Vd20V_Id236p0mA.s2p';
rfObj2 = read(rfdata.data,fileLoc2);

Smeas = rfObj.S_Parameters;
Smeas1 = rfObj1.S_Parameters;
Smeas2 = rfObj2.S_Parameters;

figure
subplot(2,2,1)
%smithchart(reshape(Smeas(1,1,:),1,length(Smeas(1,1,:)))); %hold on;
smithchart(reshape(Smeas2(1,1,:),1,length(Smeas2(1,1,:))));
% smithchart(reshape(Smeas1(1,1,:),1,length(Smeas1(1,1,:)))); hold off;
title(sprintf('S11\n'));

subplot(2,2,2)
%S12meas = reshape(Smeas(1,2,:),1,length(Smeas(1,1,:)));
%S12meas1 = reshape(Smeas1(1,2,:),1,length(Smeas1(1,1,:)));
S12meas2 = reshape(Smeas2(1,2,:),1,length(Smeas2(1,1,:)));
%polar(angle(S12meas), abs(S12meas)); %hold on;
polar(angle(S12meas2), abs(S12meas2));
%polar(angle(S12meas1), abs(S12meas1)); hold off;
title('S12');

subplot(2,2,3)
%S21meas = reshape(Smeas(2,1,:),1,length(Smeas(1,1,:)));
%S21meas1 = reshape(Smeas1(2,1,:),1,length(Smeas1(1,1,:)));
S21meas2 = reshape(Smeas2(2,1,:),1,length(Smeas2(1,1,:)));
%polar(angle(S21meas), abs(S21meas)); %hold on;
polar(angle(S21meas2), abs(S21meas2));
%polar(angle(S21meas1), abs(S21meas1)); hold off;
title('S21');

subplot(2,2,4)
%smithchart(reshape(Smeas(2,2,:),1,length(Smeas(2,2,:))));%hold on;
smithchart(reshape(Smeas2(2,2,:),1,length(Smeas2(2,2,:))));
%smithchart(reshape(Smeas1(2,2,:),1,length(Smeas1(2,2,:)))); hold off;
title(sprintf('S22\n'));