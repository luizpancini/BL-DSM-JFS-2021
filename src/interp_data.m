function [iti,itt,ittf,time_interp,alpha_interp,cn_interp,cm_interp,cc_interp,cn_NRMSE,cm_NRMSE,cc_NRMSE] = interp_data(c_n,c_m,c_c,t,t_cycle,n_discard,data,authors,params,INPUT)

% Unpack
a_0 = params.a_0;
a_1 = params.a_1;

% Find time indices
iti = find(t>n_discard*t_cycle,1,'first');   % First index after discarded time
itt = find(t>t(end)-5/4*t_cycle,1,'first');  % Index of begin of cycle
ittf = find(t>t(end)-1/4*t_cycle,1,'first'); % Index of end of cycle

% Spline interpolation of coefficients
disp_info = 1;
dummy = ~isnan(data{7});
if length(data) > 1 && dummy(1) && (strcmp(authors{1},'McAlister et al. (1982)') == 1 || strcmp(authors{1},'GU') == 1)
    if strcmp(authors{1},'McAlister et al. (1982)') 
        [time_interp,alpha_interp,cn_interp,cm_interp,cc_interp] = interp_coefs(data,a_0,a_1,ittf-itt+1);
        % NRMSE
        [cn_NRMSE,cm_NRMSE,cc_NRMSE] = RMS_error_calculator(c_n(itt:ittf),c_m(itt:ittf),c_c(itt:ittf),cn_interp,cm_interp,cc_interp,ittf-itt+1);
        if disp_info
            disp(['Frame ' num2str(INPUT) ', NMRS errors: cn = ' num2str(cn_NRMSE,'%.4f') ', cm = ', num2str(cm_NRMSE,'%.4f') ', cc = ' num2str(cc_NRMSE,'%.4f')]);
        end
    else
       [time_interp,alpha_interp,cn_interp,cm_interp,cc_interp,itt,ittf] = interp_coefs_GUD(data,a_0,a_1,t,t_cycle);
       % NRMSE
       [cn_NRMSE,cm_NRMSE,cc_NRMSE] = RMS_error_calculator(c_n(itt:ittf),c_m(itt:ittf),c_c(itt:ittf),cn_interp,cm_interp,cc_interp,ittf-itt+1);
       if disp_info
            disp(['GUD ' num2str(INPUT) ', NMRS errors: cn = ' num2str(cn_NRMSE,'%.4f') ', cm = ', num2str(cm_NRMSE,'%.4f') ', cc = ' num2str(cc_NRMSE,'%.4f')]); 
       end
    end
else
    time_interp = nan;
    alpha_interp = nan;
    cn_interp = nan;
    cm_interp = nan;
    cc_interp = nan;
    cn_NRMSE = nan;
    cm_NRMSE = nan;
    cc_NRMSE = nan;
end
