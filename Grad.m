function [gf,gc] =Grad(fc,x0)

[~,c] = fc(x0);

m = length(c);
n = length(x0);

gf=zeros(n,1);
gc=zeros(m,n);

for i=1:n
    h=zeros(n,1);
    h(i)=10^(-8);
    

    x=x0+h;
    [f,c]=fc(x);
    [f0,c0]=fc(x0);
    gf(i)=(f-f0)/h(i);

        for j=1:m
            gc(j,i)=(c(j)-c0(j))/h(i); 
        end
end

end


 
