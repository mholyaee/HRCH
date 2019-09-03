function S=FindKnn_RA3(M,H_rec,m,n,ReadAssign) 
% make snp graph
d=zeros(n,n);
c=zeros(n,n);
S=zeros(n,n);
MaxC=0;
for i=1:n-1
    for j=i+1:n
        for k=1:m
            if (M(k,i)~='-' && M(k,j)~='-')
                ngaps=length(strfind(M(k,:),'-'));
                nelem=n-ngaps;
                t1=M(k,i);
                t2=M(k,j);
                t3=H_rec(ReadAssign(k),i);
                t4=H_rec(ReadAssign(k),j);
                if t1=='a'
                    nt1=0;
                else
                    nt1=1;
                end
                if t2=='a'
                    nt2=0;
                else
                    nt2=1;
                end
                if t3=='a'
                    nt3=0;
                else
                    nt3=1;
                end
                if t4=='a'
                    nt4=0;
                else
                    nt4=1;
                end
                if (nt1==nt3 && nt2==nt4)
                    c(i,j)=c(i,j)+1/nelem;
                    c(j,i)=c(j,i)+1/nelem;
                elseif(nt1~=nt3 && nt2~=nt4) 
                    d(i,j)=d(i,j)+1/nelem;
                    d(j,i)=d(j,i)+1/nelem;
                elseif(nt1==nt3 && nt2~=nt4)  
                    c(i,j)=c(i,j)+1/nelem;
                    d(j,i)=d(j,i)+1/nelem;
                elseif(nt1~=nt3 && nt2==nt4)
                    d(i,j)=d(i,j)+1/nelem;
                    c(j,i)=c(j,i)+1/nelem;
                end
            end
        end
    end
end
S=c-d;


