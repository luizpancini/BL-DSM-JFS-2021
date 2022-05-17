function [y,alpha_re_i,cn_re_i,cm_re_i,cc_re_i,cn_re_f,cm_re_f,cc_re_f,tri,trf] = BLS_outputs(t,x,tv0,U,b,beta,k,a_0,a_1,M,K0,K1,K2,kappa,T_I,T_M,b1,b2,b3,A1,A2,A3,E0,Df,c_m0,c_n_alpha,TvL,r0,alpha_ds0,alpha_ss,alpha1_0,S1,S2,Tf0,f0,fb,B1,B2,alpha_0L,c_d0,alpha_min0,Tr,r_dcn_da_reat,r_dcm_da_reat,r_dcc_da_reat,alpha_re_i,cn_re_i,cm_re_i,cc_re_i,cn_re_f,cm_re_f,cc_re_f,tri,trf,theta_max,lin_reat)

%% AoA and pitch rate
alpha = a_0 + a_1*sin(k*U/b*t);
alpha_dot = a_1*k*U/b*cos(k*U/b*t);
q = 2*alpha_dot*b/U;
r = q/2;
if abs(r/r0) > 1
    R = sign(r); 
else
    R = r/r0;    
end

%% Stall onset criterion
[so_state,so_lim,theta] = stall_onset_BLS(x(7),R,alpha_ss,alpha_ds0);        

%% alpha1 variation
alpha1 = alpha1_func_BLS(alpha1_0,alpha_ss,alpha_ds0,R,alpha,q);

%% Find time of stall onset
tau_v = t-tv0; if tau_v < 0, tau_v = 0; end

%% Separation points
[f,f_prime] = sep_point_BLS(so_state,f0,fb,alpha,alpha1,alpha1_0,S1,S2);

%% Tf variation
Tf = Tf_BLS(Tf0,theta,tau_v,TvL,alpha,q,x(8),fb);

%% Airload coefficients
% c_n
[c_n,c_nC,c_nf,c_nI,c_nv,alpha_E] = cn_coeff_BLS(x,U,b,M,beta,A1,A2,A3,b1,b2,b3,T_I,alpha,q,c_n_alpha,f,x(8),B1,alpha_0L,tau_v,TvL);
% c_m
[c_m,~,c_mf,c_mI,c_mv,dCP] = cm_coeff_BLS(x,c_nf,c_nv,M,alpha,q,T_I,K0,K1,K2,kappa,tau_v,TvL,c_m0,U,b,beta,T_M,B2,f_prime);
% c_c
c_c = cc_coeff_BLS(alpha,so_state,so_lim,x(8),theta,c_n_alpha,alpha_E,E0,Df,alpha_0L,c_d0,f_prime);
% Override with linear approximation for reattachment phase
if lin_reat == 1    
    [c_n,c_m,c_c,alpha_re_i,cn_re_i,cm_re_i,cc_re_i,cn_re_f,cm_re_f,cc_re_f,tri,trf] = reattach_BLS(t,b,U,alpha,q,tau_v,TvL,a_0,a_1,c_n_alpha,alpha_min0,Tr,r_dcn_da_reat,r_dcm_da_reat,r_dcc_da_reat,c_n,c_m,c_c,alpha_re_i,cn_re_i,cm_re_i,cc_re_i,cn_re_f,cm_re_f,cc_re_f,tri,trf,theta_max);
end

%% Outputs
y = [alpha; c_n; c_m; c_c; f; f_prime; c_nf; c_nI; c_nv; c_mf; c_mv; c_mI; tau_v; dCP; so_lim; q; alpha1; R; Tf; c_nC];

end