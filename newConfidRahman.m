function newConfidRahman()
clc;
Mpath=uigetdir('D:\','Select Dataset');
directory=[Mpath,'\exp-700-*-h0.7'];
D1=dir(directory);
if isempty(D1)
    fprintf(['ERROR! Fail to find ',Mpath,'\n']);
    return;
end

Num_paras=length(D1);
for d=1:Num_paras
    D=dir([Mpath,'\',D1(d).name,'\*.m.4.err']);
    if isempty(D)
        fprintf('ERROR! Fail to find %s *.m.4.err!\n',D1(d).name);
        return;
    end
    fprintf('Succeed to find %s \\*.m.4.err!\n',D1(d).name);
    eind=strfind(D1(d).name,'-e');
    NoiseChar=D1(d).name(eind+2:eind+4);
    NoiseRate=str2double(NoiseChar);
    Q=1-NoiseRate;
    Num_exps=100;
    i_start=1;
    
    for i=i_start:Num_exps  %for each instance
        [M0,m0,n0,~]=inputdata(Mpath,D1(d).name,D(i).name,i);
        [M,~,~,H_assem,~]=Heter4to2(M0,m0,n0);
        hapfilename=[num2str(i),'_hap.txt'];
        fidin=fopen([Mpath,'\',D1(d).name,'\',hapfilename]);
        if fidin>0
            Data = textscan(fidin,'%s','delimiter',',');
            Haps=Data{1};                   % Reconstructed haps
            fclose(fidin);
            Haps=char(Haps);
            [R,~]=size(M);
            ReadAssign=zeros(1,R);
            [~,tmpHaps]=RemoveHomozygote(Haps,H_assem);
            tmpHaps=PairHap(tmpHaps);
            [ReadAssign,~]=Update_Read_Assign(tmpHaps,M,ReadAssign);
            [Confidence]=EmissionScoreDiploid(M,ReadAssign,Q,tmpHaps);
            FinalHaps=CompleteHap(tmpHaps(1,:),H_assem);
            FinalConfidence=CompleteConfid(FinalHaps,Confidence);
            filename=strrep(hapfilename,'.txt','');
            fidscore=[Mpath,'\',D1(d).name,'\',filename,'_Confem.txt'];
            %Homozygot Sections
            dlmwrite(fidscore,FinalConfidence,'delimiter','\t');
        end
        
    end
end
