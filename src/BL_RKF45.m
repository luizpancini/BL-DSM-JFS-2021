function [tp,xp,yp,xdotp] = BL_RKF45(tspan,x0,y0,params,options)

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
[U,M,b,a_0,a_1,k,beta,A,B,alpha_0L,alpha_ds0,alpha_ss,gamma_LS,gamma_TvL,delta_alpha_0,delta_alpha_1,kappa,nu_1,nu_2,c_d0,c_m0,c_n_alpha,d_cc,d_cm,df0_c,E0,E1,f0,fb,fS2_c_down,fS2_c_up,fS2_n,fSig_1n,fSig2_n,fSS,g_v,K0,K1,K2,K3,r0,S1,S2,Ta,Tf0,TvL,Vm,Vn1,Vn2,x_ac,z_cc,z_cm,A1,A2,A3,A4,b1,b2,b3,b4,b5,K_a,K_aM,K_q,K_qM,T_I] = unpack_params(params);
% Initialize complementary variables
tv0 = 0; so_im1 = 0; so_lim_im1 = 1; so_i = 0; so_lim_i = 1; RD_tv0 = 0; f_diff_tv0 = 0; TvL_tv0 = -1e4; theta_tv0 = 0; RD_tv0_2 = 1; f_diff_tv0_2 = 0; TvL_tv0_2 = -1e4; theta_min = 0; theta_max = 1; RD_m = 1; V2F = 0;

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
        [k1,tv0,so_i,so_lim_i,alpha1n_i,alpha1m_i,alpha1c_i,alpha_i,q_i] = BL_dxdt(tc,x_i,xdot,tc,tv0,RD_tv0,f_diff_tv0,TvL_tv0,theta_tv0,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,V2F,so_i,so_lim_i,A,B,U,b,a_0,a_1,k,S1,S2,TvL,Ta,Tf0,r0,alpha_ds0,alpha_ss,f0,fb,delta_alpha_0,delta_alpha_1,d_cm,d_cc,z_cm,z_cc,gamma_LS,g_v,df0_c,fSS,fSig_1n,fSig2_n,fS2_n,fS2_c_up,fS2_c_down,gamma_TvL,theta_max,theta_min,RD_m); 
        x1 = x_i + k1*dt/4;
        [k2,tv0] = BL_dxdt(tc+dt/4,x1,xdot,tc,tv0,RD_tv0,f_diff_tv0,TvL_tv0,theta_tv0,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,V2F,so_i,so_lim_i,A,B,U,b,a_0,a_1,k,S1,S2,TvL,Ta,Tf0,r0,alpha_ds0,alpha_ss,f0,fb,delta_alpha_0,delta_alpha_1,d_cm,d_cc,z_cm,z_cc,gamma_LS,g_v,df0_c,fSS,fSig_1n,fSig2_n,fS2_n,fS2_c_up,fS2_c_down,gamma_TvL,theta_max,theta_min,RD_m);
        x2 = x_i + (3/32*k1+9/32*k2)*dt;
        [k3,tv0] = BL_dxdt(tc+3/8*dt,x2,xdot,tc,tv0,RD_tv0,f_diff_tv0,TvL_tv0,theta_tv0,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,V2F,so_i,so_lim_i,A,B,U,b,a_0,a_1,k,S1,S2,TvL,Ta,Tf0,r0,alpha_ds0,alpha_ss,f0,fb,delta_alpha_0,delta_alpha_1,d_cm,d_cc,z_cm,z_cc,gamma_LS,g_v,df0_c,fSS,fSig_1n,fSig2_n,fS2_n,fS2_c_up,fS2_c_down,gamma_TvL,theta_max,theta_min,RD_m);
        x3 = x_i + (1932*k1-7200*k2+7296*k3)/2197*dt;
        [k4,tv0] = BL_dxdt(tc+12/13*dt,x3,xdot,tc,tv0,RD_tv0,f_diff_tv0,TvL_tv0,theta_tv0,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,V2F,so_i,so_lim_i,A,B,U,b,a_0,a_1,k,S1,S2,TvL,Ta,Tf0,r0,alpha_ds0,alpha_ss,f0,fb,delta_alpha_0,delta_alpha_1,d_cm,d_cc,z_cm,z_cc,gamma_LS,g_v,df0_c,fSS,fSig_1n,fSig2_n,fS2_n,fS2_c_up,fS2_c_down,gamma_TvL,theta_max,theta_min,RD_m);
        x4 = x_i + (439/216*k1-8*k2+3680/513*k3-845/4104*k4)*dt;
        [k5,tv0,so_ip1,so_lim_ip1,alpha1n_ip1,alpha1m_ip1,alpha1c_ip1,alpha_ip1,q_ip1,RD_tv0,f_diff_tv0,TvL_tv0,theta_tv0,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,V2F] = BL_dxdt(tc+dt,x4,xdot,tc,tv0,RD_tv0,f_diff_tv0,TvL_tv0,theta_tv0,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,V2F,so_i,so_lim_i,A,B,U,b,a_0,a_1,k,S1,S2,TvL,Ta,Tf0,r0,alpha_ds0,alpha_ss,f0,fb,delta_alpha_0,delta_alpha_1,d_cm,d_cc,z_cm,z_cc,gamma_LS,g_v,df0_c,fSS,fSig_1n,fSig2_n,fS2_n,fS2_c_up,fS2_c_down,gamma_TvL,theta_max,theta_min,RD_m);
        x5 = x_i + (-8/27*k1+2*k2-3544/2565*k3+1859/4104*k4-11/40*k5)*dt;
        [k6,tv0] = BL_dxdt(tc+dt/2,x5,xdot,tc,tv0,RD_tv0,f_diff_tv0,TvL_tv0,theta_tv0,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,V2F,so_i,so_lim_i,A,B,U,b,a_0,a_1,k,S1,S2,TvL,Ta,Tf0,r0,alpha_ds0,alpha_ss,f0,fb,delta_alpha_0,delta_alpha_1,d_cm,d_cc,z_cm,z_cc,gamma_LS,g_v,df0_c,fSS,fSig_1n,fSig2_n,fS2_n,fS2_c_up,fS2_c_down,gamma_TvL,theta_max,theta_min,RD_m);
        k_step = [k1, k2, k3, k4, k5, k6];
        % Update states rates 
        xdot = k_step*c5;
        % Update minima and maxima of theta
        [theta_min,theta_max,RD_m] = theta_extremes(q_i,so_im1,so_i,so_ip1,so_lim_im1,so_lim_i,so_lim_ip1,x_i(13),theta_min,theta_max,RD_m);
        % Error between 5th and 4th order RKF approximations   
        eps = norm(k_step*c45)*dt;  
        % Boundary crossing
        boundary = BL_boundaries(boundary,tc+dt,tc,tv0,so_i,so_lim_i,alpha_i,q_i,alpha1n_i,alpha1m_i,alpha1c_i,so_ip1,so_lim_ip1,alpha_ip1,q_ip1,alpha1n_ip1,alpha1m_ip1,alpha1c_ip1,alpha_ss,TvL,r0);
        % Check boundary crossing tolerance
        if any(boundary < delta_b) 
            % Check for maximum theta at begin of downstroke as well - Stalled conditions are garanteed even though the actual maximum theta has not been reached yet
            if boundary(9) < delta_b && abs(so_ip1/so_lim_ip1) > 1 
                theta_max = so_ip1/so_lim_ip1;
            end
            % Zero out theta_max when theta = 0 and theta is growing
            if boundary(2) < delta_b && abs(so_ip1/so_lim_ip1) > 0 
                theta_max = 0;
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
    % Update states vector
    x_ip1 = x_i + xdot*dt;
    % Update output vectors
    tp(i+1) = tc+dt;      
    xp(:,i+1) = x_ip1;
    xdotp(:,i) = xdot;
    yp(:,i) = BL_outputs(tc,x_i,tv0,U,b,beta,k,a_0,a_1,M,x_ac,K0,K1,K2,K3,kappa,K_a,K_aM,K_q,K_qM,T_I,b1,b2,b3,b4,b5,A1,A2,A3,A4,alpha_0L,E0,E1,c_m0,c_n_alpha,r0,alpha_ds0,alpha_ss,S1,S2,Tf0,f0,fb,Vn1,Vn2,Vm,g_v,c_d0,delta_alpha_0,delta_alpha_1,d_cm,d_cc,z_cm,z_cc,nu_1,nu_2,gamma_LS,df0_c,fSig_1n,fSig2_n,fS2_n,fS2_c_up,fS2_c_down,RD_tv0,f_diff_tv0,TvL_tv0,theta_tv0,theta_max,theta_min,RD_m,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,TvL);
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