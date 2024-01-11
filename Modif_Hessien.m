function HDP = Modif_Hessien(H)
    e = eig(H);
    tho = min(e);
    if tho > 0
        HDP = H;
    else
        I = eye(length(e));
        HDP = H-(tho+0.1)*I;
    end
end