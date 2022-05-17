function [time,alpha,cn_interp,cm_interp,cc_interp,itt2,ittf2] = interp_coefs_GUD(data,alpha_0,delta_alpha,t,t_cycle)

alpha_exp = data{1,1};
time_exp = data{9,1};
cm_exp = data{10,1};
cn_exp = data{28,1};
cc_exp = data{30,1};

alpha_init = alpha_exp(1)*pi/180;
t_init = asin((alpha_init-alpha_0)/delta_alpha)*180/pi; % cycle angle [deg] at which the data starts
delta_t = -t_init/360;                                  % according time shift (fraction of t_cycle)

itt2 = find(t>t(end)-(1+delta_t)*t_cycle,1,'first');
ittf2 = find(t>t(end)-(delta_t)*t_cycle,1,'first');
N = ittf2-itt2+1;
time = linspace(-90,270,N);
alpha = alpha_0 + delta_alpha*sind(time);
cn_interp = spline(time_exp,cn_exp,time);
cm_interp = spline(time_exp,cm_exp,time);
cc_interp = spline(time_exp,cc_exp,time);




