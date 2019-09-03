function [ Confidence ] = EmissionScoreDiploid( Frags,ReadAssign,Q,RecHap)
% Based on "Probabilistic single-individual haplotyping" paper
% Called by newConfidRahman
[~,C]=size(Frags);
temp=find(ReadAssign(1,:)==0);
Nploid=unique(ReadAssign);
if isempty(temp)==0
    L=length(Nploid)-1;
else
    L=length(Nploid);
end
Confidence=zeros(1,C);
Score=zeros(1,C);

for i=1:L
    n1{i}=find(ReadAssign(1,:)==i);
    Cluster{i}=Frags(n1{i},:);
end
for cc=1:C
    em=1;
    for j=1:L
        tmp=find(Cluster{j}(:,cc)~='-');
        for k=1:length(tmp)
            if Cluster{j}(tmp(k),cc)==RecHap(j,cc)
                em=em*Q;
            else
                em=em*(1-Q);
            end
        end
    end
    Score(cc)=em;
end
for l=1:L
   Confidence(l,:)=Score;
end
    

