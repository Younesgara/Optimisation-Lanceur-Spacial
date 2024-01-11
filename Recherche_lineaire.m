function [valide,x,k] = Recherche_lineaire(fc,F_merite,gf,gc,rho,d,x)
fcon = 0;
c_1 = 0.1;
[f,c] = fc(x);
[gf , gc] = Grad(fc,x);
F_d = gf'*d - rho *norm(c,1);
s = 1;
k=0;
k_max = 15;
while (F_merite(fc,x +s*d,rho) > F_merite(fc,x,rho) +c_1*s*F_d) && (k<=k_max)
    s = s/2;
    k=k+1;
end

if (k==k_max)
    valide = 0;
    
else
    valide = 1;
    x = x +s*d;
    

end
end