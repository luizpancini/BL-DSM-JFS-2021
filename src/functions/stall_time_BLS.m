function [tv0,tau_v] = stall_time_BLS(tv0,so_state,so_lim,so_i,so_lim_i,t,t_i)

if abs(so_state)>=so_lim && abs(so_i)<so_lim_i && t>t_i
    if so_state < 0
        so_lim = -so_lim;
        so_lim_i = -so_lim_i;
    end
    m_so = (so_state-so_i)/(t-t_i);
    m_so_lim = (so_lim-so_lim_i)/(t-t_i);
    tv0 = t_i + (so_lim_i-so_i)/(m_so-m_so_lim); 
end
tau_v = t-tv0; if tau_v < 0, tau_v = 0; end

end