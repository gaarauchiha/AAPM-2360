%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solving the Tribble Population Model with ode45
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Housekeeping
clc; clear; close all;

% ODE45 options
options = odeset('AbsTol',1e-10,'RelTol',1e-7);

a = 0;   
b = 50;  
h = 0.1;   
tt = a:h:b;

a_param = 0.75; 
p = 1.5; 
q = 1.25;
b_values = [0.005, 0.05, 0.10]; 
y0_vals = [0.5, 2, 5, 10]; 

for b_param = b_values
    figure;
    hold on;
    for y0 = y0_vals
        [t, y] = ode45(@(t, y) rhs(t, y, a_param, b_param, p, q), tt, y0, options);
        plot(t, y, 'DisplayName', ['y_0 = ', num2str(y0)]);
    end
    xlabel('t (days)', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('y (hundreds of tribbles)', 'Interpreter', 'latex', 'FontSize', 14);
    title(['Tribble Population Model (b = ', num2str(b_param), ')'], 'FontSize', 14);
    legend('show');
    grid on;
end

function dydt = rhs(t, y, a, b, p, q)
    dydt = a*y - b*y.^2 - (p*y.^3)./(y.^3 + q);
end