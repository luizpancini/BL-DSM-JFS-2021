function c_c = cc_coeff(alpha,f2prime_c,theta,c_n_alpha,alpha_E,E0,E1,c_d0,alpha_0L,RD)

if abs(theta) < 1   % Unstalled
    c_c = -c_d0*cos(alpha)+c_n_alpha*(alpha_E-alpha_0L)*sin((alpha_E-alpha_0L))^1*(f2prime_c^(abs(theta))-E0*RD^2); % RD^2 is to ignore the effect of -E0 at low pitch rates 
else                % Stalled
    zeta = min([1/RD; 20]);
    c_c = -c_d0*cos(alpha)+c_n_alpha*(alpha_E-alpha_0L)*sin((alpha_E-alpha_0L))^1*(f2prime_c^(abs(theta))-E0*(RD^2+E1*(1-exp(-zeta*(abs(theta)-1))))); 
end

