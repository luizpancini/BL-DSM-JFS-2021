function [so_lim,theta] = stall_onset(stall_state,alpha_ss,alpha_ds0,RD_theta,R)

alpha_cr = alpha_ss + (alpha_ds0-alpha_ss)*RD_theta;
so_lim = alpha_cr;          
theta = stall_state/so_lim;
