function[R_init , V_init , M_init] = simulateur(theta_init , theta1, M_init)
    % Déclaration de variables globales
    global R_t mu C_x H rho_init alpha theta E_i Me_j T_j Vej q

    % Paramètres spécifiques au simulateur
    alpha = [15 , 10 , 10];
    Vej = [2600 , 3000 , 4400];
    k = [0.1101 , 0.1532 , 0.2154];

    % Initialisation des variables globales
    theta = theta1;
    Me_j = [145349 , 31215 , 7933];
    mu = 3.986*1e14;
    C_x = 0.1;
    H = 7000;
    rho_init = 1.225;
    R_t = 6378137;

    % Initialisation des conditions initiales
    t0 = 0;
    R_init = [R_t ;0];
    V_init = 100*[cos(theta_init) ; sin(theta_init)];

    % Boucle pour chaque étape de propulsion
    for E_i = 1:3
        T_j = alpha(E_i)*M_init;
        q = alpha(E_i)*M_init /Vej(E_i);
        td = Me_j(E_i)/q;
        t1 = t0 + td;
        tspan = [t0,t1];

        % Résolution des équations différentielles avec ode45
        [t,solution] = ode45(@equation,tspan,[R_init(1) , R_init(2) , V_init(1), V_init(2) ,M_init]);
        N=length(solution(:,1));
        
        % Mise à jour des conditions initiales pour la prochaine étape
        R_init(1) = solution(N,1);
        R_init(2) = solution(N,2);
        V_init(1) = solution(N,3);
        V_init(2) = solution(N,4);
        M_init = solution(N,5) - k(E_i)*Me_j(E_i);
        t0 = t1;

        % Calcul de la position et de la vitesse pour chaque instant
        pos = zeros(N,1);
        vitesse = zeros(N,1);
        for j=1:N
            pos(j) = norm([solution(j,2) solution(j,1)]);
            vitesse(j) = norm([solution(j,4) solution(j,3)]);
        end
        
        % Affichage des résultats pour chaque étape
        subplot(2,2,1)
        hold on 
        plot(solution(:,2),solution(:,1));
        title("Trajectoire");

        subplot(2,2,2)
        hold on
        plot(pos-R_t,t);
        title("Altitude");

        subplot(2,2,3)
        hold on
        plot(t,vitesse)
        title("Vitesse")

        subplot(2,2,4)
        hold on
        plot(t, solution(:,5)  , 'DisplayName', sprintf('Stage %d', E_i));
        title("Masse")

    end
end
