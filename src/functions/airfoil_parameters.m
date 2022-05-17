function params = airfoil_parameters(airfoil,M,U,b)

% Bound limits
if M < 0.035
    M = 0.035;
elseif M > 0.3
    M = 0.3;
end

%% Airfoil parameters table - as functions of Mach
if strcmp(airfoil,'NACA0012')
    % Mach-dependent parameters
    Mach_range =                [0.035;   0.072;   0.110;   0.185;   0.215;   0.25;    0.28;    0.3];
    alpha_0L_range =     pi/180*[-0.3;    0.0;     0.0;     0.0;     0.0;     0.0;     0.2;     0.2];    % Angle of zero lift (static test) - "hard" parameter
    alpha_ds0_range =    pi/180*[15.0;    18.5;    18.7;    20.0;    18.5;    17.2;    16.0;    15.4];   % Lagged AoA for dynamic stall (dynamic test) - "soft" parameter
    alpha_ss_range =     pi/180*[11.9;    13.5;    15.0;    16.1;    16.2;    15.8;    14.6;    13.7];   % Static angle of stall (static test) - "hard" parameter
    gamma_LS_range =            [0.5;     0.5;     0.5;     0.5;     0.7;     0.8;     1.0;     1.0];    % Sensitivity of P on theta_max (dynamic test) - "soft" parameter
    delta_alpha_0_range= pi/180*[1.5;     0.5;     2.0;     2.0;     2.5;     2.0;     0.7;     0.4];    % Base value for offset breakpoint angle upon return from stall (static test) - "hard" parameter
    delta_alpha_1_range= pi/180*[1.5;     3.0;     1.5;     1.5;     0.8;     0.8;     1.0;     2.8];    % Sensitivity of offset breakpoint angle on pitch rate (dynamic test) - "soft" parameter
    nu_1_range =                [3.0;     2.5;     2.0;     1.7;     1.5;     1.2;     1.0;     0.8];    % Sensitivity of vortex strength on pitch rate (dynamic test) - "soft" parameter
    nu_2_range =                [0.7;     0.8;     1.0;     1.3;     1.5;     1.7;     1.8;     2.0];    % Sensitivity of vortex buildup lag on pitch rate (dynamic test) - "soft" parameter
    c_d0_range =                [0.012;   0.012;   0.008;   0.005;   0.005;   0.005;   0.005;   0.005];  % Cd at zero AoA (static test) - "hard" parameter
    c_m0_range =                [-0.000;  -0.015;  -0.005;  -0.005;  -0.005;  -0.005;  -0.006;  -0.006]; % Cm at zero AoA (static test) - "hard" parameter
    c_n_alpha_range =    180/pi*[0.108;   0.108;   0.108;   0.110;   0.112;   0.114;   0.116;   0.118];  % Cn x alpha slope on linear range (static test) - "hard" parameter
    d_cc_range =         pi/180*[0.3;     0.3;     0.3;     0.3;     0.3;     0.3;     0.5;     0.5];    % Cc increment on offset breakpoint angle relative to Cn (dynamic test) - "soft" parameter
    d_cm_range =         pi/180*[0.3;     0.8;     0.8;     0.6;     0.6;     0.6;     0.5;     0.3];    % Cm increment on offset breakpoint angle relative to Cn (dynamic test) - "soft" parameter
    E0_range =                  [0.10;    0.18;    0.18;    0.20;    0.15;    0.14;    0.12;    0.12];   % Offset allowing development of negative Cc (static test) - "hard" parameter
    E1_range =                  [-0.50;   -0.25;   -0.10;   -0.40;   0.10;    0.20;    0.30;    0.40];   % Influences Cc value at totally separated flow (dynamic test) - "soft" parameter
    g_v_range =                 [2.2;     2.15;    1.8;     1.7;     1.7;     1.7;     1.7;     1.5];    % Determines time gap between dynamic stall vortices (dynamic test) - "soft" parameter
    K0_range =                  [0.02;    0.02;    0.01;    0.01;    0.01;    0.01;    0.01;    0.01];   % Distance between quarter-chord and aerodynamic center (static test) - "hard" parameter
    K1_range =                  [-0.120;  -0.100;  -0.120;  -0.120;  -0.120;  -0.120;  -0.120;  -0.120]; % Influences movement of center of pressure with separation position (static test) - "hard" parameter
    K2_range =                  [0.03;    0.02;    0.04;    0.04;    0.04;    0.04;    0.04;    0.04];   % Influences movement of center of pressure with separation position (static test) - "hard" parameter
    K3_range =                  [0.05;    0.05;    0.07;    0.07;    0.10;    0.10;    0.10;    0.10];   % Influences movement of center of pressure with separation position on upstroke (dynamic test) - "soft" parameter
    r0_range =                  [0.010;   0.010;   0.011;   0.012;   0.012;   0.012;   0.013;   0.014];  % Limit pitch rate for proportionality of critical angle (dynamic test) - "soft" parameter
    S1_range =           pi/180*[3.5;     4.0;     3.5;     3.5;     3.0;     3.0;     2.5;     2.5];    % Influences rate of movement of separation point with steady AoA (static test) - "hard" parameter
    S2_range =           pi/180*[0.7;     1.5;     1.2;     1.2;     1.1;     1.0;     1.0;     1.2];    % Influences rate of movement of separation point with steady AoA (static test) - "hard" parameter
    Ta_range =                  [3.0;     3.5;     4.0;     3.5;     2.5;     1.5;     1.2;     1.0];    % Base time lag for dynamic stall onset (dynamic test) - "soft" parameter
    Tf0_range =                 [3.0;     3.0;     3.0;     3.0;     3.5;     3.5;     3.5;     3.5];    % Base time lag for separation point movement (dynamic test) - "soft" parameter
    TvL_range =                 [3.3;     3.8;     4.5;     4.0;     4.7;     4.5;     4.5;     4.5];    % Time for vortex convection over chord (dynamic test) - "soft" parameter
    Vm_range =                  [0.40;    0.40;    0.40;    0.35;    0.35;    0.35;    0.35;    0.35];   % Sensitivity of Cm on dynamic stall vortex (dynamic test) - "soft" parameter
    Vn1_range =                 [1.10;    1.30;    1.35;    1.30;    1.05;    0.95;    0.90;    0.70];   % Sensitivity of Cn on primary dynamic stall vortex (dynamic test) - "soft" parameter
    Vn2_range =                 [1.40;    1.30;    1.30;    1.30;    0.95;    0.80;    0.60;    0.40];   % Sensitivity of Cn on secondary dynamic stall vortices (dynamic test) - "soft" parameter
    z_cc_range =                [0.30;    0.90;    1.00;    0.85;    0.85;    0.65;    0.45;    0.33];   % Influences Cc offset breakpoint angle relative to Cn (dynamic test) - "soft" parameter
    z_cm_range =                [1.25;    1.25;    1.05;    1.00;    0.95;    0.90;    0.80;    0.75];   % Influences Cc offset breakpoint angle relative to Cn (dynamic test) - "soft" parameter
    % Airfoil parameters
    params.gamma_TvL = 0.25; % Influences time of vortex convection and vortex strength for DS occurring at end of upstroke (dynamic test) - "soft" parameter
    params.kappa = 2.0;      % Influences movement of center of pressure with separation position (dynamic test) - "soft" parameter
    params.df0_c = 0.00;     % Offset for minimum value of separation position for Cc under totally separated flow (dynamic test) - "soft" parameter
    params.f0 = 0.01;        % Separation point value under totally separated flow (static test) - "hard" parameter
    params.fb = 0.70;        % Separation point value at static stall (static test) - "hard" parameter
    params.fS2_c_up = 2;     % Influences rate of movement of separation point for Cc on upstroke (dynamic test) - "soft" parameter
    params.fS2_c_down = 0;   % Influences rate of movement of separation point for Cc on downstroke (dynamic test) - "soft" parameter
    params.fS2_n = 1/3;      % Influences rate of movement of separation point for Cn on upstroke (dynamic test) - "soft" parameter
    params.fSig_1n = 5;      % Influences rate of movement of separation point on downstroke for light stall (dynamic test) - "soft" parameter
    params.fSig2_n = 5;      % Influences separation point value for in/out stall oscillations (dynamic test) - "soft" parameter
    params.fSS = 3;          % Influences time lag on dynamic stall, determining stall suppression condition (dynamic test) - "soft" parameter
elseif strcmp(airfoil,'AMES-01')
    % Mach-dependent parameters - checked only at 0.3 and 0.185
    Mach_range =                [0.035;   0.072;   0.110;   0.185;   0.215;   0.25;    0.28;    0.3];
    alpha_0L_range =     pi/180*[-0.8;    -0.8;    -0.8;    -0.8;    -0.8;    -0.8;    -0.8;    -0.8];
    alpha_ds0_range =    pi/180*[15.0;    18.5;    18.7;    19.0;    18.5;    17.2;    16.7;    16.5];
    alpha_ss_range =     pi/180*[11.9;    13.5;    15.0;    15.5;    15.5;    15.0;    14.4;    14.3];
    gamma_LS_range =            [0.5;     0.5;     0.6;     0.6;     0.7;     0.8;     1.0;     1.0];
    delta_alpha_0_range= pi/180*[2.0;     2.0;     2.0;     2.2;     2.0;     1.7;     1.5;     1.5];
    delta_alpha_1_range= pi/180*[2.5;     2.5;     1.0;     1.0;     1.5;     1.8;     2.0;     2.0];
    nu_1_range =                [0.8;     0.8;     1.0;     1.0;     0.8;     0.8;     0.8;     0.8];
    nu_2_range =                [1.2;     1.2;     1.2;     1.5;     1.2;     1.2;     1.1;     0.9];
    c_d0_range =                [0.010;   0.010;   0.005;   0.005;   0.005;   0.005;   0.005;   0.005];
    c_m0_range =                [-0.005;  -0.005;  -0.005;  -0.005;  -0.005;  -0.005;  -0.005;  -0.005];
    c_n_alpha_range =    180/pi*[0.108;   0.108;   0.108;   0.112;   0.114;   0.115;   0.116;   0.116];
    d_cc_range =         pi/180*[0.5;     0.5;     0.8;     0.8;     0.7;     0.6;     0.5;     0.5];
    d_cm_range =         pi/180*[0.2;     0.2;     0.2;     0.6;     0.4;     0.3;     0.2;     0.2];
    E0_range =                  [0.08;    0.08;    0.16;    0.16;    0.13;    0.10;    0.08;    0.08];
    E1_range =                  [0.00;    0.00;    0.10;    0.10;    0.00;   -0.10;   -0.20;   -0.20];
    g_v_range =                 [2.2;     2.0;     1.3;     1.3;     1.5;     1.8;     1.9;     1.8];
    K0_range =                  [0.00;    0.00;    0.00;    0.00;    0.00;    0.00;    0.00;    0.00];
    K1_range =                  [-0.08;   -0.08;   -0.10;   -0.10;   -0.09;   -0.08;   -0.08;   -0.08];
    K2_range =                  [0.04;    0.04;    0.04;    0.04;    0.04;    0.04;    0.04;    0.03];
    K3_range =                  [0.06;    0.06;    0.06;    0.06;    0.06;    0.06;    0.06;    0.06];
    r0_range =                  [0.011;   0.011;   0.011;   0.011;   0.010;   0.010;   0.010;   0.010];
    S1_range =           pi/180*[3.0;     3.0;     3.5;     3.5;     3.0;     2.5;     2.2;     2.0];
    S2_range =           pi/180*[1.5;     1.5;     2.0;     2.2;     2.2;     2.2;     2.3;     2.4];
    Ta_range =                  [3.0;     3.5;     3.5;     3.5;     3.0;     2.5;     2.0;     1.8];
    Tf0_range =                 [3.0;     3.5;     2.0;     2.0;     2.0;     2.2;     2.3;     2.5];
    TvL_range =                 [4.0;     4.0;     4.0;     4.0;     4.0;     4.0;     3.8;     4.0];
    Vm_range =                  [0.40;    0.40;    0.35;    0.35;    0.35;    0.40;    0.40;    0.40];
    Vn1_range =                 [1.10;    1.25;    1.25;    1.30;    1.20;    1.20;    1.10;    0.90];
    Vn2_range =                 [1.40;    1.20;    1.25;    0.60;    0.60;    0.60;    0.60;    0.40];
    z_cc_range =                [0.40;    0.80;    1.00;    1.20;    1.00;    0.95;    0.90;    0.85];
    z_cm_range =                [1.25;    1.25;    1.00;    1.00;    1.00;    1.00;    1.00;    1.00];
    % Airfoil parameters
    params.gamma_TvL = 1;
    params.kappa = 2.0;
    params.df0_c = 0.15;
    params.f0 = 0.02;
    params.fb = 0.75;
    params.fS2_c_up = 0;
    params.fS2_c_down = 4;
    params.fS2_n = 0;
    params.fSig_1n = 5;
    params.fSig2_n = 5;
    params.fSS = 1;
elseif strcmp(airfoil,'NLR-7301')
    % Mach-dependent parameters - not checked yet
    Mach_range =                [0.035;   0.072;   0.110;   0.185;   0.215;   0.25;    0.28;    0.3];
    alpha_0L_range =     pi/180*[-0.8;    -0.8;    -0.8;    -0.8;    -0.8;    -0.8;    -2.0;    -2.0];
    alpha_ds0_range =    pi/180*[15.0;    18.5;    18.7;    20.0;    18.5;    17.2;    19.0;    19.0];
    alpha_ss_range =     pi/180*[11.9;    13.5;    15.0;    16.1;    16.2;    15.8;    17.5;    17.5];
    gamma_LS_range =            [0.6;     0.6;     0.6;     0.6;     0.7;     0.8;     0.8;     0.8];
    delta_alpha_0_range= pi/180*[1.5;     0.5;     2.0;     2.0;     2.5;     2.0;     1.5;     1.0];
    delta_alpha_1_range= pi/180*[1.5;     3.0;     1.5;     1.6;     0.8;     0.8;     2.0;     2.0];
    nu_1_range =                [3.0;     3.0;     2.0;     1.7;     1.5;     1.2;     1.5;     1.5];
    nu_2_range =                [0.7;     0.8;     1.0;     1.3;     1.5;     1.7;     2.0;     2.0];
    c_d0_range =                [0.012;   0.012;   0.008;   0.005;   0.005;   0.005;   0.007;   0.007];
    c_m0_range =                [-0.005;  -0.005;  -0.005;  -0.005;  -0.005;  -0.005;  -0.084;  -0.084];
    c_n_alpha_range =    180/pi*[0.108;   0.108;   0.108;   0.110;   0.112;   0.114;   0.120;   0.120];
    d_cc_range =         pi/180*[0.3;     0.3;     0.3;     0.3;     0.3;     0.3;     0.0;     0.0];
    d_cm_range =         pi/180*[0.3;     0.8;     0.8;     0.6;     0.6;     0.6;     0.0;     0.0];
    E0_range =                  [-0.06;   -0.06;   -0.06;   -0.06;   -0.06;   -0.06;   0.05;    0.05];
    E1_range =                  [0.30;    0.40;    0.40;    0.40;    0.40;    0.40;    -0.50;   -0.50];
    g_v_range =                 [2.2;     2.15;    1.8;     1.7;     1.7;     1.7;     1.9;     1.8];
    K0_range =                  [0.00;    0.00;    0.00;    0.00;    0.00;    0.00;    0.00;    0.00];
    K1_range =                  [-0.120;  -0.100;  -0.120;  -0.120;  -0.120;  -0.120;  -0.06;   -0.06];
    K2_range =                  [0.03;    0.02;    0.04;    0.04;    0.04;    0.04;    0.05;    0.05];
    K3_range =                  [0.05;    0.05;    0.07;    0.07;    0.08;    0.08;    0.16;    0.16];
    r0_range =                  [0.008;   0.008;   0.008;   0.008;   0.008;   0.008;   0.010;   0.010];
    S1_range =           pi/180*[3.5;     4.0;     3.5;     3.5;     3.0;     3.0;     5.0;     5.0];
    S2_range =           pi/180*[0.7;     1.5;     1.0;     0.7;     0.7;     0.8;     3.0;     3.0];
    Ta_range =                  [2.8;     3.5;     3.9;     3.3;     2.5;     1.5;     2.0;     2.0];
    Tf0_range =                 [3.0;     3.5;     3.0;     3.0;     3.5;     3.5;     2.5;     2.5];
    TvL_range =                 [3.3;     3.8;     4.5;     4.0;     4.7;     4.5;     8.0;     8.0];
    Vm_range =                  [0.40;    0.40;    0.35;    0.35;    0.35;    0.35;    0.50;    0.50];
    Vn1_range =                 [1.10;    1.25;    1.25;    1.30;    1.05;    0.95;    1.20;    1.20];
    Vn2_range =                 [1.40;    1.20;    1.25;    1.30;    0.95;    0.80;    0.50;    0.50];
    z_cc_range =                [0.40;    0.80;    1.00;    0.95;    0.85;    0.65;    1.00;    1.10];
    z_cm_range =                [1.25;    1.25;    1.05;    1.00;    0.95;    0.90;    1.10;    0.90];
    % Airfoil parameters
    params.gamma_TvL = 1;
    params.kappa = 2.0;
    params.df0_c = 0.10;
    params.f0 = 0.02;
    params.fb = 0.50;
    params.fS2_c_up = 0;
    params.fS2_c_down = 5;
    params.fS2_n = 1/3;
    params.fSig_1n = 5;
    params.fSig2_n = 5;
    params.fSS = 1;
elseif strcmp(airfoil,'S809')
    % Mach-dependent parameters
    Mach_range =                [0.035;   0.072;   0.12];
    alpha_0L_range =     pi/180*[-0.8;    -0.8;    -2.0];
    alpha_ds0_range =    pi/180*[15.0;    18.5;    17.0];
    alpha_ss_range =     pi/180*[11.9;    13.5;    15.5];
    gamma_LS_range =            [0.5;     0.5;     0.6];
    delta_alpha_0_range= pi/180*[2.0;     2.0;     1.0];
    delta_alpha_1_range= pi/180*[2.5;     2.5;     1.0];
    nu_1_range =                [0.8;     0.8;     1.0];
    nu_2_range =                [1.2;     1.2;     1.0];
    c_d0_range =                [0.010;   0.010;   0.010];
    c_m0_range =                [-0.005;  -0.005;  -0.004];
    c_n_alpha_range =    180/pi*[0.108;   0.108;   0.100];
    d_cc_range =         pi/180*[0.5;     0.5;     0.5];
    d_cm_range =         pi/180*[0.2;     0.2;     0.5];
    E0_range =                  [0.08;    0.08;    0.2];
    E1_range =                  [0.00;    0.00;    -0.60];
    g_v_range =                 [2.2;     2.0;     1.5];
    K0_range =                  [0.00;    0.00;    -0.01];
    K1_range =                  [-0.08;   -0.08;   -0.18];
    K2_range =                  [0.04;    0.04;    -0.01];
    K3_range =                  [0.06;    0.06;    0.00];
    r0_range =                  [0.011;   0.011;   0.005];
    S1_range =           pi/180*[3.0;     3.0;     7.5];
    S2_range =           pi/180*[1.5;     1.5;     2.0];
    Ta_range =                  [3.0;     3.5;     4.5];
    Tf0_range =                 [3.0;     3.5;     3.5];
    TvL_range =                 [4.0;     4.0;     6.5];
    Vm_range =                  [0.40;    0.40;    0.30];
    Vn1_range =                 [1.10;    1.25;    1.20];
    Vn2_range =                 [1.40;    1.20;    0.00];
    z_cc_range =                [0.40;    0.80;    0.80];
    z_cm_range =                [1.25;    1.25;    2.50];
    % Airfoil parameters
    params.gamma_TvL = 0;
    params.kappa = 2.0;
    params.df0_c = 0.00;
    params.f0 = 0.01;
    params.fb = 0.30;
    params.fS2_c_up = 3;
    params.fS2_c_down = 2;
    params.fS2_n = 0;
    params.fSig_1n = 5;
    params.fSig2_n = 5;
    params.fSS = 1;    
else
    error('airfoil not listed')
end

%% Interpolated values
interp_mode = 'spline';
params.c_n_alpha = interp1(Mach_range,c_n_alpha_range,M,interp_mode);
params.S1 = interp1(Mach_range,S1_range,M,interp_mode);
params.S2 = interp1(Mach_range,S2_range,M,interp_mode);
params.alpha_ss = interp1(Mach_range,alpha_ss_range,M,interp_mode);
params.d_cc = interp1(Mach_range,d_cc_range,M,interp_mode);
params.d_cm = interp1(Mach_range,d_cm_range,M,interp_mode);
params.z_cc = interp1(Mach_range,z_cc_range,M,interp_mode);
params.z_cm = interp1(Mach_range,z_cm_range,M,interp_mode);
params.delta_alpha_0 = interp1(Mach_range,delta_alpha_0_range,M,interp_mode);
params.delta_alpha_1 = interp1(Mach_range,delta_alpha_1_range,M,interp_mode);
params.alpha_ds0 = interp1(Mach_range,alpha_ds0_range,M,interp_mode);
params.TvL = interp1(Mach_range,TvL_range,M,interp_mode);
params.K0 = interp1(Mach_range,K0_range,M,interp_mode);
params.K1 = interp1(Mach_range,K1_range,M,interp_mode);
params.K2 = interp1(Mach_range,K2_range,M,interp_mode);
params.K3 = interp1(Mach_range,K3_range,M,interp_mode);
params.Ta = interp1(Mach_range,Ta_range,M,interp_mode);
params.Tf0 = interp1(Mach_range,Tf0_range,M,interp_mode);
params.r0 = interp1(Mach_range,r0_range,M,interp_mode);
params.c_m0 = interp1(Mach_range,c_m0_range,M,interp_mode);
params.c_d0 = interp1(Mach_range,c_d0_range,M,interp_mode);
params.alpha_0L = interp1(Mach_range,alpha_0L_range,M,interp_mode);
params.E0 = interp1(Mach_range,E0_range,M,interp_mode);
params.E1 = interp1(Mach_range,E1_range,M,interp_mode);
params.Vn1 = interp1(Mach_range,Vn1_range,M,interp_mode);
params.Vn2 = interp1(Mach_range,Vn2_range,M,interp_mode);
params.Vm = interp1(Mach_range,Vm_range,M,interp_mode);
params.nu_1 = interp1(Mach_range,nu_1_range,M,interp_mode);
params.nu_2 = interp1(Mach_range,nu_2_range,M,interp_mode);
params.g_v = interp1(Mach_range,g_v_range,M,interp_mode);
params.gamma_LS = interp1(Mach_range,gamma_LS_range,M,interp_mode);
params.x_ac = 0.25-params.K0;

%% Time delay constants adjustment for dimensional time
params.Tf0 = params.Tf0*b/U;
params.TvL = params.TvL*b/U;
params.Ta = params.Ta*b/U;
end