function RNNname=MakeKNNcpp_RA(M,m,n,K,ith,H_rec,sss,ReadAssign)
SS=FindKnn_RA3(M,H_rec,m,n,ReadAssign);
[Measure,I]=sort(SS,2,'descend');
knn=I(:,1:K);
NN=zeros(n,n);
for i=1:n
    for j=1:K
        NN(i,knn(i,j))=1;
    end
end
RNN=NN';% Reverse NN
RNNname=[num2str(ith),sss,'RNN1.tab'];
fid_RNN=fopen(RNNname,'w+');
for i=1:n
    for j=1:n
        if RNN(i,j)==1
            fprintf(fid_RNN,'%d ',j);
        end
    end
    fprintf(fid_RNN,'\n');
end
fclose(fid_RNN);
end

