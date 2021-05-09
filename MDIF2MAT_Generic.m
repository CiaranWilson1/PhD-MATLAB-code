filename = 'C:\Users\Ciaran Wilson\Documents\Cap_data_marek\ldmos_cv.mdf';

fid = fopen(filename);
fp2 = fopen(filename);
% IDS=zeros(414,414);
% VDS=zeros(414,414);
ii=0;
ll=1;
% oo=0;
% a1_mat =zeros(10,7);
% b1_mat =zeros(10,7);
% a2_mat =zeros(10,7);
% b2_mat =zeros(10,7);
% i2_mat =zeros(10,7);

%while ll < 10
%fid = fopen('fgetl.m');
        cac = textscan( fid, '%s', 'Delimiter', '\n' );
        [~] = fclose( fid );
        %   find rows which begin with 'R'.  
        isR = cellfun( @(str) strncmp(strtrim(str),'VgsIdx',1), cac{:} );
        isCap = cellfun( @(str) strncmp(strtrim(str),'%f %f',1), cac{:} );
        VGS = cellfun( @(str) strncmp(strtrim(str),'VGS',1), cac{:} );
        samp=find(isR);
        rlt = cac{:}(isR);
        tot = cac{:}(isCap);
        tot_str = strjoin( tot, '\n' );
        one_str = strjoin( rlt, '\n' );
        result  = textscan( one_str, '%s%s%s%f', 'CollectOutput',true ); 
        
        result_data  = textscan( tot_str, '%f%f', 'CollectOutput',true ); 

out = [];        
ipart = 0;
len = 2132;
part = zeros(2, len);

        
while 1  % Infinite loop
  s = fgets(fp2);
  if ischar(s)
    data = sscanf(s, '%g %g', 2);
    if length(data) == 2
      ipart = ipart + 1;
      part(:, ipart) = data;
      if ipart == len
        out = cat(2, out, part);
        ipart = 0;
      end
    end
  else  % End of file:
    break;
  end
end

out = cat(2, out, part(:, 1:ipart));
ll=0;
Old_length_n=0;
VdsIdx=0;
%VgsIdx=zeros(23,30);
VgsIdx=[];

for qq=1:1:length(out)
    Current_num=out(1,qq);
    Cap = out(2,qq);
    if Current_num == 0
        Length_now=length(VdsIdx);
        Diff_length = (Length_now)-Old_length_n;
        temp=repmat(ll-1,1,Diff_length);
        VgsIdx = [VgsIdx temp];
        Old_length_n=Length_now;
        ll=ll+1;
%         temp=repmat(ll-1,1,Diff_length);
%         VgsIdx = [VgsIdx temp];
%         Old_length_n=Length_now;
        if ll == 23
            break
        end
    end
    VdsIdx(qq) = Current_num;
    C11(qq) = Cap;
end
%fclose(fid);
VdsIdx2=out(1,423:844);
C12=out(2,423:844);
VdsIdx3=out(1,845:1266);
C22=out(2,845:1266);
VdsIdx4=out(1,1267:1688);
C21=out(2,1267:1688);
VgsIdx_test=out(1,1689:1710);
ActVgs=out(2,1689:1710);
VdsIdx_test=out(1,1711:2132);
ActVds=out(2,1711:2132);

VgsIdx(VgsIdx==-1)=0;


for uu=1:1:22
    val2b_rep = VgsIdx_test(uu);
    rep_val = ActVgs(uu);
    
    VgsIdx(VgsIdx==val2b_rep)=rep_val;
%     VdsIdx2(VdsIdx2==val2b_rep)=rep_val;
%     VdsIdx3(VdsIdx3==val2b_rep)=rep_val;
%     VdsIdx4(VdsIdx4==val2b_rep)=rep_val;
end   

for gg=1:1:422
    val2b_rep = VdsIdx_test(gg);
    rep_val = ActVds(gg);
    
    VdsIdx(gg)=rep_val;
    VdsIdx2(gg)=rep_val;
    VdsIdx3(gg)=rep_val;
    VdsIdx4(gg)=rep_val;
end  
kk=0;
Old_length_n=0;
Act_vals=0;
Act_vals1=0;
C11_new=0;
C12_new=0;
C21_new=0;
C22_new=0;
ll=0;
Vds_Idx_mat=zeros(21,31);
Vgs_Idx_mat=zeros(21,31);
C11_mat=zeros(21,31);
C12_mat=zeros(21,31);
C21_mat=zeros(21,31);
C22_mat=zeros(21,31);
for jj=1:1:length(VdsIdx)
    Current_num=VdsIdx(jj);
    Current_num1=VgsIdx(jj);
    Cap = C11(jj);
    Cap1 = C12(jj);
    Cap2 = C21(jj);
    Cap3 = C22(jj);
    if Current_num < 0.1
        ll=ll+1;
%         if ll==1
%             break
%         end
        Length_now=kk;
        Diff_length = (Length_now)-Old_length_n;
        %temp=repmat(ll-1,1,Diff_length);
        PlaceH=length(Act_vals);
        NumNans=31-PlaceH;
        Act_vals_v1=[Act_vals NaN(1,NumNans)];
        Act_vals1_v1=[Act_vals1 NaN(1,NumNans)];
        C11_v1=[C11_new NaN(1,NumNans)];
        C12_v1=[C12_new NaN(1,NumNans)];
        C21_v1=[C21_new NaN(1,NumNans)];
        C22_v1=[C22_new NaN(1,NumNans)];
        Vds_Idx_mat(ll,:)=Act_vals_v1;
        Vgs_Idx_mat(ll,:)=Act_vals1_v1;
        C11_mat(ll,:)=C11_v1;
        C12_mat(ll,:)=C12_v1;
        C21_mat(ll,:)=C21_v1;
        C22_mat(ll,:)=C22_v1;
        %VgsIdx = [VgsIdx temp];
        Old_length_n=Length_now;
        %ll=ll+1;
        Act_vals=0;
        Act_vals1=0;
        C11_new=0;
        C12_new=0;
        C21_new=0;
        C22_new=0;
        kk=0;
%         temp=repmat(ll-1,1,Diff_length);
%         VgsIdx = [VgsIdx temp];
%         Old_length_n=Length_now;
%         if ll == 23
%             break
%         end
    end
    kk=kk+1;
    VdsIdx(jj) = Current_num;
    Act_vals(kk)=Current_num;
    Act_vals1(kk)=Current_num1;
    C11_new(kk) = Cap;
    C12_new(kk) = Cap1;
    C21_new(kk) = Cap2;
    C22_new(kk) = Cap3;
end
Vds_Idx_mat(1,:) = [];

Vds_Idx_mat(22,:) = [VdsIdx(410:422) NaN(1,18)];

Vgs_Idx_mat(1,:) = [];

Vgs_Idx_mat(22,:) = [VgsIdx(410:422) NaN(1,18)];

C11_mat(1,:) = [];
C11_mat(22,:) = [C11(410:422) NaN(1,18)];
C12_mat(1,:) = [];
C12_mat(22,:) = [C12(410:422) NaN(1,18)];
C21_mat(1,:) = [];
C21_mat(22,:) = [C21(410:422) NaN(1,18)];
C22_mat(1,:) = [];
C22_mat(22,:) = [C22(410:422) NaN(1,18)];

%Vgs_Idx_mat = repmat(VgsIdx,1,31);

samp=repmat(0:1:21,1,21);

fileName = 'C11';
save(fileName,'C11_mat','Vgs_Idx_mat','Vds_Idx_mat');
fileName = 'C12';
save(fileName,'C12_mat','Vgs_Idx_mat','Vds_Idx_mat');
fileName = 'C21';
save(fileName,'C21_mat','Vgs_Idx_mat','Vds_Idx_mat');
fileName = 'C22';
save(fileName,'C22_mat','Vgs_Idx_mat','Vds_Idx_mat');

