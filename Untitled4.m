%% Define the problem
D = 10; % number of dimensions
shift = -100; % shift value (can be any real number)
sphere = @(x) sum((x - shift - ones(1,D)).^2); % Shifted Sphere Function

%% Define the PSO parameters
N = 50; % number of particles
maxiter = 15; % maximum number of iterations
w = 0.72; % inertia weight
c1 = 1.49; % cognitive parameter
c2 = 1.49; % social parameter
lb = -100; % lower bound
ub = 100; % upper bound

%% Initialize the history variables
gbestval_history = zeros(15, maxiter);

%% Run the PSO algorithm 15 times
for run = 1:15
    %% Initialize the particles and the velocity
    x = lb + (ub - lb) * rand(N, D); % particles
    v = zeros(N, D); % velocity

    %% Initialize the personal best and the global best
    pbest = x; % personal best
    gbest = x(1, :); % global best
    pbestval = sphere(pbest); % personal best value
    gbestval = sphere(gbest); % global best value

    %% Run the PSO algorithm
    for iter = 1:maxiter
        % Update the velocity and the position
        r1 = rand(N, D);
        r2 = rand(N, D);
        v = w * v + c1 * r1 .* (pbest - x) + c2 * r2 .* (gbest - x);
        x = x + v;

        % Apply the boundary conditions
        x(x < lb) = lb;
        x(x > ub) = ub;

        % Update the personal best and the global best
        xval = sphere(x);
        ind = xval < pbestval;
        pbest(ind, :) = x(ind, :);
        pbestval(ind) = xval(ind);
        [~, ind] = min(pbestval);
        gbest = pbest(ind, :);
        gbestval = pbestval(ind);

        % Store the global best value at this iteration
        gbestval_history(run, iter) = gbestval;

        % Display the iteration and the best fitness value
        fprintf('Run %d Iteration %d: Best fitness value = %f\n', run, iter, gbestval);
    end
end

%% Calculate the average, standard deviation, best and worst performance
avg_gbestval = mean(gbestval_history(:, end));
std_gbestval = std(gbestval_history(:, end));
best_gbestval = min(gbestval_history(:, end));
worst_gbestval = max(gbestval_history(:, end));

%% Display the results
fprintf('Average performance over 15 runs: %f\n', avg_gbestval);
fprintf('Standard deviation over 15 runs: %f\n', std_gbestval);
fprintf('Best performance among 15 runs: %f\n', best_gbestval);
fprintf('Worst performance among 15 runs: %f\n', worst_gbestval);


% Plot the convergence curve
figure;
plot(gbestval_history');
title('Convergence Curve for Shifted Sphere Function 10D');
xlabel('Iteration');
ylabel('Global Best Value');

