function [tmp,flag]=Update_Read_Assign(Hap,Frags,ReadAssign)
[nPloids,~]=size(Hap);
[R,~]=size(Frags);
d=zeros(1,nPloids);
tmp=ReadAssign;
flag=0;
for r=1:R
    for i=1:nPloids
        d(i)=dist_of_seq2(Hap(i,:),Frags(r,:));
    end
    MinMeasure=min(d);
    ind=find(d==MinMeasure,1,'first');
    tmp(r)=ind;
end
for r=1:R
    if ReadAssign(r)~=tmp(r)
        flag=1;
        break;
    end
end
end

