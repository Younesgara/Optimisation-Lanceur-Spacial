%initialisation:

Vc = 11527;
k = [0.1101; 0.1532; 0.2154];       % Coefficients pour chaque étage
Ve = [2647.2; 2922.4; 4344.3];      % Vitesses caractéristiques pour chaque étage
mu = 1700;      % Masse de la charge utile


% Fonction pour le système d'équations à résoudre
newton_x = @(X) newton(X, k, Ve, Vc);

% Paramètres pour la méthode de Newton
Kmax = 20;
X = 2.5;
epsilon = 0.00001;
k_iter = 0;
gX1 = 1;
a = 1;
% Boucle de la méthode de Newton
while (abs(gX1) > epsilon) && (k_iter < Kmax)
    
    % Calcul du gradient au point courant
    [gX, in1, in2] = newton_x(X);
    
    % Vérification des contraintes
    if (in1 <= 0) || (in2 <= 0)
        X = 2.5;
        [gX, ~, ~] = newton_x(X);
    end
    
    % Mise à jour de la position avec la méthode de Newton
    X1 = X - gX / a;
    
    % Calcul du gradient à la nouvelle position
    [gX1, in1, in2] = newton_x(X1);
    
    % Vérification des contraintes
    if (in1 <= 0) || (in2 <= 0)
        X1 = 2.6;
        [gX1, ~, ~] = newton_x(X1);
    end
    
    % Mise à jour du pas pour la prochaine itération
    a = (gX - gX1) / (X - X1);
    
    % Mise à jour des itérations
    k_iter = k_iter + 1;
    X = X1;

end

% Résultat final
[~, x(1), x(2)] = newton_x(X);
x(3) = X;

% Initialisation du vecteur des masses
M = ones(4, 1);
M(4) = mu;

% Calcul des masses pour chaque étage
for j = [3, 2, 1]
    M(j) = M(j + 1) / ((k(j) + 1) / x(j) - k(j));
end

M = M(1:3);
me = ones(3, 1);

% Calcul des masses d'ergol pour chaque étage
for j = 1:3
    me(j) = M(j) * (1 - (k(j) + 1) / x(j) + k(j)) / (1 + k(j));
end

% Affichage des résultats
fprintf('les masses avec la secante: [%.3f, %.3f, %.3f] \n\n', me);
