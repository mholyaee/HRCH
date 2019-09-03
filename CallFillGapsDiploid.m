function CallFillGapsDiploid()
Thrs=[0.005,0.001,0.00008,0.00001];
clc;
Mpath=uigetdir(pwd,'Select Dataset');
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
    eind=strfind(D1(d).name,'-c');
    cover=D1(d).name(eind+2);
    cover=str2num(cover);
    if cover==1
        Thr=Thrs(4);
    elseif cover==3
        Thr=Thrs(1);
    elseif cover==5
        Thr=Thrs(2);
    elseif cover==8
        Thr=Thrs(3);
    end
    Num_exps=100;
    for i=1:Num_exps  %for each instance
        [M0,m0,n0,H_real]=inputdata(Mpath,D1(d).name,D(i).name,i);
        [~,~,~,H_assem,Most]=Heter4to2(M0,m0,n0);
        hapfilename=[num2str(i),'_hap.txt'];
        fidin=fopen([Mpath,'\',D1(d).name,'\',hapfilename]); % reconstructed haplotype
        scorefilename=[num2str(i),'_hap_Confem.txt'];
        score=dlmread([Mpath,'\',D1(d).name,'\',scorefilename]);       
        if fidin>0
            Data = textscan(fidin,'%s','delimiter',',');
            Haps=Data{1};                   % Reconstructed haps
            fclose(fidin);
            Haps=char(Haps);

            em=2;

            [Rechap]=FillGaps3_diploid(Haps,score,Thr,em);
            H_assem2=CompleteHprim(Rechap,H_assem);
            H_assem4=H_assem2to4(H_assem2,Most);
            rrs(1,i)=RR4(H_real,H_assem4);
            H_assem2=CompleteHprim(Haps,H_assem);
            H_assem4=H_assem2to4(H_assem2,Most);
            rrs(2,i)=RR4(H_real,H_assem4);
        end
    end
    if nargin==0
        %results save to:
        %//////////////////////////////////////////////////////////////////////////
        path='E:\';
        %//////////////////////////////////////////////////////////////////////////
        fid=fopen([path,D1(d).name,'_RRC.txt'],'w+');
        for j=1:Num_exps
            fprintf(fid,'%d\t%1.4f\t%1.4f\n',j,rrs(1,j),rrs(2,j));
        end
        average_rr=mean(rrs(1,:));
        average_rr2=mean(rrs(2,:));
        fprintf(fid,'ChaoticCorrection=%1.4f\t HGResult=%1.4f\tImprove=%1.4f',average_rr,average_rr2,average_rr-average_rr2);
        fclose(fid);
    end
end
end