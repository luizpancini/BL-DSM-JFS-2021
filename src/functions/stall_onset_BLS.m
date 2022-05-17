function [stall_state,alpha_cr,theta] = stall_onset_BLS(stall_state,R,alpha_ss,alpha_ds0)

alpha_cr = alpha_ss + (alpha_ds0-alpha_ss)*abs(R);
theta = stall_state/alpha_cr;
