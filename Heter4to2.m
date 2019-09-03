function [M,m,n,H_assem,Most]=Heter4to2(M0,m0,n0)
%This function is related to HGHap written by Chen, 2014
alphas=['a','c','g','t'];
F=zeros(n0,4); 
for j=1:n0
    n_a=0;
    n_c=0;
    n_g=0;
    n_t=0;
    for i=1:m0
        if M0(i,j)=='a'
            n_a=n_a+1;
        elseif M0(i,j)=='c' 
            n_c=n_c+1;
        elseif M0(i,j)=='g'
            n_g=n_g+1;
        elseif M0(i,j)=='t'
            n_t=n_t+1;
        end
    end
    n_base=n_a+n_c+n_g+n_t;
    F(j,:)=[n_a/n_base,n_c/n_base,n_g/n_base,n_t/n_base];
end
H_assem=char(ones(2,n0)*45); 
Most=char(ones(n0,2)*45);
X=char(ones(m0,n0)*45);  
Y=[];  
M=[]; 
[F_sort,I]=sort(F,2,'descend');
for j=1:n0
    if F_sort(j,1)>=0.8
        Most(j,1)=alphas(I(j,1));
        Most(j,2)='-';
        for i=1:m0
            if M0(i,j)~='-'
                X(i,j)='a';
            else
                X(i,j)='-';
            end
        end
        H_assem(1,j)='a';
        H_assem(2,j)='a';       
    else
        Most(j,1)=alphas(I(j,1));
        Most(j,2)=alphas(I(j,2));
        for i=1:m0
            if M0(i,j)==Most(j,1)
                X(i,j)='a';
            elseif M0(i,j)==Most(j,2)
                X(i,j)='t';
            else
                X(i,j)='-';
            end
        end
        Y=[Y,X(:,j)];
    end     
end

n=size(Y,2);
a=0;
for i=1:m0
    for j=1:n
        if Y(i,j)~='-'
            a=a+1;
        end
    end
    if a>0   
        M=[M;Y(i,:)];
    end
    a=0;
end
m=size(M,1);        




