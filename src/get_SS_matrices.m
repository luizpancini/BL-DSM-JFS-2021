function params = get_SS_matrices(params)

% Unpack
U = params.U;
b = params.b;
beta = params.beta;

% System matrix (diagonal only)
params.A = [-U/b*beta^2*params.b1; -U/b*beta^2*params.b2; -1/(params.K_a*params.T_I); -1/(params.K_q*params.T_I); -1/(params.b3*params.K_aM*params.T_I); -1/(params.b4*params.K_aM*params.T_I); -params.b5*U/b*beta^2; -1/(params.K_qM*params.T_I)];

% Input matrix
params.B = [1 1/2; 1 1/2; 1 0; 0 1; 1 0; 1 0; 0 1; 0 1];

end