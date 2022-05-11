function [theta_min,theta_max,RD_m] = theta_extremes(q_i,so_im1,so_i,so_ip1,so_lim_im1,so_lim_i,so_lim_ip1,RD,theta_min,theta_max,RD_m)

% Extremes of theta and corresponding RD and R_dot
theta_im1 = so_im1/so_lim_im1;
theta_i = so_i/so_lim_i;
theta_ip1 = so_ip1/so_lim_ip1;
if (abs(theta_ip1) < abs(theta_i) && abs(theta_i) > abs(theta_im1)) || (abs(theta_i) > 1 && abs(theta_ip1) > abs(theta_i) && theta_i*q_i < 0)
    theta_max = theta_i;
    RD_m = RD;
elseif abs(theta_ip1) > abs(theta_i) && abs(theta_i) < abs(theta_im1) && theta_i*q_i > 0
    theta_min = theta_i;
    theta_max = 0; % Reset theta_max - assume next cycle will not stall
end

end