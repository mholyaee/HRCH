function [DelHap]=InterpolatePhase1_window_local_project4_geraci(varargin)

if  nargin==0
    clc;
    [FileName,PathName] = uigetfile('*.*','Select info file',...
        'D:\');
    fn=strcat(PathName,FileName);
    fp = fopen(fn);
    Data = textscan(fp,'%s');
    LocalHaps=char(Data{1});
else
    DelHap=varargin{1};
    Fill_rand=DelHap;
end
fs=0;
[Nts,~,~]=CGR_binary(DelHap,fs);
xdata=(1:length(Nts));
f = fittype('smoothingspline');
step=20;
gap_positions=find(Nts==-1);
for counter=1:length(gap_positions)
    if  gap_positions(counter)>step && gap_positions(counter)<length(Nts)-step+1
        xdata_pre=(gap_positions(counter)-step:gap_positions(counter));
        xdata_nxt=(gap_positions(counter)+1:gap_positions(counter)+step);
        xdata=[xdata_pre,xdata_nxt];
        Y=Nts(xdata);
        Nts(gap_positions(counter))=mean(Y);
        
        Neghiborgaps=find(Y==-1);
        if isempty(Neghiborgaps)==0
            Y(Neghiborgaps)=[];
            xdata(Neghiborgaps)=[];
        end
        Pos=step+1;
        for k=1:length(Neghiborgaps)
            if gap_positions(counter)>Neghiborgaps(k)
                Pos=Pos-1;
            end
        end
        [fit1,gof,fitinfo] = fit(xdata',Y',f);
        residuals1 = fitinfo.residuals';
        tmp=Nts(gap_positions(counter))-residuals1(Pos);
        if tmp>0.5
            DelHap(gap_positions(counter))='t';
        else
            DelHap(gap_positions(counter))='a';
        end
    end
end
remain_gaps=find(DelHap=='-');
%+++++++++++++++++++++++++++++
for k=1:length(remain_gaps)
   DelHap(remain_gaps(k))=num2str(round(rand(1))); 
end
%+++++++++++++++++++++++++++++
%Plot_________________________________________________________________
flag=0;
if flag==1
    xdata=1:length(Nts);
    sppoints=sort(sppoints);
    tmp=Nts;
    tmp(sppoints)=10;
    [fit1,gof,fitinfo] = fit(xdata',Nts',f);
    GapPosition=tmp==10;
    figure;
    plot(fit1,'g-',xdata',Nts','b.',GapPosition,'r*')
    hold on
    p=plot(fit1,'g-')
    set(p,'LineWidth',2.5);
    xlim([100 300])
    ylim([0 1])
    title_font_size = 10;
    legend( {'Data', 'Ambiguous points','Fitted curve'},'fontsize',9);
    set(gca,'fontweight','bold','fontsize',title_font_size)
    grid on;
    hold off
end



