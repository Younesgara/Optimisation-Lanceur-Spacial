function [f,c] = testfun_2(x)
    f=x(1)^2+x(2)^2;
    c= [x(1)+x(2)-1;x(1)+x(2)-1];
end