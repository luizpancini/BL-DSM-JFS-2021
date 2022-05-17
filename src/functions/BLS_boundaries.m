function boundary = BLS_boundaries(boundary,t_ip1,t_i,x8_ip1,x8_i,tv0,so_i,so_lim_i,alpha1_i,alpha_i,alpha_dot_i,r_i,so_ip1,so_lim_ip1,alpha1_ip1,alpha_ip1,alpha_dot_ip1,r_ip1,alpha1_0,TvL,r0,fb)

% Discontinuity boundaries
boundary(1) = (abs(alpha_ip1)-alpha1_0)*(abs(alpha_i)-alpha1_0);        % f: alpha = alpha1_0
boundary(2) = (so_ip1-so_lim_ip1)*(so_i-so_lim_i);                      % so_state = so_lim
boundary(3) = (so_ip1-alpha1_ip1)*(so_i-alpha1_i);                      % f': so_state = alpha_1
boundary(4) = (t_ip1-tv0-TvL)*(t_i-tv0-TvL);                            % t = tv0+TvL
boundary(5) = (t_ip1-tv0-2*TvL)*(t_i-tv0-2*TvL);                        % t = tv0+2*TvL
boundary(6) = (alpha_ip1*alpha_dot_ip1)*(alpha_i*alpha_dot_i);          % alpha*alpha_dot = 0
boundary(8) = (x8_ip1-fb)*(x8_i-fb);                                    % x8 = fb
boundary(9) = (abs(r_ip1)-r0)*(abs(r_i)-r0);                            % r = r0
boundary(10) = r_ip1*r_i;                                               % r = 0

end