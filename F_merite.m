function F_n = F_merite(fc,x,rho)
    [f,c] = fc(x);
    F_n = f+rho*norm(c,1);
end