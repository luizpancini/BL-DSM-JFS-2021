function alpha1 = alpha1_func_BLS(alpha1_0,alpha_ss,alpha_ds0,R,alpha,q)

dalpha1 = (alpha_ds0-alpha_ss)*abs(R)*sign(alpha*q);
alpha1 = alpha1_0+dalpha1; % Unsteady breakpoint of separation angle

