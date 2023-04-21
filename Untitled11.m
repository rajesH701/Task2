% Define the Shifted Rosenbrock's function
rosenbrock = @(x) sum(100*(x(2:end) - x(1:end-1).^2).^2 + (1 - x(1:end-1)).^2);

% Define the dimensionality of the problem
dim = 10;

% Define the number of runs for each optimizer
num_runs = 15;

% Define the upper and lower bounds for each variable
lb = -100 * ones(1,dim);
ub = 100 * ones(1,dim);

% Define the options for the particle swarm optimizer
options = optimoptions('particleswarm', 'Display', 'off');

% Initialize the arrays to store the results
ps_best_vals = zeros(num_runs,1);
ps_best_sols = zeros(num_runs,dim);
ps_avg_vals = zeros(num_runs,1);

for i=1:num_runs
    % Run the Particle Swarm optimizer
    [x,fval] = particleswarm(rosenbrock, dim, lb, ub, options);
    
    % Store the best solution and value
    [ps_best_vals(i), idx] = min(fval);
    ps_best_sols(i,:) = x(idx,:);
    
    % Store the average value
    ps_avg_vals(i) = mean(fval);
end

% Plot the convergence graph
figure;
plot(ps_avg_vals, 'b');
hold on;
plot(ps_best_vals, 'r');
xlabel('Iterations');
ylabel('Function Value');
legend('Average Value', 'Best Value');
title('Particle Swarm Optimization on Shifted Rosenbrock Function in 10D');
