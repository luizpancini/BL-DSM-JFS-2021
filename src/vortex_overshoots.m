function [cn_v,cm_v] = vortex_overshoots(tau_v,TvL_tv0,f_diff_tv0,RD_tv0,theta_tv0,Vn1,Vn2,Vm,nu_1,nu_2,g_v,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,q_bar,P,R,Sigma2,theta,TvL)

% First
if tau_v <= 2*TvL_tv0 
    B1 = Vn1*RD_tv0^(nu_1); % Vortex strenght proportional to pitch rate
    Vx_n = sin(pi*tau_v/(2*TvL_tv0))^(nu_2+RD_tv0); 
    cn_v1 = B1*(f_diff_tv0)*Vx_n*sign(theta_tv0)*(TvL/TvL_tv0)^2;
    cm_v1 = -Vm*cn_v1*(TvL/TvL_tv0)^2; 
else
    cn_v1 = 0;
    cm_v1 = 0;
end

% Second
g_v_max = 2.5;
if g_v < g_v_max
    g_v = g_v + (g_v_max-g_v)*(1-RD_tv0^2); % Increase the vortex gap at low pitch rates
end
if tau_v > g_v*TvL_tv0 && tau_v <= g_v*TvL_tv0+2*TvL_tv0_2
    B2 = Vn2*RD_tv0_2^(nu_1^(1/2))*(1-(Sigma2/0.5)^2); % *(1-(Sigma2/0.5)^2) is to reduce effect on oscillations close around stall
    if theta*q_bar < 0
        B2 = B2*(1-R*P); % -R*P to reduce the effect on downstroke of light stall with continuity for vortices at end of movement
    end
    Vx_n2 = (1-cos(2*pi*(tau_v-g_v*TvL_tv0)/(2*TvL_tv0_2)))/2; % Change to 1-cos to smooth begining and end of vortex
    cn_v2 = B2*(f_diff_tv0)*Vx_n2*sign(theta);
    cm_v2 = -Vm*cn_v2*RD_tv0_2^3; % *RD_tv0_2^3 to reduce effect at low-medium pitch rates
else
    cn_v2 = 0;
    cm_v2 = 0;
end

% Third - Shed as the second is halfway down the chord
if tau_v > g_v*TvL_tv0+1/2*TvL_tv0_2 && tau_v <= g_v*TvL_tv0+(7/2)*TvL_tv0_2
    B3 = 3/4*Vn2*RD_tv0_2^(nu_1^(1/2))*(1-(Sigma2/0.5)^2); % B3 is 3/4 of B2
    if theta*q_bar < 0
        B3 = B3*(1-R*P); 
    end
    Vx_n3 = (1-cos(2*pi*(tau_v-(g_v*TvL_tv0+1/2*TvL_tv0_2))/(3*TvL_tv0_2)))/2;  % Increase time of third vortex by 50%
    cn_v3 = B3*(f_diff_tv0_2^(1/2))*Vx_n3*sign(theta); % f_diff_tv0_2^(1/2) because f_diff_tv0_2 is too low
    cm_v3 = -Vm/2*cn_v3*RD_tv0_2^3; % Vm/2*RD_tv0_2^3 to reduce effect compared to second one, even more at low-medium pitch rates
else
    cn_v3 = 0;
    cm_v3 = 0;
end 
% cn_v2 = 0; cn_v3 = 0; cm_v2 = 0; cm_v3 = 0; % To ignore secondary vortices

% Total vortices' contributions
cn_v = cn_v1 + cn_v2 + cn_v3;
cm_v = cm_v1 + cm_v2 + cm_v3;

