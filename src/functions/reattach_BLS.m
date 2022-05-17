function [c_n,c_m,c_c,alpha_re_i,cn_re_i,cm_re_i,cc_re_i,cn_re_f,cm_re_f,cc_re_f,tri,trf] = reattach_BLS(t,b,U,alpha,q,tau_v,TvL,a_0,a_1,c_n_alpha,alpha_min0,Tr,r_dcn_da_reat,r_dcm_da_reat,r_dcc_da_reat,c_n,c_m,c_c,alpha_re_i,cn_re_i,cm_re_i,cc_re_i,cn_re_f,cm_re_f,cc_re_f,tri,trf,theta_max)

alpha_max = a_0+a_1;
if abs(theta_max) > 1 % Only if stall occurred
    if alpha*q >= 0 || tau_v <= 2.5*TvL % As soon as the AoA begins to head towards zero and the vortex has passed, these are fixed
        cn_re_i = c_n; 
        cm_re_i = c_m;
        cc_re_i = c_c;
        alpha_re_i = alpha;
    end
    if alpha_max > alpha_min0 % For cases in which the maximum angle reached is higher than alpha_min0
        if alpha*q > 0 || alpha >= alpha_min0 % As soon as the AoA crosses alpha_min0 during ramp-down, tri and trf are fixed
            tri = t;
            trf = tri+Tr;
        end
    else                       % Else the time for linear reattachment to begin is as soon as the downstroke begins
        if alpha*q > 0
            tri = t;
            trf = tri+Tr;
        end
    end
    dcn_da_reat = c_n_alpha*r_dcn_da_reat; % Reduce the downstroke slope
    dcm_da_reat = -c_n_alpha*r_dcm_da_reat; % Approximation
    dcc_da_reat = -c_n_alpha*r_dcc_da_reat; % Approximation
    c_n_re = cn_re_i+dcn_da_reat*(alpha-alpha_re_i);
    c_m_re = cm_re_i+dcm_da_reat*(alpha-alpha_re_i);
    c_c_re = cc_re_i+dcc_da_reat*(alpha-alpha_re_i); 
    if t < tri+Tr % During ramp-down, up to a time Tr*b/U after crossing alpha_min0, the coefficients vary linearly
        c_n = c_n_re;
        c_m = c_m_re;
        c_c = c_c_re;
    else
        % Go back exponentially from last value in the line to standard coefficient
        Trf = min([5*b/U; Tr/2]);
        c_n = c_n_re+(c_n-c_n_re)*(1-exp(-(t-trf)/Trf));
        c_m = c_m_re+(c_m-c_m_re)*(1-exp(-(t-trf)/Trf));
        c_c = c_c_re+(c_c-c_c_re)*(1-exp(-(t-trf)/Trf));
    end
end


