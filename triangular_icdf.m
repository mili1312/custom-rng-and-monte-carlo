function x = triangular_icdf(u, a, m, b)
% TRIANGULAR_ICDF Inverse CDF για τριγωνική κατανομή

    Fm = (m - a) / (b - a);

    if u < Fm
        x = a + sqrt(u * (b - a) * (m - a));
    else
        x = b - sqrt((1 - u) * (b - a) * (b - m));
    end
end

