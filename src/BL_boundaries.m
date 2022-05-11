function boundary = BL_boundaries(boundary,t_ip1,t_i,tv0,so_i,so_lim_i,alpha_bar_i,q_bar_i,alpha1n_i,alpha1m_i,alpha1c_i,so_ip1,so_lim_ip1,alpha_bar_ip1,q_bar_ip1,alpha1n_ip1,alpha1m_ip1,alpha1c_ip1,alpha_ss,TvL,r0)

theta_i = so_i/so_lim_i;
theta_ip1 = so_ip1/so_lim_ip1;
% Discontinuity boundaries
boundary(1)=(abs(q_bar_ip1/2)-r0)*(abs(q_bar_i/2)-r0);                  % r/r0 = q_bar/2/r0 = 1
boundary(2)=theta_ip1*theta_i;                                          % theta = 0
boundary(3)=(abs(alpha_bar_i)-alpha_ss)*(abs(alpha_bar_ip1)-alpha_ss);  % f: alpha_bar = alpha_ss
boundary(4)=(abs(so_i)-alpha1n_i)*(abs(so_ip1)-alpha1n_ip1);            % fprime_n: so_state = alpha1_n
boundary(5)=(abs(so_i)-alpha1m_i)*(abs(so_ip1)-alpha1m_ip1);            % fprime_m: so_state = alpha1_m
boundary(6)=(abs(so_i)-alpha1c_i)*(abs(so_ip1)-alpha1c_ip1);            % fprime_c: so_state = alpha1_c
boundary(7)=(abs(theta_ip1)-1)*(abs(theta_i)-1);                        % c_c: abs(theta) = 1
boundary(8)=(t_ip1-tv0-2*TvL)*(t_i-tv0-2*TvL);                          % delta_cn: first vortex ends
boundary(9)=q_bar_ip1*q_bar_i;                                          % q_bar = 0 (theta_max can be higher than 1)

end