function D = equation(t, valeur)
    % Déclaration de variables globales
    %mu  : constante gravitationelle
    %R_t :Rayon terestre
    %C_x : coeficient de trainé du lanceur
    % H : facteur d'echelle
    %rho_init : densité atmospherique a la surface
    %alpha :acceleration necessaire pour l'alumage de chaque etage
    %theta : 
    %E_i :etage 
    %Me_j : masse d'ergole pour chaque etage
    %T_j :poussée de l'etage
    %Vej : vitesse d'ejection des etages 
    %q : debit massique de l'etage j




    global R_t mu C_x H rho_init alpha theta E_i Me_j T_j Vej q

    % Extraction des composantes du vecteur 'valeur'
    R = [valeur(1); valeur(2)];
    V = [valeur(3); valeur(4)];
    M = valeur(5);

    % Calcul de la densité atmosphérique en fonction de la position
    rho = rho_init * exp(-(norm(R) - R_t) / H);

    % Calcul de la force de traînée
    D = -C_x * rho * norm(V) * V;

    % Calcul de la force gravitationnelle
    W = -(mu * M / norm(R)^3) * R;

    % Calcul d'un vecteur perpendiculaire à la position
    R1 = [-R(2); R(1)];

    % Calcul de l'angle entre les vecteurs position et vitesse
    gamma = asin((R' * V) / (norm(R) * norm(V)));

    % Calcul du vecteur U Direction de pousées
    U = (1 / norm(R)) * R * cos(gamma + theta(E_i)) + (1 / norm(R)) * R1 * sin(gamma + theta(E_i));

    % Calcul de la force de poussée
    T = T_j * U;

    % Calcul des dérivées par rapport à chaque composante
    val_R = [V(1); V(2)];
    val_V = [(T(1) + W(1) + D(1)) / M; (T(2) + W(2) + D(2)) / M];
    val_M = -q;

    % Rassemblement des dérivées dans un vecteur D
    D = [val_R; val_V; val_M];
end
