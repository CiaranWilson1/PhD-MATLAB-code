function bias = getBias(fileName)
%GETBIAS Determines the bias voltages from SnP files
%   SnP files created in the RF lab through VEE store the bias voltage in
%   the header. This code extracts that information.

%Open file
fp = fopen(fileName);

%Determine number of header lines to ignore
ii = 0;
while ~feof(fp)
    currLine = fgetl(fp);
    if length(currLine) >=6 && strcmp(currLine(1:6),'! VGS=')
        break
    end
    ii = ii + 1;
end

%Go back to start of file
frewind(fp);

%Start reading bias info, skipping number of header lines ii above
data = textscan(fp,'! %*s %f %*s','HeaderLines',ii);

%Save values into structure
bias.VGS = data{1}(1);
bias.VDS = data{1}(2);
bias.IG = data{1}(3);
bias.ID = data{1}(4);

%Close file
fclose(fp);

