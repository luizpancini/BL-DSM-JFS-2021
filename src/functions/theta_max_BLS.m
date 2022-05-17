function theta_max = theta_max_BLS(q_i,so_im1,so_i,so_ip1,so_lim_im1,so_lim_i,so_lim_ip1,theta_max)

% Theta at previous, current and next time steps
theta_im1 = so_im1/so_lim_im1;
theta_i = so_i/so_lim_i;
theta_ip1 = so_ip1/so_lim_ip1;

% Update maximum theta
if abs(theta_ip1) < abs(theta_i) && abs(theta_i) > abs(theta_im1)
    theta_max = theta_i;
elseif abs(theta_ip1) > abs(theta_i) && abs(theta_i) < abs(theta_im1) && theta_i*q_i > 0
    theta_max = 0; % Reset theta_max - assume next cycle will not stall
end

end