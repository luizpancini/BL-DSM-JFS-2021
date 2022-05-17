function [alpha,c_n,c_m,c_c,c_l,c_d,c_nf,c_nI,c_mf,c_mI,c_nv,c_mv,f,...
f2prime,tau_v,dCP,so_lim,qR,alpha1,c_nC,fprime,theta,R,Tf] = BLS_output_vars(x,y)

alpha = y(1,:);
c_n = y(2,:);
c_m = y(3,:);
c_c = y(4,:);
c_l = c_n.*cos(alpha)+c_c.*sin(alpha);
c_d = c_n.*sin(alpha)-c_c.*cos(alpha);
f = y(5,:);
fprime = y(6,:);
f2prime = x(8,:);
c_nf = y(7,:);
c_nI = y(8,:);
c_nv = y(9,:);
c_mf = y(10,:);
c_mv = y(11,:);
c_mI = y(12,:);
tau_v = y(13,:);
dCP = y(14,:);
so_lim = y(15,:);
qR = y(16,:); 
alpha1 = y(17,:);
R = y(18,:);
Tf = y(19,:);
c_nC = y(20,:);
theta = x(7,:)./so_lim;