%% Define the problem
D = 10; % number of dimensions
shift = -100; % shift value (can be any real number)
sphere = @(x) sum((x - shift - [1,2,3,4,5,6,7,8,9,10]).^2); % Shifted Sphere Function

%% Define the Simulated Annealing parameters
Tmax = 100; % maximum temperature
Tmin = 1e-8; % minimum temperature
alpha = 0.995; % cooling rate
maxiter = 15; % maximum number of iterations
N = 50; % number of trials at each temperature
nruns = 15; % number of runs

%% Initialize the history
fhistory = zeros(maxiter, nruns);

%% Run the Simulated Annealing algorithm nruns times
for r = 1:nruns
    %% Initialize the current state
    x = -100 + 200 * rand(1, D);

    %% Initialize the best state
    xbest = x;
    fbest = sphere(xbest);

    %% Initialize the temperature
    T = Tmax;

    %% Run the Simulated Annealing algorithm
    for iter = 1:maxiter
        % Perform N trials at the current temperature
        for i = 1:N
            % Generate a trial point
            xtrial = x + randn(1, D);

            % Apply the boundary conditions
            xtrial(xtrial < -100) = -100;
            xtrial(xtrial > 100) = 100;

            % Evaluate the trial point
            ftrial = sphere(xtrial);

            % Compute the acceptance probability
            deltaf = ftrial - fbest;
            if deltaf < 0
                accept = true;
            else
                p = exp(-deltaf / T);
                accept = rand() < p;
            end

            % Update the current state and the best state
            if accept
                x = xtrial;
                f = ftrial;
                if f < fbest
                    xbest = x;
                    fbest = f;
                end
            end
        end

        % Update the temperature
        T = alpha * T;

        % Save the history
        fhistory(iter, r) = fbest;

        % Display the iteration and the best fitness value
        fprintf('Run %d, Iteration %d: Best fitness value = %f\n', r, iter, fbest);
    end
end

%% Compute the statistics
meanval = mean(fhistory, 2);
stdval = std(fhistory, 0, 2);
bestval = min(fhistory, [], 1);
worstval = max(fhistory, [], 1);

%% Display the results
fprintf('Average best fitness value over %d runs = %f\n', nruns, mean(bestval));
fprintf('Standard deviation of best fitness value over %d runs = %f\n', nruns, std(bestval));
fprintf('Best fitness value over %d runs = %f\n', nruns, min(bestval));
fprintf('Worst fitness value over %d runs = %f\n', nruns, max(worstval));

%% Plot the best fitness values over the iterations
figure;
errorbar(1:maxiter, meanval, stdval, 'o-', 'LineWidth', 1.5, 'Color', [0.2, 0.4, 0.8]);
xlabel('Iterations');
ylabel('Function Value');

title('Shifted Sphere Function Optimization with Simulated Annealing 10D');
grid on;
