function [Y, in1, in2] = newton(X, k, ve, Vc)
    
    % Calcul des coefficients intermédiaires
    w = k ./ (1 + k);
    in1 = (1 / w(1)) * (1 - ve(3) / ve(1) * (1 - w(3) * X));
    in2 = (1 / w(2)) * (1 - ve(3) / ve(2) * (1 - w(3) * X));

    % Calcul de la fonction à annuler
    Y = ve(1) * log(in1) + ve(2) * log(in2) + ve(3) * log(X) - Vc;
end
