function  D=dist(H,f)
L=length(H);
D=0;
for l=1:L
    if f(l)~='-'
        if H(l)~=f(l)
            D=D+1;
        end
    end
end

