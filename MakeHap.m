function newHap=MakeHap(H_rec,P)
[R,~]=size(H_rec);
newHap=H_rec;
if R==1
    for i=1:length(P)
        if P(i)==1
            if newHap(i)=='a'
                newHap(i)='t';
            else
                newHap(i)='a';
            end
        end
    end
else
    ind=find(P==1);
    tmp=newHap(1,ind);
    newHap(1,ind)=newHap(2,ind);
    newHap(2,ind)=tmp;
end

