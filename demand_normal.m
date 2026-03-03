function D = demand_normal(seed)
%DEMAND_NORMAL Παράγει ζήτηση D ~ N(5500,1400) με rejection αν D<0
% Χρησιμοποιεί την LCG για Uniform και Box-Muller για κανονική.

    mu = 5500;
    sigma = 1400;

    while true
        u = rng_lcg(seed, 2);   % παίρνουμε 2 uniform
        seed = seed + 1;        % μικρή αλλαγή seed για επόμενο draw

        Z = normal_boxmuller(u(1), u(2));
        D = mu + sigma * Z;

        if D >= 0
            D = round(D);       % προαιρετικό: κοντινότερος ακέραιος
            return;
        end
    end
end
