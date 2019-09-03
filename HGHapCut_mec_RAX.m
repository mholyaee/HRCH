function H_rec=HGHapCut_mec_RAX(varargin)
clc
clear
if nargin==0
    Mpath=uigetdir('D:\Bioinformatics\HapData\','Select Dataset');
    directory=[Mpath,'\exp-100-*-h0.7'];
    D1=dir(directory);
elseif nargin==6
    Mpath=varargin{1};
    directory=[Mpath,'\exp-100-*-h0.7'];
    D1=dir(directory);
    d_start=varargin{2};
    D1(d_start).name=varargin{3};
    i_start=varargin{4};
    MecType=varargin{5};
    H_rec=varargin{6};
end
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
    Num_exps=length(D);
    for i=1:Num_exps  %for each instance
        [M0,m0,n0,H_real]=inputdata(Mpath,D1(d).name,D(i).name,i);
        [M,m,n,H_assem,Most]=Heter4to2(M0,m0,n0);
        [ReadNumber,~]=size(M);
        ReadAssign=randi([1,2],1,ReadNumber);
        if nargin==0
            H_rec=rand_gen2(n);
            BestHap=H_rec;
        end
        K=5;  %  parameter k in the SkNN, It can be changed.
        C=2;   %  parameter cs the support count threshold, one can change it.
        sss=D1(d).name;
        t=100;
        j=1;
        thr=0;
        Nparts=2;% Number of partitions
        UBfactor=1;
        Nruns=10;  %default:10 range:1...10
        CType=5;   %default:1  range:1...5
        RType=3;   %default:1  range:1...3
        Vcycle=1;  %default:1  range:1...3
        Reconst=0; %default:0  range:0...1
        dbglvl=0; %range:0 or 24
        pre=0;
        MinMEC=100000;
        BestCost=100000;
        while (j<=t && thr<=50 && MinMEC>0)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            clc;
            fprintf('\n name:%s\n',D1(d).name);
            fprintf('Sample:%d\t iter:%d\t UBfactor:%d\t thr:%d\n',i,j,UBfactor,thr);
            RNNname1=MakeKNNcpp_RA(M,m,n,K,i,H_rec,sss,ReadAssign);% for haplotype phasing
            system(['fpgrowth.exe -tm -s-',num2str(C),' ',RNNname1,' ',RNNname1,'.out']); %Call an external executable file fpgrowth.exe
            fid_RNNout=fopen([RNNname1,'.out'],'r');
            temp=[num2str(i),sss,'.Graph'];
            fid_graph=fopen([num2str(i),sss,'.Graph'],'w+');
            fprintf(fid_graph,'                             \n');
            NUMedge=0;
            while ~feof(fid_RNNout)
                tline=fgetl(fid_RNNout);
                index=strfind(tline,'(');
                newtline=[tline(index+1:end-1),' ',tline(1:index-2),'\n'];
                fprintf(fid_graph,newtline);
                NUMedge=NUMedge+1;
            end
            frewind(fid_graph);
            fprintf(fid_graph,'%d %d 1',NUMedge,n);
            fclose(fid_RNNout);
            fclose(fid_graph);
            
            system(['hmetis ',num2str(i),sss,'.Graph ',num2str(Nparts),' ',num2str(UBfactor),' ',num2str(Nruns),' ',num2str(CType),' ',num2str(RType),' ',num2str(Vcycle),' ',num2str(Reconst),' ',num2str(dbglvl)]);
            Gnew1=load([num2str(i),sss,'.Graph.part.2']);% results of paritioning
            newHap=MakeHap(H_rec,Gnew1);
            [t1]=MEC(newHap,M);
            [t2]=MEC(H_rec,M);
            H_rec=newHap;            
            [ReadAssign,~]=Update_Read_Assign(H_rec,M,ReadAssign);
            [newHap2,Confidence]=MakeHapReadAssignGeraci(M,ReadAssign);
            [t3]=MEC(newHap2,M);
            j=j+1;
            if t3<t1
                H_rec=newHap2;
                thr=0;
                MinMEC=t3;
                if MinMEC<BestCost
                    BestCost=MinMEC;
                    BestHap=newHap2;
                end
            elseif t3==pre
                thr=thr+1;
            else
                thr=0;
            end
            if MinMEC>=t2
                if UBfactor<=50
                    UBfactor=UBfactor+1;
                end
                
            end
        end
        H_assem1=CompleteHap(H_rec(1,:),H_assem);
        H_assem4=H_assem2to4(H_assem1,Most);
        rrs(1,i)=RR4(H_real,H_assem4);
        fprintf('The instance %d is finished!....RR=%f\n',i,rrs(1,i));
        
        H_assem2=CompleteHap(BestHap(1,:),H_assem);
        H_assem4=H_assem2to4(H_assem2,Most);
        rrs(2,i)=RR4(H_real,H_assem4);
        fprintf('The instance %d is finished!....RR=%f\n',i,rrs(2,i));
        path=[pwd,'\results\',sss,'\'];
        mkdir(path);
        fidhap=fopen([path,num2str(i),'_hap.txt'],'w+');
        fprintf(fidhap,'%s',H_assem2(1,:));
        fclose(fidhap);
    end %end for each instance
    %save path
    if nargin==0
        path=[pwd,'\results\'];        
        fid=fopen([path,D1(d).name,'_RR.txt'],'w+');
        for j=1:Num_exps
            fprintf(fid,'%d\t%1.4f\t%1.4f\n',j,rrs(1,j),rrs(2,j));
        end
        average_rr=mean(rrs(1,:));
        average_rr2=mean(rrs(2,:));
        fprintf(fid,'mean1=%1.4f\t mean1=%1.4f',average_rr,average_rr2);
        fclose(fid);
    end
end %end for each parameter set








