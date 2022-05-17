function [tp,xp,yp,xdotp] = BLS_RKF45(tspan,x0,y0,params,options)

%% Handle the input options
if ~isempty(options)
    if any(strcmp(options,'dt_lim')) == 1, ind=find(strcmp(options,'dt_lim')); dt_lim = options{ind+1}; end
    if any(strcmp(options,'RKFtol')) == 1, ind=find(strcmp(options,'RKFtol')); RKFtol = options{ind+1}; end
    if any(strcmp(options,'b_max_it')) == 1, ind=find(strcmp(options,'b_max_it')); b_max_it = options{ind+1}; end
    if any(strcmp(options,'RKF_it_max')) == 1, ind=find(strcmp(options,'RKF_it_max')); RKF_it_max = options{ind+1}; end
    if any(strcmp(options,'display_progress')) == 1, ind=find(strcmp(options,'display_progress')); display_progress = options{ind+1}; end
end        

if ~exist('dt_lim','var'), dt_lim = 5e-4; end                       % Default maximum timestep
if ~exist('RKFtol','var'), RKFtol = 1e-8; end                       % Default RFK tolerance
if ~exist('b_max_it','var'), b_max_it = 10; end                     % Default maximum number of iterations on boundary
if ~exist('RKF_it_max','var'), RKF_it_max = 10; end                 % Default maximum number of iterations for RKF approximations
if ~exist('display_progress','var'), display_progress = 0; end      % Default option to display progress
    
%% Setup the algorithm
% RKF45 integration variables
c4 = [25/216 0 1408/2565 2197/4104 -1/5 0]';
c5 = [16/135 0 6656/12825 28561/56430 -9/50 2/55]';
c45 = c5-c4;
% Boundary
delta_b = -1e-16;       % Boundary tolerance
boundary = zeros(9,1);  % Initialize boundary 
% Time variables
ti = tspan(1);          % Initial time
tf = tspan(end);        % Final time
tc = ti;                % Current time
% Pre-allocate
N = length(x0);
p_ratio = 1+sqrt(tf-ti);           % Pre-allocation ratio relative to constant time step - my simple formula
s0 = round(p_ratio*(tf-ti)/dt_lim);  % Initial size of the vectors
tp = zeros(s0,1);                  % Output time vector
xp = zeros(N,s0);                  % Output states vectors
yp = zeros(length(y0),s0);         % Output "outputs" vectors
xdotp = zeros(N,s0);               % Output states rates vectors
% Set initial conditions
x_i = x0; 
% Initialize output vectors
tp(1) = ti;  
xp(:,1) = x0; 
yp(:,1) = y0;
xdot = xdotp(:,1);
% Unpack model parameters
[U,M,b,a_0,a_1,k,beta,A,B,alpha_0L,alpha1_0,alpha_ds0,alpha_min0,alpha_ss,kappa,B1,B2,c_d0,c_m0,c_n_alpha,Df,E0,f0,fb,K0,K1,K2,r0,r_dcc_da_reat,r_dcm_da_reat,r_dcn_da_reat,S1,S2,Ta,Tf0,Tr,TvL,A1,A2,A3,b1,b2,b3,T_I,T_M,lin_reat] = unpack_params_BLS(params);
% Initialize complementary variables
tv0 = 0; so_im1 = 0; so_i = 0; so_lim_im1 = 0; so_lim_i = 0; alpha_re_i = nan; cn_re_i = nan; cm_re_i = nan; cc_re_i = nan; cn_re_f = nan; cm_re_f = nan; cc_re_f = nan; tri = nan; trf = nan; theta_max = 0;

%% Solve the ODEs
i = 1;                        % Initialize time step counter
dt_new = dt_lim;              % Initialize time step with maximum allowable
% Loop over time steps
while tc < tf
    % Reset iterations counters and error
    eps = 10*RKFtol;          
    b_it = 0;                 
    RKF_it = 0; 
    % Loop until convergence is reached
    while (eps > RKFtol || any(boundary < delta_b)) 
        % Adjust for last time step
        if tc+dt_new > tf, dt_new = tf-tc; end 
        % Set newly adjusted time step
        dt = dt_new;  
        % RKF45 steps
        [k1,tv0,so_i,so_lim_i,alpha1_i,alpha_i,alpha_dot_i,r_i] = BLS_dxdt(tc,x_i,xdot,tc,tv0,so_i,so_lim_i,A,B,U,b,a_0,a_1,k,alpha1_0,S1,S2,TvL,Ta,Tf0,r0,alpha_ds0,alpha_ss,f0,fb);  
        x1 = x_i + k1*dt/4;
        [k2,tv0] = BLS_dxdt(tc+dt/4,x1,xdot,tc,tv0,so_i,so_lim_i,A,B,U,b,a_0,a_1,k,alpha1_0,S1,S2,TvL,Ta,Tf0,r0,alpha_ds0,alpha_ss,f0,fb);
        x2 = x_i + (3/32*k1+9/32*k2)*dt;
        [k3,tv0] = BLS_dxdt(tc+3/8*dt,x2,xdot,tc,tv0,so_i,so_lim_i,A,B,U,b,a_0,a_1,k,alpha1_0,S1,S2,TvL,Ta,Tf0,r0,alpha_ds0,alpha_ss,f0,fb);
        x3 = x_i + (1932*k1-7200*k2+7296*k3)/2197*dt;
        [k4,tv0] = BLS_dxdt(tc+12/13*dt,x3,xdot,tc,tv0,so_i,so_lim_i,A,B,U,b,a_0,a_1,k,alpha1_0,S1,S2,TvL,Ta,Tf0,r0,alpha_ds0,alpha_ss,f0,fb);
        x4 = x_i + (439/216*k1-8*k2+3680/513*k3-845/4104*k4)*dt;
        [k5,tv0,so_ip1,so_lim_ip1,alpha1_ip1,alpha_ip1,alpha_dot_ip1,r_ip1] = BLS_dxdt(tc+dt,x4,xdot,tc,tv0,so_i,so_lim_i,A,B,U,b,a_0,a_1,k,alpha1_0,S1,S2,TvL,Ta,Tf0,r0,alpha_ds0,alpha_ss,f0,fb);
        x5 = x_i + (-8/27*k1+2*k2-3544/2565*k3+1859/4104*k4-11/40*k5)*dt;
        [k6,tv0] = BLS_dxdt(tc+dt/2,x5,xdot,tc,tv0,so_i,so_lim_i,A,B,U,b,a_0,a_1,k,alpha1_0,S1,S2,TvL,Ta,Tf0,r0,alpha_ds0,alpha_ss,f0,fb);
        k_step = [k1, k2, k3, k4, k5, k6];
        % Update states rates 
        xdot = k_step*c5;
        % Update states vector
        x_ip1 = x_i + xdot*dt;
        % Update maximum of theta
        theta_max = theta_max_BLS(r_i,so_im1,so_i,so_ip1,so_lim_im1,so_lim_i,so_lim_ip1,theta_max);
        % Error between 5th and 4th order RKF approximations   
        eps = norm(k_step*c45)*dt;  
        % Boundary crossing
        boundary = BLS_boundaries(boundary,tc+dt,tc,x_ip1(8),x_i(8),tv0,so_i,so_lim_i,alpha1_i,alpha_i,alpha_dot_i,r_i,so_ip1,so_lim_ip1,alpha1_ip1,alpha_ip1,alpha_dot_ip1,r_ip1,alpha1_0,TvL,r0,fb); 
        % Check boundary crossing tolerance
        if any(boundary < delta_b) 
            % Check for maximum theta at begin of downstroke as well - Stalled conditions are garanteed even though the actual maximum theta has not been reached yet
            if boundary(6) < delta_b && abs(so_ip1/so_lim_ip1) > 1 
                theta_max = so_ip1/so_lim_ip1;
            end
            b_it = b_it+1;
            % If maximum number of boundary iterations is reached, break the loop
            if b_it == b_max_it, break; end
        % Check RKF steps tolerance    
        elseif eps > RKFtol
            RKF_it = RKF_it+1;  
            % If maximum number of RKF iterations is reached, break the loop
            if RKF_it == RKF_it_max, break; end
        end
        % Adjust time step
        delta = min([4, (eps/RKFtol)^(-1/5)]);
        dt_new = delta*dt;
        if dt_new > dt_lim, dt_new = dt_lim; end
    end
    % Update output vectors
    tp(i+1) = tc+dt;      
    xp(:,i+1) = x_ip1;
    xdotp(:,i) = xdot;
    [y,alpha_re_i,cn_re_i,cm_re_i,cc_re_i,cn_re_f,cm_re_f,cc_re_f,tri,trf] = BLS_outputs(tc,x_i,tv0,U,b,beta,k,a_0,a_1,M,K0,K1,K2,kappa,T_I,T_M,b1,b2,b3,A1,A2,A3,E0,Df,c_m0,c_n_alpha,TvL,r0,alpha_ds0,alpha_ss,alpha1_0,S1,S2,Tf0,f0,fb,B1,B2,alpha_0L,c_d0,alpha_min0,Tr,r_dcn_da_reat,r_dcm_da_reat,r_dcc_da_reat,alpha_re_i,cn_re_i,cm_re_i,cc_re_i,cn_re_f,cm_re_f,cc_re_f,tri,trf,theta_max,lin_reat);
    yp(:,i) = y;
    % Setup next time step
    tc = tc+dt;
    x_i = x_ip1;
    so_im1 = so_i;
    so_lim_im1 = so_lim_i;
    i = i+1;
    if rem(i,1e4) == 0 && display_progress
        disp(['RKF45 progress: ',num2str((tc-ti)/(tf-ti)*100,'%10.2f') '%'])
    end
end

% Assume last time step derivatives and outputs equal to previous
xdotp(:,i) = xdotp(:,i-1);
yp(:,i) = yp(:,i-1);

% Truncate pre-allocated vectors
tp = tp(1:i); xp = xp(:,1:i); yp = yp(:,1:i); xdotp = xdotp(:,1:i);

end