function params = get_SS_matrices(params,model)

%% State-space matrices for each model
switch model
    case "BL"
        % Unpack
        U = params.U;
        b = params.b;
        beta = params.beta;
        b1 = params.b1;
        b2 = params.b2;
        b3 = params.b3;
        b4 = params.b4;
        b5 = params.b5;
        K_a = params.K_a;
        K_q = params.K_q;
        K_aM = params.K_aM;
        K_qM = params.K_qM;
        T_I = params.T_I;
        % System matrix (diagonal only)
        params.A = [-U/b*beta^2*b1; -U/b*beta^2*b2; -1/(K_a*T_I); -1/(K_q*T_I); -1/(b3*K_aM*T_I); -1/(b4*K_aM*T_I); -b5*U/b*beta^2; -1/(K_qM*T_I)];
        % Input matrix
        params.B = [1 1/2; 1 1/2; 1 0; 0 1; 1 0; 1 0; 0 1; 0 1];
    case "BLS"
        % Unpack
        U = params.U;
        b = params.b;
        b1 = params.b1;
        b2 = params.b2;
        b3 = params.b3;
        T_I = params.T_I;
        T_M = params.T_M;
        % System matrix (diagonal only)
        params.A = -U/b*[b1; b2; b3; 1/T_I; 1*T_M; 1/T_I];
        % Input matrix
        params.B = [1 1/2; 1 1/2; 1 1/2; 1 1/4; 0 1/2; 1/2 7/24];
end

end