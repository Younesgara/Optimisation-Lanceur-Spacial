theta = [20, 20, 20] * pi/180;  % Angles pour chaque étape de propulsion en radians
theta_init = 5 * pi/180;  % Angle initial en radians
simulateur(theta_init, theta, 207611);  % Appel à la fonction simulateur avec les paramètres spécifiés
