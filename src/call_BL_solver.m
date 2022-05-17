%% Initialization 
[authors,data,params,tspan,tf,t_cycle,n_cycles,n_discard,N,x0,y0,ODE_options] = initialize_BL_model(INPUT,model,lin_reat);

%% ODEs solver
tic; 
switch model
    case "BL"
        [t,x,y,xdot] = BL_RKF45(tspan,x0,y0,params,ODE_options);
    case "BLS"
        [t,x,y,xdot] = BLS_RKF45(tspan,x0,y0,params,ODE_options);
end
run_time = toc

%% Get output variables
switch model
    case "BL"
        [alpha,c_n,c_m,c_c,c_l,c_d,c_nf,c_nI,c_mf,c_mI,c_nv,c_mv,c_cv,c_lv,f,f2prime,tau_v,dCP,so_lim,qR,alpha1,K_f,c_nC,Tf_n,dalpha1,fprime,fprime_cm,fprime_cc,q,dalpha1_cm,dalpha1_cc,R_dot,Tf_m,Tf_c,theta,theta_min,theta_max,P,S,R,RD_theta,alpha_E]...
         = BL_output_vars(x,y);
     case "BLS"
        [alpha,c_n,c_m,c_c,c_l,c_d,c_nf,c_nI,c_mf,c_mI,c_nv,c_mv,f,f2prime,tau_v,dCP,so_lim,qR,alpha1,c_nC,fprime,theta,R,Tf]...
         = BLS_output_vars(x,y); 
end

%% Interpolate data and find normalized errors
[iti,itt,ittf,time_interp,alpha_interp,cn_interp,cm_interp,cc_interp,cn_NRMSE,cm_NRMSE,cc_NRMSE] = interp_data(c_n,c_m,c_c,t,t_cycle,n_discard,data,authors,params,INPUT);

%% Plots
call_plotter(INPUT,model,frame,GUD,authors,data,params,t,alpha,c_l,c_m,c_d,c_n,c_c,alpha_interp,cn_interp,cm_interp,cc_interp,time_interp,t_cycle,x,y,iti,itt,ittf);
