function [ind,Haps]=RemoveHomozygote(Haps,H_assem)
H_assem=H_assem';
ind=[];
[R,~]=size(H_assem);
j=1;
for r=1:R
    if strcmp(H_assem(r,:),'--')==0
       ind(j)=r;
       j=j+1;
    end
end
Haps(ind)=[];