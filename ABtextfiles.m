folderName = 'C:\Users\Ciaran Wilson\Documents\Thermal Measurements\';
fileList = dir([folderName, '*.lpwave']);
numFiles = length(fileList);


kk=0;
prevtemp1 =0;
oo=0;
qq=1;
for ii = 1:numFiles
    fileLocation = [folderName, fileList(ii).name];
    Num = regexp(fileLocation,'\d');
    NumInit = Num(1);
    Stop1 = regexp(fileLocation,'\ ');
    Stop = Stop1(3);
    ActStop = Stop -1;
    temp=char(fileLocation);
    temp1 = temp(NumInit:ActStop);
    temper = str2num(temp1);
            if temper ~= prevtemp1
                for pp = 1:21
                    tempvec1(qq+pp + oo - 1) = temper;
                       
                end
                    qq = qq + 1;
                    oo = oo+20;
            end
    %temper = str2num(temp1);
           for jj = 1:21
               tempvec(ii+jj + kk - 1) = temper;
           end
    kk = kk+20;
    getABs(fileLocation);
    prevtemp1 = temper;
end

tempvec = tempvec';
fid = fopen('temp.txt','wt');
formatSpec = '%3.0f\n';
fprintf(fid,formatSpec,tempvec);
fclose(fid);
tempvec1 = tempvec1';
tempvec1=tempvec1(tempvec1~=152);
fid = fopen('temp1.txt','wt');
formatSpec = '%3.0f\n';
fprintf(fid,formatSpec,tempvec1);
fclose(fid);