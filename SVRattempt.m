clear all
close all
folderName = 'C:\Users\Ciaran Wilson\Documents\Thermal measurements 1 inputpower\';
fileList = dir([folderName, '*B21_real_shift.txt']);
numFiles = length(fileList);

A = zeros(21,9);
for ii = 1:numFiles
    fileLocation = [folderName, fileList(ii).name];
    fileID = fopen(fileLocation,'r');
    formatSpec = '%f';
    A(:,ii) = fscanf(fileID,formatSpec);
end
B21_real = reshape(A,[189,1]);

fileList = dir([folderName, '*B21_imag_shift.txt']);
for ii = 1:numFiles
    fileLocation = [folderName, fileList(ii).name];
    fileID = fopen(fileLocation,'r');
    formatSpec = '%f';
    A(:,ii) = fscanf(fileID,formatSpec);
end
B21_imag = reshape(A,[189,1]);

fileList = dir([folderName, '*A11_mag.txt']);
for ii = 1:numFiles
    fileLocation = [folderName, fileList(ii).name];
    fileID = fopen(fileLocation,'r');
    formatSpec = '%f';
    A(:,ii) = fscanf(fileID,formatSpec);
end
A11_mag = reshape(A,[189,1]);

fileList = dir([folderName, '*gamma.txt']);
for ii = 1:numFiles
    fileLocation = [folderName, fileList(ii).name];
    fileID = fopen(fileLocation,'r');
    formatSpec = '%f';
    A(:,ii) = fscanf(fileID,formatSpec);
end
gamma = reshape(A,[189,1]);

fileList = dir([folderName, '*theta.txt']);
for ii = 1:numFiles
    fileLocation = [folderName, fileList(ii).name];
    fileID = fopen(fileLocation,'r');
    formatSpec = '%f';
    A(:,ii) = fscanf(fileID,formatSpec);
end
theta = reshape(A,[189,1]);

fileID = fopen('C:\Users\Ciaran Wilson\Documents\Thermal measurements 1 inputpower\temp1.txt','r');
temp = fscanf(fileID,formatSpec);
data_test = [A11_mag gamma theta temp];
b21 = [B21_real B21_imag];
Mdl = fitrsvm(data_test,B21_real,'Standardize',true,'KernelFunction','gaussian');
Mdl1 = fitrsvm(data_test,B21_imag,'Standardize',true,'KernelFunction','gaussian');
YFit_real = predict(Mdl,data_test);
YFit_imag = predict(Mdl1,data_test);


