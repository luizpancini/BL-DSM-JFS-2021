function [U,M,b,a_0,a_1,k,beta,A,B,alpha_0L,alpha1_0,alpha_ds0,alpha_min0,alpha_ss,kappa,B1,B2,c_d0,c_m0,c_n_alpha,Df,E0,f0,fb,K0,K1,K2,r0,r_dcc_da_reat,r_dcm_da_reat,r_dcn_da_reat,S1,S2,Ta,Tf0,Tr,TvL,A1,A2,A3,b1,b2,b3,T_I,T_M,lin_reat] = unpack_params_BLS(params)

%% Test condition
U = params.U;
M = params.M;
b = params.b;
a_0 = params.a_0;
a_1 = params.a_1;
k = params.k;
beta = params.beta;

%% State space
A = params.A;
B = params.B;

%% Airfoil and Mach-dependent
alpha_0L = params.alpha_0L;
alpha1_0 = params.alpha1_0;
alpha_ds0 = params.alpha_ds0;
alpha_min0 = params.alpha_min0;
alpha_ss = params.alpha_ss;
kappa = params.kappa; 
B1 = params.B1;
B2 = params.B2;
c_d0 = params.c_d0;  
c_m0 = params.c_m0; 
c_n_alpha = params.c_n_alpha;
Df = params.Df;
E0 = params.E0; 
f0 = params.f0; 
fb = params.fb; 
K0 = params.K0; 
K1 = params.K1; 
K2 = params.K2;  
r0 = params.r0;
r_dcc_da_reat = params.r_dcc_da_reat;
r_dcm_da_reat = params.r_dcm_da_reat;
r_dcn_da_reat = params.r_dcn_da_reat;
S1 = params.S1; 
S2 = params.S2; 
Ta = params.Ta;
Tf0 = params.Tf0;
Tr = params.Tr;
TvL = params.TvL;

%% Indicial
A1 = params.A1;
A2 = params.A2;
A3 = params.A3;
b1 = params.b1;
b2 = params.b2;
b3 = params.b3;
T_I = params.T_I;
T_M = params.T_M;

%% Option for linearized reattachment coefficients
lin_reat = params.lin_reat;

end