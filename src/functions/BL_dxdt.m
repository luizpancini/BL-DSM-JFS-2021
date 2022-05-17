function [xdot,tv0,so_state,so_lim,alpha1_n,alpha1_m,alpha1_c,alpha,q,RD_tv0,f_diff_tv0,TvL_tv0,theta_tv0,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,V2F] = BL_dxdt(t,x,xdot,t_i,tv0,RD_tv0,f_diff_tv0,TvL_tv0,theta_tv0,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,V2F,so_i,so_lim_i,A,B,U,b,a_0,a_1,k,S1,S2,TvL,Ta,Tf0,r0,alpha_ds0,alpha_ss,f0,fb,delta_alpha_0,delta_alpha_1,d_cm,d_cc,z_cm,z_cc,gamma_LS,g_v,df0_c,fSS,fSig_1n,fSig2_n,fS2_n,fS2_c_up,fS2_c_down,gamma_TvL,theta_max,theta_min,RD_m)

%% AoA and pitch rate
[alpha,~,q,qR,R,~,~,~,R_dot,so_state,f2prime_n,~,~,RD,RD_theta] = mov_vars_and_states(t,x,U,b,k,a_0,a_1,r0);

%% Stall onset criterion
[so_lim,theta] = stall_onset(so_state,alpha_ss,alpha_ds0,RD_theta,R);         

%% alpha1 variation
[alpha1_n,~,alpha1_m,~,alpha1_c,~,P,S,T] = alpha1_func(alpha_ss,alpha_ds0,delta_alpha_0,delta_alpha_1,d_cm,d_cc,z_cm,z_cc,R,RD,qR,q,theta,theta_max,RD_m,RD_theta,gamma_LS);

%% Separation points
[f,fprime_n,fprime_m,fprime_c] = sep_points(so_state,f0,fb,alpha,alpha1_n,alpha_ss,S1,S2,R,q,theta,RD,alpha1_m,alpha1_c,theta_max,theta_min,RD_tv0,R_dot,P,T,df0_c,fSig_1n,fSig2_n,fS2_n,fS2_c_up,fS2_c_down);

%% Find time of stall onset
[tv0,~,f_diff_tv0,RD_tv0,TvL_tv0,theta_tv0,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,V2F] = stall_time(tv0,f_diff_tv0,RD_tv0,TvL_tv0,theta_tv0,so_state,so_lim,so_i,so_lim_i,t,t_i,f2prime_n,f,TvL,R,RD,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,V2F,g_v,theta,gamma_TvL,q);

%% Tf  variation
[Tf_n,Tf_m,Tf_c] = Tf_func(Tf0,theta,R,q,P,RD_theta,S);

%% State-space
xdot = state_space(x,xdot,alpha,q,R,RD,A,B,Tf_n,Tf_m,Tf_c,Ta,fprime_n,fprime_m,fprime_c,fSS);

end