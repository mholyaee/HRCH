function [M,m,n,H_real]=inputdata(varargin)
%input filename
%output SNP matrix M, m, n and real haplotypes H_real
M=[];
if nargin==4
  Mpath=varargin{1};
  name1=varargin{2};
  name2=varargin{3}; 
  k=varargin{4};
  filename=[Mpath,'\',name1,'\',name2];
else
  filename=varargin{1};
end

disp(filename);
fidin=fopen(filename);
if fidin==-1
    fprintf('ERROR %d!\n',k);
    return;
else
    tline=fgetl(fidin);  
    if ~isempty(tline)   
        M=tline;
    end
    while ~feof(fidin)        
        tline=fgetl(fidin);
        if ~isempty(tline)    
            M=[M;tline];
        end
    end
    fclose(fidin);
end
[m,n]=size(M); 
if nargin==4
    head=strtok(name2,'m');
    name2_h=strcat(head,'h.4');
    filename_h=[Mpath,'\',name1,'\',name2_h];
    
else
   filename_h=varargin{2}; 
end
fidin_h=fopen(filename_h);
if fidin_h==-1
    fprintf('ERROR %d!\n',k);
    return;
else
    L0=fgetl(fidin_h);   
    if ~isempty(L0)
        H_real(1,:)=L0;
    end
    L1=fgetl(fidin_h);  
    if ~isempty(L1)
        H_real(2,:)=L1;
    end
    fclose(fidin_h);
end
