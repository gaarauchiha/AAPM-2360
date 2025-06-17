a = 0.75; p = 1.5; q = 1.25;
b_values = [0.005, 0.05, 0.1];
T = 10*365;
t_span = [0, T];

H_seasonal = @(t, y) (p * y.^3) ./ (q + y.^3) .* abs(sin(pi * t / 365));

figure;
hold on;
for i = 1:length(b_values)
    b = b_values(i);
    f_seasonal = @(t, y) a * y - b * y.^2 - H_seasonal(t, y);
    
    for y0 = [10, 50, 100, 140]
        [t, y] = ode45(f_seasonal, t_span, y0);
        plot(t, y, 'DisplayName', sprintf('b=%.3f, y0=%.1f', b, y0));
    end
end
xlabel('Time (days)');
ylabel('Population (hundreds of tribbles)');
title('Population Dynamics with Seasonal Hunting');
legend('show');
grid on;