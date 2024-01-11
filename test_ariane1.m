function [f,c] = test_ariane1(me)

Ve = [2647.2; 2922.4; 4344.3];
dVr = 11527;

k = [0.1101; 0.1532; 0.2154];
ms = k.*me;

mu = 1700;

MI = [0 ,0 ,0 ,mu+ms(3)];
MF = [0 ,0 ,0];

for i=1:3
    MF(4-i) = MI(5-i) + ms(4-i);
    Mi(4-1) = MF(4-i) + ms(4-i);
end
f = MI(1);
c = Ve(1)*log(MI(1)/MF(1)) + Ve(2)*log(MI(2)/MF(2)) + Ve(3)*log(MI(3)/MF(3));