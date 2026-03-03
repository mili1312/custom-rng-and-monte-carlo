clear; clc; close all;

N = 1000;
seed = 19008;

u = rng_lcg(seed, N);
x = zeros(N,1);

for i = 1:N
    x(i) = triangular_icdf(u(i), 12, 16, 22);
end

figure;
histogram(x, 30);
title("Triangular Distribution (12,16,22)");
xlabel("x");
ylabel("count");

