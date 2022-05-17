function [tv0,tau_v,f_diff_tv0,RD_tv0,TvL_tv0,theta_tv0,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,V2F] = stall_time(tv0,f_diff_tv0,RD_tv0,TvL_tv0,theta_tv0,so_state,so_lim,so_i,so_lim_i,t,t_i,f2prime,f,TvL,R,RD,f_diff_tv0_2,RD_tv0_2,TvL_tv0_2,V2F,g_v,theta,gamma_TvL,q)

if abs(so_state)>=so_lim && abs(so_i)<so_lim_i && t>t_i
    if so_state < 0
        so_lim = -so_lim;
        so_lim_i = -so_lim_i;
    end
    m_so = (so_state-so_i)/(t-t_i);
    m_so_lim = (so_lim-so_lim_i)/(t-t_i);
    tv0 = t_i + (so_lim_i-so_i)/(m_so-m_so_lim); 
    f_diff_tv0 = f2prime-f;
    RD_tv0 = RD;
    if RD > R || theta*q < 0
        eps =  min([abs(RD-R); 1/2]);            
        TvL_tv0 = TvL*(1+gamma_TvL*eps);
    else
        TvL_tv0 = TvL;
    end
    theta_tv0 = theta;
    V2F = 1; % Flag to allow second vortex
    TvL_tv0_2 = -1e4; % Reset - avoid always getting second vortex in general motion aeroelastic calculations
end
tau_v = t-tv0; 
if tau_v < 0, tau_v = 0; end

% For second vortex
g_v_max = 2.5;
if g_v < g_v_max
    g_v = g_v + (g_v_max-g_v)*(1-RD_tv0^2); % Increase the vortex gap at low pitch rates
end
if tau_v > g_v*TvL_tv0 && V2F == 1
    V2F = 0;
    if f2prime > f
        f_diff_tv0_2 = f2prime-f;
        RD_tv0_2 = RD;
        TvL_tv0_2 = TvL*(1+(2-g_v)^2+1/4*(1-RD_tv0^2)); % +1/4*(1-RD_tv0^2) to increase TvL at low pitch rates, (2-g_v)^2 to increase TvL proportionally to how early or late the second vortex is shed
    end
end

end