function [gamma,theta,B21real,B21imag] = getABsADS(fileName)
%GETBIAS Determines the bias voltages from SnP files
%   SnP files created in the RF lab through VEE store the bias voltage in
%   the header. This code extracts that information.

%Open file
fp = fopen(fileName);

%Determine number of header lines to ignore
jj = 0;
currLine = fgetl(fp);
B21real = zeros(1, 6*36);
B21imag = zeros(1, 6*36);
while ~feof(fp)
    jj = jj + 1;
    currLines = str2num(currLine);
    theta(jj) = currLines(1);
    B21real(jj) = currLines(2);
    B21imag(jj) = currLines(3);
    B21real(jj+36) = currLines(4);
    B21imag(jj+36) = currLines(5);
    B21real(jj+36*2) = currLines(6);
    B21imag(jj+36*2) = currLines(7);
    B21real(jj+36*3) = currLines(8);
    B21imag(jj+36*3) = currLines(9);
    B21real(jj+36*4) = currLines(10);
    B21imag(jj+36*4) = currLines(11);
    B21real(jj+36*5) = currLines(12);
    B21imag(jj+36*5) = currLines(13);
    currLine = fgetl(fp);
end
    jj = jj + 1;
    currLines = str2num(currLine);
    theta(jj) = currLines(1);
    B21real(jj) = currLines(2);
    B21imag(jj) = currLines(3);
    B21real(jj+36) = currLines(4);
    B21imag(jj+36) = currLines(5);
    B21real(jj+36*2) = currLines(6);
    B21imag(jj+36*2) = currLines(7);
    B21real(jj+36*3) = currLines(8);
    B21imag(jj+36*3) = currLines(9);
    B21real(jj+36*4) = currLines(10);
    B21imag(jj+36*4) = currLines(11);
    B21real(jj+36*5) = currLines(12);
    B21imag(jj+36*5) = currLines(13);
    
    theta=repmat(theta,1,6);
    
    gamma=[0.1:0.1:0.6];
    gamma=reshape(gamma(ones(1,36),:),1,[]);
    
%     totmat = [theta' B21real' B21imag'];
%     totmat1 = sortrows(totmat,[1 2 3]);
%     
%     theta = totmat1(:,1);
%     B21real = totmat1(:,2);
%     B21imag = totmat1(:,3);

    


