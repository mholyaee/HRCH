function H_assem4=H_assem2to4(H_assem,Most)
n0=size(H_assem,2);
H_assem4=char(ones(2,n0)*97);
A=Most';
for j=1:n0
    if H_assem(1,j)=='a' && H_assem(2,j)=='a'
        H_assem4(1,j)=A(1,j);
        H_assem4(2,j)=A(1,j);
    elseif H_assem(1,j)=='a' && H_assem(2,j)=='t'
        H_assem4(1,j)=A(1,j);
        H_assem4(2,j)=A(2,j);
    elseif H_assem(1,j)=='t' && H_assem(2,j)=='a'
        H_assem4(1,j)=A(2,j);
        H_assem4(2,j)=A(1,j);
    end
end

        
        

