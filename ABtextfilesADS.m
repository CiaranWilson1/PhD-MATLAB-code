folderName = 'C:\Users\Ciaran Wilson\Documents\ADS_loadpull\';
fileList = dir([folderName, 'const_2GHz_11dBm_B21.txt']);
numFiles = length(fileList);


for ii = 1:numFiles
    fileLocation = [folderName, fileList(ii).name];
    
    [gamma,theta,B21real,B21imag]=getABsADS1(fileLocation);
  

fileName=fileLocation;
Num = regexp(fileName,'\d');
NumInit = Num(1);
Stop = regexp(fileName,'\.');
ActStop = Stop -1;
temp=char(fileName);
temp1 = temp(NumInit:ActStop);
string = sprintf('%s_real.txt',temp1);
fid = fopen(string,'wt');
formatSpec = '%1.8f\n';
fprintf(fid,formatSpec,B21real);
fclose(fid);
string1 = sprintf('%s_imag.txt',temp1);
fid = fopen(string1,'wt');
fprintf(fid,formatSpec,B21imag);
fclose(fid);
string6 = sprintf('%s gamma.txt',temp1);
fid = fopen(string6,'wt');
fprintf(fid,formatSpec,gamma);
fclose(fid);
string2 = sprintf('%s theta.txt',temp1);
fid = fopen(string2,'wt');
fprintf(fid,formatSpec,theta);
fclose(fid);
end

fileList = dir([folderName, '*A21.txt']);
numFiles = length(fileList);


for ii = 1:numFiles
    fileLocation = [folderName, fileList(ii).name];
    
    [gamma,theta,A21real,A21imag]=getABsADS(fileLocation);
  

fileName=fileLocation;
Num = regexp(fileName,'\d');
NumInit = Num(1);
Stop = regexp(fileName,'\.');
ActStop = Stop -1;
temp=char(fileName);
temp1 = temp(NumInit:ActStop);
string = sprintf('%s_real.txt',temp1);
fid = fopen(string,'wt');
formatSpec = '%1.8f\n';
fprintf(fid,formatSpec,A21real);
fclose(fid);
string1 = sprintf('%s_imag.txt',temp1);
fid = fopen(string1,'wt');
fprintf(fid,formatSpec,A21imag);
fclose(fid);

end

fileList = dir([folderName, 'const_2GHz_11dBm_A11.txt']);
numFiles = length(fileList);

for ii = 1:numFiles
    fileLocation = [folderName, fileList(ii).name];
    
    [gamma,theta,A11real,A11imag]=getABsADS1(fileLocation);
  

fileName=fileLocation;
Num = regexp(fileName,'\d');
NumInit = Num(1);
Stop = regexp(fileName,'\.');
ActStop = Stop -1;
temp=char(fileName);
temp1 = temp(NumInit:ActStop);
string = sprintf('%s_real.txt',temp1);
fid = fopen(string,'wt');
formatSpec = '%1.8f\n';
fprintf(fid,formatSpec,A11real);
fclose(fid);
string1 = sprintf('%s_imag.txt',temp1);
fid = fopen(string1,'wt');
fprintf(fid,formatSpec,A11imag);
fclose(fid);

end

A21complex=A21real+j*A21imag;
B21complex=B21real+j*B21imag;
%fullgamma=A21complex/B21complex;

