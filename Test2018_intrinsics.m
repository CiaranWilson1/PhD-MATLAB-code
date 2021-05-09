filename = load('C:\Users\ciara\OneDrive\Documents\SmallSignalExtraction-20190618T120851Z-001\SmallSignalExtraction\IntrinsicMATfiles\IntrinsicMAT_14-Feb-2018.mat');
CGS=filename.CGS1;
VGS=filename.VGSQ;
VDS=filename.VDSQ;

CGS=CGS(1:2:end,1:2:end);
VGS=VGS(1:2:end,1:2:end);
VDS=VDS(1:2:end,1:2:end);

CGS=CGS(1:2:end,1:2:end);
VGS=VGS(1:2:end,1:2:end);
VDS=VDS(1:2:end,1:2:end);

figure 
mesh(VGS,VDS,CGS)