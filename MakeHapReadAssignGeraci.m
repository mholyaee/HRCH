function [Hap,Confidence]=MakeHapReadAssignGeraci(Frags,ReadAssign)
[~,C]=size(Frags);
Nploid=unique(ReadAssign);
L=length(Nploid);
al(1)='a';
al(2)='t';
Confidence=zeros(L,C);
for i=1:L
    n1= ReadAssign(1,:)==i;
    Cluster='';
    Cluster=Frags(n1,:);
    allele=zeros(1,2);
    for cc=1:C
        for j=1:2
            tmp=find(Cluster(:,cc)==al(j));
            allele(j)=length(tmp);
        end
        MajorAllele=max(allele);
        index=find(allele==MajorAllele);
        Hap(i,cc)=al(index(1));
        Confidence(i,cc)=MajorAllele/(sum(allele));
    end
end