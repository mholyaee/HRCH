function [DelHap,remain_gaps]=InterpolatePhase1_window_local_project4_geraci_em2(varargin)
% 97-12-02
% This function in order to preserves the length of reconstructed haps, fills the remaining difficult gap mesaures randomly
if  nargin==0
    clc;
    [FileName,PathName] = uigetfile('*.*','Select info file',...
        'D:');
    fn=strcat(PathName,FileName);
    fp = fopen(fn);
    Data = textscan(fp,'%s');
    LocalHaps=char(Data{1});
else
    DelHap=varargin{1};
end
fs=0;
[Nts,~,~]=CGR_binary(DelHap,fs);    %Reconstructed with gaps

step=10;
gap_positions=find(Nts==-1);
for counter=1:length(gap_positions)
    if  gap_positions(counter)>step && gap_positions(counter)<length(Nts)-step+1
        xdata_pre=(gap_positions(counter)-step:gap_positions(counter));
        xdata_nxt=(gap_positions(counter)+1:gap_positions(counter)+step);
        xdata=[xdata_pre,xdata_nxt];
        Y=Nts(xdata);        
        Neghiborgaps=find(Y==-1);
        if isempty(Neghiborgaps)==0
            Y(Neghiborgaps)=[];
            xdata(Neghiborgaps)=[];
        end
        Nts(gap_positions(counter))=mean(Y);
    end
end
temp=find(Nts==-1);
c1=1;% counter
while c1+1<=length(Nts)
   X(c1)=Nts(c1);
   Y(c1)=Nts(c1+1);
   Z(c1,:)=[X(c1),Y(c1)];
   c1=c1+1;
end
sh=0;
if sh==1
plot(X,Y,'o','MarkerEdgeColor','k',...
    'MarkerFaceColor','g','MarkerSize',5);
xlabel('x(t)','fontweight','bold','fontsize',11);
ylabel('x(t+1)','fontweight','bold','fontsize',11);
end
for j=1:length(gap_positions)
    if gap_positions(j)>1 && gap_positions(j)<length(Nts)
       p1=Z(gap_positions(j)-1,:);
       p2=Z(gap_positions(j),:);
       d2 = point_to_line([p1,0],[0,0.5,0], [1,1,0]);
       d1 = point_to_line([p1,0],[0,0,0], [1,0.5,0]);
       d4 = point_to_line([p2,0],[0,0.5,0], [1,1,0]);
       d3 = point_to_line([p2,0],[0,0,0], [1,0.5,0]);
       x01=p1(1);
       y01=p1(2);
       x02=p2(1);
       y02=p2(2);
       if d1<d2
           poly1=[1.25,-2*x01-y01,x01^2+y01^2-d1^2];
           MappedX1=FindRoot(poly1);
           MappedY1=0.5*MappedX1;
       else
           poly2=[1.25,0.5-y01-2*x01,x01^2-d2^2+(0.5-y01)^2];
           MappedX1=FindRoot(poly2);
           MappedY1=0.5*MappedX1+0.5;
       end
       if d3<d4
           poly1=[1.25,-2*x02-y02,x02^2+y02^2-d3^2]; 
           MappedX2=FindRoot(poly1); 
           MappedY2=0.5*MappedX2;
       else
           poly2=[1.25,0.5-y02-2*x02,x02^2-d4^2+(0.5-y02)^2];
           MappedX2=FindRoot(poly2);
           MappedY2=0.5*MappedX2+0.5;
       end
       if sh==1
       hold on;
       plot(MappedX1,MappedY1,'s','MarkerEdgeColor','k',...
           'MarkerFaceColor','r','MarkerSize',6);
       plot(x01,y01,'*','MarkerEdgeColor','b',...
           'MarkerFaceColor','b','MarkerSize',8);
       plot(x02,y02,'*','MarkerEdgeColor','b',...
           'MarkerFaceColor','b','MarkerSize',8);
       plot(MappedX2,MappedY2,'s','MarkerEdgeColor','k',...
           'MarkerFaceColor','r','MarkerSize',6);
       end
       pos=strfind(DelHap,'t');
       if isempty(pos)
           if MappedY1<0.5 && MappedX2<0.5
               DelHap(gap_positions(j))='0';
           end
           if MappedY1>0.5 && MappedX2>0.5
               DelHap(gap_positions(j))='1';
           end
       else
           if MappedY1<0.5 && MappedX2<0.5
               DelHap(gap_positions(j))='t';
           end
           if MappedY1>0.5 && MappedX2>0.5
               DelHap(gap_positions(j))='a';
           end
       end
    end    
end
if sh==1
legend( {'Data','Mapped Points','Ambiguous points'},'fontsize',9);
grid on;end
remain_gaps=find(DelHap=='-');





