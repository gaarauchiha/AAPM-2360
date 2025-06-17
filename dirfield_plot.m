a = 0.75; 
p = 1.5; 
q = 1.25; 
b_values = [0.005, 0.05, 0.1];
y_range = linspace(0, 5, 1000);

figure;
hold on;
for b = b_values
    H = @(y) (p * y.^3) ./ (y.^3 + q); 
    f = @(y) a * y - b * y.^2 - H(y);  
    plot(y_range, f(y_range), 'DisplayName', sprintf('b = %.3f', b));
end
xlabel('Population in hundreds of tribbles');
ylabel('f(y)');
title('f(y) for different values of b');
legend('show');
grid on;