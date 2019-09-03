function  D=dist_of_seq2(S1,S2)
L=length(S1);
D=0;
for l=1:L
    if S1(l)~='-'&& S2(l)~='-'
        if S1(l)~=S2(l)
            D=D+1;
        else
            D=D-1;
        end
    end
end