function [U,M,b,a_0,a_1,k,beta,A,B,alpha_0L,alpha_ds0,alpha_ss,gamma_LS,gamma_TvL,delta_alpha_0,delta_alpha_1,kappa,nu_1,nu_2,c_d0,c_m0,c_n_alpha,d_cc,d_cm,df0_c,E0,E1,f0,fb,fS2_c_down,fS2_c_up,fS2_n,fSig_1n,fSig2_n,fSS,g_v,K0,K1,K2,K3,r0,S1,S2,Ta,Tf0,TvL,Vm,Vn1,Vn2,x_ac,z_cc,z_cm,A1,A2,A3,A4,b1,b2,b3,b4,b5,K_a,K_aM,K_q,K_qM,T_I] = unpack_params(params)

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
alpha_ds0 = params.alpha_ds0;
alpha_ss = params.alpha_ss;
gamma_LS = params.gamma_LS;
gamma_TvL = params.gamma_TvL;
delta_alpha_0 = params.delta_alpha_0; 
delta_alpha_1 = params.delta_alpha_1;
kappa = params.kappa; 
nu_1 = params.nu_1; 
nu_2 = params.nu_2; 
c_d0 = params.c_d0;  
c_m0 = params.c_m0; 
c_n_alpha = params.c_n_alpha;
d_cc = params.d_cc;
d_cm = params.d_cm;
df0_c = params.df0_c;
E0 = params.E0; 
E1 = params.E1;
f0 = params.f0; 
fb = params.fb; 
fS2_c_down = params.fS2_c_down;
fS2_c_up = params.fS2_c_up; 
fS2_n = params.fS2_n;
fSig_1n = params.fSig_1n;
fSig2_n = params.fSig2_n; 
fSS = params.fSS; 
g_v = params.g_v;
K0 = params.K0; 
K1 = params.K1; 
K2 = params.K2; 
K3 = params.K3; 
r0 = params.r0; 
S1 = params.S1; 
S2 = params.S2; 
Ta = params.Ta;
Tf0 = params.Tf0;
TvL = params.TvL;
Vm = params.Vm;
Vn1 = params.Vn1; 
Vn2 = params.Vn2;
x_ac = params.x_ac;
z_cc = params.z_cc; 
z_cm = params.z_cm; 

%% Indicial
A1 = params.A1;
A2 = params.A2;
A3 = params.A3;
A4 = params.A4;
b1 = params.b1;
b2 = params.b2;
b3 = params.b3;
b4 = params.b4;
b5 = params.b5;
K_a = params.K_a; 
K_aM = params.K_aM;
K_q = params.K_q;  
K_qM = params.K_qM; 
T_I = params.T_I;