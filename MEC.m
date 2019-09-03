function score = MEC(H1,M)
score=0;
[R,~]=size(M);
[nh,~]=size(H1);
if nh==1
    for h=1:length(H1)
        if H1(h)=='a'
            H2(h)='t';
        else
            H2(h)='a';
        end
    end
else
    H2=H1(2,:);
    H1=H1(1,:);
end
n=0;
for r=1:R
    d1=dist(H1,M(r,:));
    d2=dist(H2,M(r,:));
    if d1>d2
        score=d2+score;
        n=n+1;
    else
        score=d1+score;
        n=n+1;
    end
end


