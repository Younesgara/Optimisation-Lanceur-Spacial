function [lamb_sol,d_sol] = MAJ(H,gf,gc,c)

    Q = H;
    A = gc;
    g = gf;
    b = -c;
    

    lamb_sol = -inv(A*inv(Q)*(A'))*(A*inv(Q)*g+b);
    d_sol = -inv(Q)*((A')*lamb_sol+g);
  
end