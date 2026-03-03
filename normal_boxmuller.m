function Z = normal_boxmuller(u1, u2)

%NORMAL_BOXMULLER Παράγει Z ~ N(0,1) από Uniform(0,1)

    if u1 == 0
        u1 = realmin; % αποφυγή log(0)
    end

    Z = sqrt(-2*log(u1)) * cos(2*pi*u2);
end

