function H_rec=rand_gen2(N)

vector=randi([1,2],1,N);
h1(find(vector==1))='a';
h2(find(vector==1))='t';
h1(find(vector==2))='t';
h2(find(vector==2))='a';
H_rec=[h1;h2];