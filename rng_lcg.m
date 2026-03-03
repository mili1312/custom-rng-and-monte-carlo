
function u = rng_lcg(seed, N)
% Linear Congruential Generator
% AEM = 19008 → a=19, c=0, m=2^32

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


