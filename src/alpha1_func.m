function [alpha1_n,dalpha1_n,alpha1_m,dalpha1_m,alpha1_c,dalpha1_c,P,S,T] = alpha1_func(alpha_ss,alpha_ds0,delta_alpha_0,delta_alpha_1,d_cm,d_cc,z_cm,z_cc,R,RD,qR,q,theta,theta_max,RD_m,RD_theta,gamma_LS)

% Unsteady breakpoints of separation angle increments
if theta*q >= 0         % Upstroke
    dalpha1_n = (alpha_ds0-alpha_ss)*RD_theta;
    dalpha1_m = dalpha1_n+d_cm;
    dalpha1_c = dalpha1_n*z_cc+d_cc*(1-RD_theta);
    T = exp(-50*RD_m);  % Identifies static condition 
    P = 0;              % Determines how light stall is
    S = 0;              % Determines if stall has occurred
else                    % Downstroke - Delay the reattachment 
    if abs(theta_max) > 1
        P = exp(-gamma_LS*(abs(theta_max)^4-1)); 
        S = 1;                                   
    else
        P = 0;
        S = 0;
    end
    T = exp(-50*RD_m); 
    dalpha1_n = -S*(delta_alpha_0+delta_alpha_1*qR*(1+P*(2*RD^(1/2)))); % S to apply only if stalled, proportional to qR, increase proportional to RD^(1/2) for light stall
    dalpha1_m = dalpha1_n*(1-z_cm*R^2)+d_cm*(1-RD_theta)+S*delta_alpha_0*(1-RD_theta)*(1-T); % -z_cm*R^2 is to accelerate reattachment at high pitch rates, -S*delta_alpha_0*(1-R) is to promote continuity on delta_alpha_0, (1-T) to allow discontinuity at static conditions
    dalpha1_c = dalpha1_n*(1+(1-RD_theta)*(1-P))+d_cc*(1-RD_theta)+S*delta_alpha_0*(1-RD_theta)*(1-T); % +(1-R)*(1-P) is to delay reattachment but only on deep stall
end

% Total unsteady breakpoints of separation angle
alpha1_n = alpha_ss+dalpha1_n; 
alpha1_m = alpha_ss+dalpha1_m;
alpha1_c = alpha_ss+dalpha1_c;

end