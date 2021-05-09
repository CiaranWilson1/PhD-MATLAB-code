clear all;
folderName = 'C:\Users\Ciaran Wilson\Documents\DEV3_8x100_NP15\DEV3_8x100_NP15\10APR19_S2PSWEEP_-5V20V\10APR19_S2PSWEEP_-5V20V\';
fileList = dir([folderName, '*.s2p']);
numFiles = length(fileList);
fileID_w = fopen('100x8_Sparam.txt','w');
for kk=1:numFiles
    fileLoc = [folderName fileList(kk).name];
    fileID = fopen(fileLoc,'r');
    %fileID_w = fopen('100x8_Sparam.txt','w');
    
        while ~feof(fileID)
            currLine = fgetl(fileID);
            if isempty(currLine)==0 && strcmp(currLine(1), '!')
                flag=0;
                fprintf(fileID_w,'%s\n',currLine);
            else
                flag=1;
                fprintf(fileID_w,'VAR Name="%s"\n',fileList(kk).name(1:3));
                fprintf(fileID_w,'BEGIN ACDATA\n');
                break;
            end
            if(flag==1)
                break;
            end
        end
    currLine = fgetl(fileID);
    fprintf(fileID_w,'%s\n',currLine);
    fprintf(fileID_w,'%% F S[1,1](Complex) S[2,1](Complex) S[1,2](Complex) S[2,2](Complex)\n');
    data = textscan(fileID,'%f %f %f %f %f %f %f %f %f');
    for ii=1:79
        fprintf(fileID_w,'%d %f %f %f %f %f %f %f %f\n',data{1}(ii), data{2}(ii), data{3}(ii), data{4}(ii),data{5}(ii), data{6}(ii), data{7}(ii), data{8}(ii), data{9}(ii));
    end
    fprintf(fileID_w,'END\n');
    fclose(fileID);
end