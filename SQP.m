function [x, lambd] = SQP(fc, x0, iter_max)

% Initialisation
x = x0;
n = length(x);
k = 0;
gf = 0;
gc = 0;
h_init = 1;
rho = 1;
k = 0;
fcon = 0;

% Affichage de l'en-tête
fprintf('iter:k  fcon              xk                        f(xk)              c(xk)                            lambda      ')

% Boucle d'itération SQP
while k < iter_max

    gf_p = gf;
    gc_p = gc;   
    
    % Calcul de la fonction objectif et des contraintes
    [f, ck] = fc(x);
    
    % Calcul du gradient de la fonction objectif et des contraintes
    [gf, gc] = Grad(fc, x);
    
    % Mise à jour de la matrice H (Hessien)
    if k > 0
        y_k = (gf + gc'*lambd) - (gf_p + gc_p'*lambd);
        H = Quasi_newton(H, d_k, y_k, "BFGS");
    else
        H = eye(n);
    end
    
    % Modification du Hessien
    H = Modif_Hessien(H);

    % Mise à jour de la direction de descente et du multiplicateur de Lagrange
    [lambd, d_k] = MAJ(H, gf, gc, ck);
    
    % Recherche linéaire pour trouver le pas optimal
    [valide, x, fcon] = Recherche_lineaire(fc, @F_merite, gf, gc, rho, d_k, x);

    % Mise à jour de rho et h_init
    if valide == 1 && h_init >= 1 
        h_init = 2;
    end
    if valide == 1 && h_init < 1
        h_init = 1;
    elseif valide == 0
        h_init = 0;
    end
    if h_init == 2
        rho = rho * 10;
        h_init = 0;
    end

    % Affichage des résultats de l'itération
    k = k + 1;
    fprintf('\n%5d %5d   %.3f,%.3f,%.3f,%.3f,%.3f       %10f        %.3f,%.3f,%.3f          %.3f,%.3f,%.3f             %2f,%2f,%2f   %2f    %2f   %2f ', k, fcon, x, f, ck, lambd, norm(gf) + norm(lambd .* gc));
    
end
end
