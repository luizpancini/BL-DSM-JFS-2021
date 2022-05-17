function [authors,data,params,tspan,tf,t_cycle,n_cycles,n_discard,N,x0,y0,ODE_options] = initialize_BL_model(INPUT,model,lin_reat)

%% Read reference data from input
[authors,data,params] = read_data(INPUT,model);            

%% Time variables
dt_lim = 1e-4;                                  % Maximum time step (notice that the NMRS errors are slightly dependent on the time step)
n_discard = 2;                                  % Number of cycles to discard for plots
n_cycles = n_discard+1;                         % Number of cycles to run
t_cycle = 2*pi*params.b/(params.U*params.k);    % Time of one cycle
tf = t_cycle*n_cycles;                          % Test time
tspan = [0 tf];                                 % Time span

%% Get indicial parameters
params = read_indicial_params(params,model);

%% Get state space matrices
params = get_SS_matrices(params,model);

%% Set linearized reattachment option for Sheng's model
if model == "BLS"
    params.lin_reat = lin_reat;
end

%% Initialize to get consistent set of initial states 
% Set ODEs solver options
ODE_options = {'dt_lim',dt_lim};
% Solve ODEs for one cycle
switch model
    case "BL"
        N = 14;                 % Number of states
        x0 = zeros(N,1);
        y0 = nan(35,1);
        [~,x] = BL_RKF45([0; t_cycle],x0,y0,params,ODE_options);
        x0 = x(:,end);
    case "BLS"
        N = 9;                  % Number of states
        x0 = zeros(N,1);
        y0 = nan(20,1);
        [~,x] = BLS_RKF45([0; t_cycle],x0,y0,params,ODE_options);
        x0 = x(:,end);
end

end