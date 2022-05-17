function [alpha,c_n,c_m,c_c,c_l,c_d,c_nf,c_nI,c_mf,c_mI,delta_cn,...
    delta_cm,delta_cc,delta_cl,f,f2prime,tau_v,dCP,so_lim,qR,alpha1,...
    K_f,c_nC,Tf_n,dalpha1,fprime,fprime_cm,fprime_cc,q,dalpha1_cm,...
    dalpha1_cc,R_dot,Tf_m,Tf_c,theta,theta_min,theta_max,P,S,R,...
    RD_theta,alpha_E] = BL_output_vars(x,y)

alpha = y(1,:);
c_n = y(2,:);
c_m = y(3,:);
c_c = y(4,:);
c_l = c_n.*cos(alpha)+c_c.*sin(alpha);
c_d = c_n.*sin(alpha)-c_c.*cos(alpha);
c_nf = y(5,:);
c_nI = y(6,:);
c_mf = y(7,:);
c_mI = y(8,:);
delta_cn = y(9,:);
delta_cm = y(10,:);
delta_cc = y(11,:);
delta_cl = delta_cn.*cos(alpha)+delta_cc.*sin(alpha);
f = y(12,:);
f2prime = x(10,:);
tau_v = y(13,:);
dCP = y(14,:);
so_lim = y(15,:);
qR = y(16,:); 
alpha1 = y(17,:);
K_f = y(18,:);
c_nC = y(19,:);
Tf_n = y(20,:);
dalpha1 = y(21,:);
fprime = y(22,:);
fprime_cm = y(23,:);
fprime_cc = y(24,:);
q = y(25,:);
dalpha1_cm = y(26,:);
dalpha1_cc = y(27,:);
R_dot = y(28,:);
Tf_m = y(29,:);
Tf_c = y(30,:);
theta = x(9,:)./so_lim;
theta_min = y(31,:);
theta_max = y(32,:);
P = y(33,:);
S = y(34,:);
alpha_E = y(35,:);
R = qR; dummy = (R>1); R(dummy) = 1;
RD_theta = x(14,:);