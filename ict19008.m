%% ict19008.m - Τελική άσκηση εργαστηρίου ΠΑΣ
% AEM: 19008  (V=1, W=9, X=0, Y=0, Z=8)


clear; clc; close all;

%% ===================== ΜΕΡΟΣ Α: Έλεγχοι LCG =====================
Ntest = 50000;
seed_test = 19008;

u_test1 = rng_lcg(seed_test, Ntest);
u_test2 = rng_lcg(seed_test, Ntest);

ok_range  = all(u_test1 >= 0 & u_test1 < 1);
ok_repeat = isequal(u_test1, u_test2);

mu_u = mean(u_test1);
var_u = var(u_test1);

fprintf("=== LCG TESTS ===\n");
fprintf("Range test [0,1): %d\n", ok_range);
fprintf("Repeatability test: %d\n", ok_repeat);
fprintf("Mean(u) = %.6f (theory 0.5)\n", mu_u);
fprintf("Var(u)  = %.6f (theory %.6f)\n\n", var_u, 1/12);

figure;
histogram(u_test1, 50);
title("LCG Uniform(0,1) Histogram (50 bins)");
xlabel("u"); ylabel("count");

%% ===================== ΜΕΡΟΣ Β: Τριγωνική =====================
Ntri = 1000;
u_tri = rng_lcg(19008, Ntri);
x_tri = zeros(Ntri,1);

for i = 1:Ntri
    x_tri(i) = triangular_icdf(u_tri(i), 12, 16, 22);
end

figure;
histogram(x_tri, 30);
title("Triangular Distribution (12,16,22)");
xlabel("x"); ylabel("count");

%% ===================== ΜΕΡΟΣ Γ: Monte Carlo =====================

p = 40;      % €/τεμ
s = 13;      % €/τεμ
F = 80000;   % €
Q = 6000;    % τεμ


c_a = 12; c_m = 16; c_b = 22;


Mmin = 20000; Mmax = 45000;


Dmu = 5500;
Ds  = 1400;

Nsim = 50000;                 
seed0 = 19008;

profit = zeros(Nsim,1);


U = rng_lcg(seed0, 8*Nsim);
idx = 1;

fprintf("=== MONTE CARLO START (N=%d) ===\n", Nsim);

for k = 1:Nsim
   
    u_c = U(idx); idx = idx + 1;
    c = triangular_icdf(u_c, c_a, c_m, c_b);

  
    u_M = U(idx); idx = idx + 1;
    M = Mmin + u_M*(Mmax - Mmin);

  
    D = -1;
    while D < 0
        u1 = U(idx); u2 = U(idx+1); idx = idx + 2;
        if u1 == 0, u1 = realmin; end
        Z = sqrt(-2*log(u1)) * cos(2*pi*u2);
        D = Dmu + Ds*Z;
    end
    D = round(D);

    
    Ssales = min(Q, D);
    Unsold = max(Q - D, 0);

    
    profit(k) = p*Ssales + s*Unsold - c*Q - F - M;

    
    if idx > length(U)-10
        seed0 = seed0 + 12345;
        U = rng_lcg(seed0, 8*Nsim);
        idx = 1;
    end
end

fprintf("=== MONTE CARLO DONE ===\n");


meanP = mean(profit);
stdP  = std(profit);
probLoss = mean(profit < 0);                 
p05 = prctile(profit, 5);                    
p50 = prctile(profit, 50);                   
p95 = prctile(profit, 95);

fprintf("E[Profit]      = %.2f €\n", meanP);
fprintf("Std(Profit)    = %.2f €\n", stdP);
fprintf("P(Profit < 0)  = %.4f\n", probLoss);
fprintf("Profit P5/P50/P95 = %.2f / %.2f / %.2f €\n", p05, p50, p95);

figure;
histogram(profit, 60);
title("Profit Histogram (Monte Carlo)");
xlabel("Profit (€)");
ylabel("count");

%% ===================== ΣΥΝΑΡΤΗΣΕΙΣ =====================

function u = rng_lcg(seed, N)

    m = uint64(2^32);
    a = uint64(19);
    c = uint64(0);

    x = uint64(seed);
    u = zeros(N,1);

    for i = 1:N
        x = mod(a*x + c, m);
        u(i) = double(x) / double(m);
    end
end

function x = triangular_icdf(u, a, m, b)

    Fm = (m - a) / (b - a);
    if u < Fm
        x = a + sqrt(u * (b - a) * (m - a));
    else
        x = b - sqrt((1 - u) * (b - a) * (b - m));
    end
end
