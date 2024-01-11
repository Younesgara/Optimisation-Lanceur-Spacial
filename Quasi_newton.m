function H_new = Quasi_newton(H_old,d,y,methode)
if methode == "BFGS"
    if y'*d>0
        H_new = H_old+((y*y')/(y'*d)) - (H_old*(d*d')*H_old)/(d'*H_old*d);
    else
        H_new = H_old;
    end
else
    if d.'*(y-H_old*d) ~= 0
        H_new = H_old+((y-H_old*d)*(y-H_old*d).')/d.'*(y-H_old*d);
    else
        H_new = H_old;
    end
end