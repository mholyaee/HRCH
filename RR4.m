function rr=RR4(H_real,H_assem4)
n0=size(H_real,2);
HD11=0;
HD22=0;
HD12=0;
HD21=0;
for j=1:n0
    if H_assem4(1,j)~=H_real(1,j)
        HD11=HD11+1;
    end
    if H_assem4(2,j)~=H_real(2,j)
        HD22=HD22+1;
    end
    if H_assem4(1,j)~=H_real(2,j)
        HD12=HD12+1;
    end
    if H_assem4(2,j)~=H_real(1,j)
        HD21=HD21+1;
    end  
end
rr=1-min(HD11+HD22,HD12+HD21)/(2*n0);
