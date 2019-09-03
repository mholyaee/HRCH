function H_assem=CompleteHap(H_rec,H_assem)
L=length(H_assem);
i=1;
for l=1:L
    if H_assem(1,l)=='-'
        H_assem(1,l)=H_rec(i);
        if H_rec(i)=='a'
           H_assem(2,l)='t';
        else
           H_assem(2,l)='a'; 
        end
        i=i+1;
    end
end
