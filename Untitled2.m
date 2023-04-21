%% Define the problem
D = 2; % number of dimensions
shift = -100; % shift value (can be any real number)
sphere = @(x) sum((x - shift - [1,2]).^2); % Shifted Sphere Function

%% Define the PSO parameters
N = 50; % number of particles
maxiter = 15; % maximum number of iterations
w = 0.72; % inertia weight
c1 = 1.49; % cognitive parameter
c2 = 1.49; % social parameter
lb = -100; % lower bound
ub = 100; % upper bound

%% Initialize the particles and the velocity
x = lb + (ub - lb) * rand(N, D); % particles
v = zeros(N, D); % velocity

%% Initialize the personal best and the global best
pbest = x; % personal best
gbest = x(1, :); % global best
pbestval = sphere(pbest); % personal best value
gbestval = sphere(gbest); % global best value

%% Initialize the history of best fitness values
gbestval_history = zeros(1, maxiter);
gbestval_history(1) = gbestval;

%% Run the PSO algorithm
for iter = 2:maxiter % start from the second iteration
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
    
    % Update the history of best fitness values
    gbestval_history(iter) = gbestval;
    
    % Display the iteration and the best fitness value
    fprintf('Iteration %d: Best fitness value = %f\n', iter, gbestval);
end

%% Plot the best fitness values over the iterations
figure;
plot(1:maxiter, gbestval*ones(1,maxiter), '--', 'LineWidth', 1.5, 'Color', [0.8, 0.2, 0.2]);
hold on;
plot(1:maxiter, gbestval_history, '-o', 'LineWidth', 1.5, 'Color', [0.2, 0.4, 0.8]);
xlabel('Iterations');
ylabel('Function Value');
legend('Best Fitness Value', 'PSO Algorithm');
title('Shifted Sphere Function Optimization with PSO 2D');
grid on;
