%% Define the problem
D = 2; % number of dimensions
shift = -100; % shift value (can be any real number)
sphere = @(x) sum((x - shift - [1,2]).^2); % Shifted Sphere Function

%% Define the Simulated Annealing parameters
N = 50; % number of particles
maxiter = 15; % maximum number of iterations
T0 = 100; % initial temperature
Tf = 1; % final temperature
alpha = 0.99; % cooling rate
lb = -100; % lower bound
ub = 100; % upper bound

%% Run the Simulated Annealing algorithm 15 times
num_runs = 15;
fval_history = zeros(num_runs, maxiter);
for run = 1:num_runs
    %% Initialize the solution
    x = lb + (ub - lb) * rand(1, D); % initial solution
    fval = sphere(x); % initial function value

    %% Run the Simulated Annealing algorithm
    T = T0; % set initial temperature
    for iter = 1:maxiter
        % Generate a new solution
        xn = x + randn(1, D) * T;
        xn(xn < lb) = lb; % apply lower bound
        xn(xn > ub) = ub; % apply upper bound
        fn = sphere(xn); % calculate the new function value

        % Accept the new solution with probability based on Metropolis criterion
        deltaf = fn - fval;
        if deltaf < 0 || rand < exp(-deltaf / T)
            x = xn;
            fval = fn;
        end

        % Decrease the temperature
        T = alpha * T;

        % Save the function value
        fval_history(run, iter) = fval;
    end
end

%% Compute the average performance and the best and worst performances
meanval = mean(fval_history, 1);
stdval = std(fval_history, 0, 1);
bestval = min(min(fval_history));
worstval = max(max(fval_history));

%% Display the results
fprintf('Simulated Annealing: Average performance = %f, Best performance = %f, Worst performance = %f\n', mean(meanval), bestval, worstval);

%% Plot the best fitness values over the iterations
figure;
errorbar(1:maxiter, meanval, stdval, 'o-', 'LineWidth', 1.5, 'Color', [0.2, 0.4, 0.8]);
xlabel('Iterations');
ylabel('Function Value');
title('Shifted Sphere Function Optimization with Simulated Annealing (15 runs) 2D');
grid on;
