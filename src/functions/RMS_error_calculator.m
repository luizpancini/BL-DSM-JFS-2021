function [cn_NRMSE,cm_NRMSE,cc_NRMSE] = RMS_error_calculator(c_n,c_m,c_c,cn_interp,cm_interp,cc_interp,N)

% Sum of squares of the errors
eps_cn = 0; eps_cm = 0; eps_cc = 0;
for i=1:N
    eps_cn = eps_cn + (c_n(i)-cn_interp(i))^2;
    eps_cm = eps_cm + (c_m(i)-cm_interp(i))^2;
    eps_cc = eps_cc + (c_c(i)-cc_interp(i))^2;
end

% Root mean square error normalized by the mean
cn_NRMSE = sqrt(eps_cn/N)/abs(max(cn_interp)-min(cn_interp));
cm_NRMSE = sqrt(eps_cm/N)/abs(max(cm_interp)-min(cm_interp));
cc_NRMSE = sqrt(eps_cc/N)/abs(max(cc_interp)-min(cc_interp));