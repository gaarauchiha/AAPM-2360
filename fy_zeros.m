% Parameters
a = 0.75;                  % Growth rate (day^-1)
p = 1.5;                   % Hunting effectiveness
q = 1.25;                  % Hunting saturation
b_values = [0.005, 0.05, 0.1]; % Competition coefficients

% Define the function f(y)
H = @(y) (p * y.^3) ./ (y.^3 + q); % Hunting term
f = @(y, b) a * y - b * y.^2 - H(y); % Population dynamics equation

% Compute and print roots for each value of b
for i = 1:length(b_values)
    b = b_values(i);
    
    % Find roots using fzero with multiple initial guesses
    fprintf('Roots for b = %.3f:\n', b);
    
    % Define a range of initial guesses for roots
    initial_guesses = [0.1, 1,2,5,10, 100, 150]; % Adjust based on population range
    found_roots = [];
    
    for j = 1:length(initial_guesses)
        try
            % Use fzero to find a root near the initial guess
            root = fzero(@(y) f(y, b), initial_guesses(j));
            
            % Check if the root is already found (avoid duplicates)
            if ~ismembertol(root, found_roots, 1e-6) % Tolerance to avoid duplicates
                found_roots = [found_roots, root];
                fprintf('  Root: %.6f\n', root);
            end
        catch
            % Handle cases where fzero fails to converge
            fprintf('  No root found near initial guess %.2f\n', initial_guesses(j));
        end
    end
    
    fprintf('\n');
end