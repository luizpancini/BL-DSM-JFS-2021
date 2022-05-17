function [b,a_inf,airfoil,M,alpha_0,delta_alpha,k,alpha_exp_cl,cl_exp,alpha_exp_cm,cm_exp,alpha_exp_cd,cd_exp,alpha_exp_cn,cn_exp,alpha_exp_cc,cc_exp,time_exp_cl,clt_exp,time_exp_cm,cmt_exp,time_exp_cd,cdt_exp,authors] = load_frame(frame)

% Load experiment condition variables
b = 0.61/2;     % McAlister et al. (1982) - page 14
a_inf = 340;    % Assumed MSL conditions
if frame >= 7019 && frame <= 14220
    airfoil = 'NACA0012';
elseif frame >=24022 && frame <= 31310
    airfoil = 'AMES-01';
elseif frame >=67000
    airfoil = 'NLR-7301';
end
filepath = sprintf('../NASA Data/frame_%d.mat', frame);        
load(filepath);

% Set other experimental values
alpha_exp_cn = nan;
cn_exp = nan;
alpha_exp_cc = nan;
cc_exp = nan;
if ~exist('time_exp_cl','var')
    time_exp_cl = nan;
    clt_exp = nan;
    time_exp_cm = nan;
    cmt_exp = nan;
    time_exp_cd = nan;
    cdt_exp = nan;
end

end

