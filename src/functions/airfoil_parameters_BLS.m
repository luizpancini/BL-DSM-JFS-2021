function params = airfoil_parameters_BLS(airfoil,M,U,b)

% Bound limits
if M < 0.035
    M = 0.035;
elseif M > 0.3
    M = 0.3;
end

%% Airfoil parameters table - as functions of Mach
if strcmp(airfoil,'NACA0012')
    Mach_range =                [0.035;   0.072;   0.110;   0.185;   0.215;   0.25;    0.3];
    c_n_alpha_range =    180/pi*[0.110;   0.110;   0.110;   0.112;   0.115;   0.120;   0.128];
    S1_range =           pi/180*[3.0;     3.0;     3.0;     3.0;     2.5;     2.5;     2.0];
    S2_range =           pi/180*[1.5;     1.5;     1.5;     2.0;     2.0;     2.0;     2.0];
    alpha1_0_range =     pi/180*[12.9;    14.5;    16.0;    17.0;    17.0;    16.8;    14.0];
    alpha_ss_range =     pi/180*[11.9;    13.5;    15.0;    16.1;    16.2;    15.8;    13.5];
    alpha_ds0_range =    pi/180*[15.0;    18.5;    18.7;    20.0;    18.5;    17.2;    16.5];
    Df_range =                  [4.0;     4.0;     4.0;     4.0;     4.0;     4.0;     4.0];
    TvL_range =                 [3.8;     5.0;     5.0;     4.5;     4.5;     4.5;     4.0];
    K0_range =                  [0.02;    0.02;    0.01;    0.01;    0.01;    0.01;    0.01];
    K1_range =                  [-0.100;  -0.080;  -0.120;  -0.120;  -0.120;  -0.100;  -0.140];
    K2_range =                  [0.02;    0.02;    0.04;    0.04;    0.04;    0.04;    0.04];
    kappa_range =               [2.0;     2.0;     2.0;     2.0;     2.0;     2.0;     2.0];
    Ta_range =                  [3.0;     3.5;     4.0;     3.3;     2.5;     1.5;     1.0];
    Tf0_range =                 [2.0;     3.0;     3.0;     3.0;     3.0;     3.0;     3.5];
    r0_range =                  [0.010;   0.010;   0.010;   0.011;   0.011;   0.012;   0.014];
    c_m0_range =                [-0.000;  -0.015;  -0.005;  -0.005;  -0.005;  -0.005;  -0.006];
    c_d0_range =                [0.005;   0.005;   0.005;   0.005;   0.005;   0.005;   0.005];
    alpha_0L_range =     pi/180*[-0.3;    0.0;     0.0;     0.0;     0.0;     0.0;     0.2];
    E0_range =                  [0.10;    0.10;    0.10;    0.10;    0.08;    0.06;    0.04];
    B1_range =                  [1.80;    2.50;    2.50;    1.80;    1.50;    1.10;    0.70];
    B2_range =                  [0.25;    0.25;    0.25;    0.25;    0.25;    0.25;    0.25];
    alpha_min0_range =   pi/180*[13.0;    16.0;    16.5;    17.5;    19.0;    19.5;    18.5];
    Tr_range =                  [5.5;     5.5;     5.5;     5.5;     6.0;     6.0;     6.5];
    r_dcn_da_reat_range =       [0.50;    0.65;    0.65;    0.65;    0.65;    0.65;    0.60];
    r_dcm_da_reat_range =       [0.06;    0.08;    0.08;    0.08;    0.09;    0.10;    0.12];
    r_dcc_da_reat_range =       [0.06;    0.08;    0.08;    0.08;    0.08;    0.08;    0.06];
elseif strcmp(airfoil,'AMES-01')
    Mach_range =                [0.035;   0.072;   0.110;   0.185;   0.215;   0.25;    0.3];
    c_n_alpha_range =    180/pi*[0.110;   0.110;   0.110;   0.115;   0.118;   0.120;   0.120];
    S1_range =           pi/180*[3.0;     3.0;     1.5;     1.5;     1.5;     1.2;     1.2];
    S2_range =           pi/180*[1.5;     1.5;     2.0;     2.0;     2.0;     2.0;     2.0];
    alpha1_0_range =     pi/180*[12.9;    14.5;    16.0;    16.0;    16.0;    15.3;    14.9];
    alpha_ss_range =     pi/180*[11.9;    13.5;    15.0;    15.5;    15.5;    14.8;    14.4];
    alpha_ds0_range =    pi/180*[14.0;    18.5;    19.0;    19.7;    18.5;    17.5;    17.5];
    Df_range =                  [4.0;     4.0;     4.0;     4.0;     4.0;     4.0;     4.0];
    TvL_range =                 [4.0;     5.0;     4.5;     4.5;     4.5;     4.2;     4.2];
    K0_range =                  [0.02;    0.02;    0.00;    0.00;    0.00;    0.00;    0.00];
    K1_range =                  [-0.100;  -0.080;  -0.08;   -0.08;   -0.08;   -0.08;   -0.08];
    K2_range =                  [0.02;    0.02;    0.04;    0.04;    0.04;    0.03;    0.03];
    kappa_range =               [2.0;     2.0;     2.0;     2.0;     2.0;     2.0;     2.0];
    Ta_range =                  [4.0;     4.0;     3.0;     3.5;     3.0;     2.5;     1.8];
    Tf0_range =                 [2.0;     3.0;     2.5;     2.5;     2.5;     2.2;     2.2];
    r0_range =                  [0.010;   0.010;   0.010;   0.010;   0.010;   0.010;   0.010];
    c_m0_range =                [-0.000;  -0.015;  -0.005;  -0.005;  -0.005;  -0.005;  -0.005];
    c_d0_range =                [0.005;   0.005;   0.005;   0.005;   0.005;   0.005;   0.005];
    alpha_0L_range =     pi/180*[-0.8;    -0.8;    -0.8;    -0.8;    -0.8;    -0.8;    -0.8];
    E0_range =                  [0.10;    0.10;    0.10;    0.05;    0.00;   -0.05;   -0.10];
    B1_range =                  [2.00;    2.50;    2.00;    2.00;    1.90;    1.80;    1.60];
    B2_range =                  [0.25;    0.25;    0.20;    0.20;    0.25;    0.25;    0.25];
    alpha_min0_range =   pi/180*[13.0;    16.0;    18.5;    20.0;    19.0;    19.5;    18.5];
    Tr_range =                  [5.5;     5.5;     5.0;     4.0;     4.0;     4.0;     4.0];
    r_dcn_da_reat_range =       [0.50;    0.70;    0.75;    0.75;    0.70;    0.70;    0.70];
    r_dcm_da_reat_range =       [0.08;    0.08;    0.08;    0.08;    0.09;    0.10;    0.12];
    r_dcc_da_reat_range =       [0.08;    0.08;    0.08;    0.08;    0.08;    0.08;    0.06];
else
    error('airfoil not listed')
end

%% Interpolated values
interp_mode = 'linear';
params.alpha_0L = interp1(Mach_range,alpha_0L_range,M,interp_mode);
params.alpha1_0 = interp1(Mach_range,alpha1_0_range,M,interp_mode);
params.alpha_ds0 = interp1(Mach_range,alpha_ds0_range,M,interp_mode);
params.alpha_min0 = interp1(Mach_range,alpha_min0_range,M,interp_mode);
params.alpha_ss = interp1(Mach_range,alpha_ss_range,M,interp_mode);
params.kappa = interp1(Mach_range,kappa_range,M,interp_mode);
params.B1 = interp1(Mach_range,B1_range,M,interp_mode);
params.B2 = interp1(Mach_range,B2_range,M,interp_mode);
params.c_d0 = interp1(Mach_range,c_d0_range,M,interp_mode);
params.c_m0 = interp1(Mach_range,c_m0_range,M,interp_mode);
params.c_n_alpha = interp1(Mach_range,c_n_alpha_range,M,interp_mode);
params.Df = interp1(Mach_range,Df_range,M,interp_mode);
params.E0 = interp1(Mach_range,E0_range,M,interp_mode);
params.K0 = interp1(Mach_range,K0_range,M,interp_mode);
params.K1 = interp1(Mach_range,K1_range,M,interp_mode);
params.K2 = interp1(Mach_range,K2_range,M,interp_mode);
params.r0 = interp1(Mach_range,r0_range,M,interp_mode);
params.r_dcc_da_reat = interp1(Mach_range,r_dcc_da_reat_range,M,interp_mode);
params.r_dcm_da_reat = interp1(Mach_range,r_dcm_da_reat_range,M,interp_mode);
params.r_dcn_da_reat = interp1(Mach_range,r_dcn_da_reat_range,M,interp_mode);
params.S1 = interp1(Mach_range,S1_range,M,interp_mode);
params.S2 = interp1(Mach_range,S2_range,M,interp_mode);
params.Ta = interp1(Mach_range,Ta_range,M,interp_mode);
params.Tf0 = interp1(Mach_range,Tf0_range,M,interp_mode);
params.Tr = interp1(Mach_range,Tr_range,M,interp_mode);
params.TvL = interp1(Mach_range,TvL_range,M,interp_mode);
params.x_ac = 0.25-params.K0;

%% Fixed parameters
params.f0 = 0.02; % Minimum separation
params.fb = 0.6;  % Breakpoint of separation

%% Time delay constants adjustment for dimensional time
params.Tf0 = params.Tf0*b/U;
params.TvL = params.TvL*b/U;
params.Ta = params.Ta*b/U;
params.Tr = params.Tr*b/U;
end