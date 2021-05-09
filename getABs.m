function bias = getABs(fileName)
%GETBIAS Determines the bias voltages from SnP files
%   SnP files created in the RF lab through VEE store the bias voltage in
%   the header. This code extracts that information.

%Open file
fp = fopen(fileName);

%Determine number of header lines to ignore
ii = 0;
while ~feof(fp)
    currLine = fgetl(fp);
    if length(currLine) >=6 && strcmp(currLine(1:3),'001')
        break
    end
    ii = ii + 1;
end
jj = 0;
while ~feof(fp)
    jj = jj + 1;
    currLines = str2num(currLine);
    A11real(jj) = currLines(4);
    A11imag(jj) = currLines(5);
    A21real(jj) = currLines(8);
    A21imag(jj) = currLines(9);
    B21real(jj) = currLines(10);
    B21imag(jj) = currLines(11);
    gamma(jj) = currLines(2);
    phase(jj) = currLines(3);
    currLine = fgetl(fp);
end
    jj = jj + 1;
    currLines = str2num(currLine);
    A11real(jj) = currLines(4);
    A11imag(jj) = currLines(5);
    A21real(jj) = currLines(8);
    A21imag(jj) = currLines(9);
    B21real(jj) = currLines(10);
    B21imag(jj) = currLines(11);
    gamma(jj) = currLines(2);
    phase(jj) = currLines(3);
    
    totmat = [gamma' phase' A11real' A11imag' A21real' A21imag' B21real' B21imag'];
    totmat1 = sortrows(totmat,[1 2 3 4 5 6 7 8]);
    
    gamma = totmat1(:,1);
    phase = totmat1(:,2);
    A11real = totmat1(:,3);
    A11imag = totmat1(:,4);
    A21real = totmat1(:,5);
    A21imag = totmat1(:,6);
    B21real = totmat1(:,7);
    B21imag = totmat1(:,8);
    A11mag = sqrt(A11real.^2+A11imag.^2);
    A11phase = atan(A11imag/A11real);
    A11phase = A11phase(:,21);
    A11complex = A11real + 1j*A11imag;
    A11complexShift = exp(-1j*2.761)*A11complex;
    A11realShift = real(A11complexShift);
    A11imagShift = imag(A11complexShift);
    B21complex = B21real + 1j*B21imag;
    B21complexShift = exp(-1j*A11phase).*B21complex;
    B21realShift = real(B21complexShift);
    B21imagShift = imag(B21complexShift);
    
    

Num = regexp(fileName,'\d');
NumInit = Num(1);
Stop = regexp(fileName,'\.');
ActStop = Stop -1;
temp=char(fileName);
temp1 = temp(NumInit:ActStop);
string = sprintf('%s A11_real.txt',temp1);
fid = fopen(string,'wt');
formatSpec = '%1.8f\n';
fprintf(fid,formatSpec,A11real);
fclose(fid);
string1 = sprintf('%s A11_imag.txt',temp1);
fid = fopen(string1,'wt');
fprintf(fid,formatSpec,A11imag);
fclose(fid);
string2 = sprintf('%s A21_real.txt',temp1);
fid = fopen(string2,'wt');
fprintf(fid,formatSpec,A21real);
fclose(fid);
string3 = sprintf('%s A21_imag.txt',temp1);
fid = fopen(string3,'wt');
fprintf(fid,formatSpec,A21imag);
fclose(fid);
string4 = sprintf('%s B21_real.txt',temp1);
fid = fopen(string4,'wt');
fprintf(fid,formatSpec,B21real);
fclose(fid);
string5 = sprintf('%s B21_imag.txt',temp1);
fid = fopen(string5,'wt');
fprintf(fid,formatSpec,B21imag);
fclose(fid);
string6 = sprintf('%s gamma.txt',temp1);
fid = fopen(string6,'wt');
fprintf(fid,formatSpec,gamma);
fclose(fid);
string7 = sprintf('%s theta.txt',temp1);
fid = fopen(string7,'wt');
fprintf(fid,formatSpec,phase);
fclose(fid);
string8 = sprintf('%s A11_real_shift.txt',temp1);
fid = fopen(string8,'wt');
fprintf(fid,formatSpec,A11realShift);
fclose(fid);
string9 = sprintf('%s A11_imag_shift.txt',temp1);
fid = fopen(string9,'wt');
fprintf(fid,formatSpec,A11imagShift);
fclose(fid);
string10 = sprintf('%s B21_real_shift.txt',temp1);
fid = fopen(string10,'wt');
fprintf(fid,formatSpec,B21realShift);
fclose(fid);
string11 = sprintf('%s B21_imag_shift.txt',temp1);
fid = fopen(string11,'wt');
fprintf(fid,formatSpec,B21imagShift);
fclose(fid);
string12 = sprintf('%s A11_mag.txt',temp1);
fid = fopen(string12,'wt');
fprintf(fid,formatSpec,A11mag);
fclose(fid);