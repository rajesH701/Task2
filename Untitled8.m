% Define the Shifted Rosenbrock's function
rosenbrock = @(x) sum(100*(x(2:end) - x(1:end-1).^2).^2 + (1 - x(1:end-1)).^2);

% Define the dimensionality of the problem
dim = 10;

% Define the number of runs for each optimizer
num_runs = 15;

% Define the upper and lower bounds for each variable
lb = -100 * ones(1,dim);
ub = 100 * ones(1,dim);

% Define the options for the simulated annealing optimizer
options = saoptimset('Display', 'off');

% Initialize the arrays to store the results
sa_results = zeros(num_runs, 3);

% Run the optimizer for each run and store the results
for i = 1:num_runs
    % Generate a random starting point for the optimizer
    x0 = lb + rand(1,dim) .* (ub-lb);

    % Run the simulated annealing optimizer
    [x, fval] = simulannealbnd(rosenbrock, x0, lb, ub, options);

    % Store the results
    sa_results(i,:) = [fval, rosenbrock(x), i];
end

% Calculate the average and standard deviation of the results
sa_avg = mean(sa_results(:,1:2));
sa_std = std(sa_results(:,1:2));

% Find the best and worst results
sa_best = min(sa_results(:,1:2));
sa_worst = max(sa_results(:,1:2));

% Plot the results
figure;
errorbar(sa_results(:,3), sa_results(:,2), sa_std(2)*ones(num_runs,1), 'b.');
hold on;
plot(sa_results(:,3), sa_results(:,1), 'r.');
xlabel('Iterations');
ylabel('Function Value');
title('Shifted Rosenbrock''s Function Optimization with Simulated Annealing 10D');
legend('Average Result', 'Best Result');
