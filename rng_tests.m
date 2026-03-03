clear; clc; close all;

N = 50000;
seed = 19008;

% Παραγωγή αριθμών
u1 = rng_lcg(seed, N);
u2 = rng_lcg(seed, N);

% A3: Έλεγχος ότι u ∈ [0,1)
ok_range = all(u1 >= 0 & u1 < 1);

% A3: Αναπαραγωγιμότητα
ok_repeat = isequal(u1, u2);

fprintf("Range test [0,1): %d\n", ok_range);
fprintf("Repeatability test: %d\n", ok_repeat);

% A4: Στατιστικά
mu = mean(u1);
v  = var(u1);

fprintf("Mean(u) = %.6f (theory 0.5)\n", mu);
fprintf("Var(u)  = %.6f (theory %.6f)\n", v, 1/12);

% A4: Histogram
figure;
histogram(u1, 50);
title("LCG Uniform(0,1) Histogram (50 bins)");
xlabel("u");
ylabel("count");

