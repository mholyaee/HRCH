function tmpHaps=PairHap(tmpHaps)
R=length(tmpHaps);
tmpHaps=[tmpHaps;tmpHaps];
for r=1:R
    if tmpHaps(1,r)=='a'
       tmpHaps(2,r)='t';
    else
       tmpHaps(2,r)='a'; 
    end  
end