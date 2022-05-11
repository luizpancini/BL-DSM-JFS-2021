function y = BL_outputs(t,x,tv0,U,b,beta,k,a_0,a_1,M,x_ac,K0,K1,K2,K3,kappa,K_a,K_aM,K_q,K_qM,T_I,b1,b2,b3,b4,b5,A1,A2,A3,A4,alpha_0L,E0,E1,c_m0,c_n_alpha,r0,alpha_ds0,alpha_ss,S1,S2,Tf0,f0,fb,Vn1,Vn2,Vm,g_v,c_d0,delta_alpha_0,delta_alpha_1,d_cm,d_cc,z_cm,z_cc,nu_1,nu_2,gamma_LS,df0_c,fSig_1n,fSig2_n,fS2_n,fS2_c_up,fS2_c_down,RD_tv0,f_diff_tv0,TvL_tv0,theta_tv0,theta_max,theta_min,RD_m,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,TvL)

%% AoA and pitch rate
[alpha,alpha_dot,q,qR,R,alpha_2dot,~,~,R_dot,so_state,f2prime_n,f2prime_m,f2prime_c,RD,RD_theta] = mov_vars_and_states(t,x,U,b,k,a_0,a_1,r0);

%% Stall onset criterion
[so_lim,theta] = stall_onset(so_state,alpha_ss,alpha_ds0,RD_theta,R);         

%% alpha1 variation
[alpha1_n,dalpha1_n,alpha1_m,dalpha1_m,alpha1_c,dalpha1_c,P,S,T] = alpha1_func(alpha_ss,alpha_ds0,delta_alpha_0,delta_alpha_1,d_cm,d_cc,z_cm,z_cc,R,RD,qR,q,theta,theta_max,RD_m,RD_theta,gamma_LS);

%% Separation points
[f,fprime_n,fprime_m,fprime_c,Sigma2] = sep_points(so_state,f0,fb,alpha,alpha1_n,alpha_ss,S1,S2,R,q,theta,RD,alpha1_m,alpha1_c,theta_max,theta_min,RD_tv0,R_dot,P,T,df0_c,fSig_1n,fSig2_n,fS2_n,fS2_c_up,fS2_c_down);

%% Find time of stall onset
tau_v = t-tv0; if tau_v < 0, tau_v = 0; end

%% Tf  variation
[Tf_n,Tf_m,Tf_c] = Tf_func(Tf0,theta,R,q,P,RD_theta,S);

%% Airloads coefficients
% c_n
[c_n,c_nC,c_nf,c_nI,alpha_E,K_f] = cn_coeff(x,M,U,b,beta,c_n_alpha,A1,A2,b1,b2,K_a,K_q,T_I,alpha,q,f2prime_n,alpha_0L,alpha_dot,alpha_2dot);

% c_m
[c_m,~,c_mf,c_mI,dCP] = cm_coeff(x,c_nf,M,alpha,q,A3,b3,A4,b4,K_aM,K_qM,T_I,K0,K1,K2,K3,kappa,c_m0,c_nC,U,b,beta,x_ac,b5,f2prime_m,theta,R,S,P,RD,alpha_dot,alpha_2dot);

% c_c
c_c = cc_coeff(alpha,f2prime_c,theta,c_n_alpha,alpha_E,E0,E1,c_d0,alpha_0L,RD);

% Vortex overshoot  
[cn_v,cm_v] = vortex_overshoots(tau_v,TvL_tv0,f_diff_tv0,RD_tv0,theta_tv0,Vn1,Vn2,Vm,nu_1,nu_2,g_v,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,q,P,R,Sigma2,theta,TvL);
cc_v = 0;

% Increment coefficients with vortex airloads
c_n = c_n+cn_v;
c_m = c_m+cm_v;
 
%% Outputs
y = [alpha; c_n; c_m; c_c; c_nf; c_nI; c_mf; c_mI; cn_v; cm_v; cc_v; f; tau_v; dCP; so_lim; qR; alpha1_n; K_f; c_nC; Tf_n; dalpha1_n; fprime_n; fprime_m; fprime_c; q; dalpha1_m; dalpha1_c; R_dot; Tf_m; Tf_c; theta_min; theta_max; P; S; alpha_E];

end