function [xdot,tv0,so_state,so_lim,alpha1,alpha,alpha_dot,r] = BLS_dxdt(t,x,xdot,t_i,tv0,so_i,so_lim_i,A,B,U,b,a_0,a_1,k,alpha1_0,S1,S2,TvL,Ta,Tf0,r0,alpha_ds0,alpha_ss,f0,fb)

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

%% Separation points
[f,f_prime] = sep_point_BLS(so_state,f0,fb,alpha,alpha1,alpha1_0,S1,S2);

%% Find time of stall onset
[tv0,tau_v] = stall_time_BLS(tv0,so_state,so_lim,so_i,so_lim_i,t,t_i);

%% Tf variation
Tf = Tf_BLS(Tf0,theta,tau_v,TvL,alpha,q,x(8),fb);

%% State-space
xdot = state_space_BLS(x,xdot,alpha,q,A,B,f_prime,Tf,Ta,f,Tf0);

end