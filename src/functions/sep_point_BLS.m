function [f,f_prime] = sep_point_BLS(so_state,f0,fb,alpha,alpha1,alpha1_0,S1,S2)

f1 = fb-f0;
% Quasi-steady condition separation point based on AoA 
if abs(alpha) <= alpha1_0
    f = 1-(1-fb)*exp((abs(alpha)-alpha1_0)/S1);
else
    f = f0+f1*exp((alpha1_0-abs(alpha))/S2);
end
% Lagged AoA         
alpha_lag = abs(so_state);
% Unsteady lagged separation point based on lagged AoA
if abs(alpha_lag) <= alpha1
    f_prime = 1-(1-fb)*exp((alpha_lag-alpha1)/S1);
else
    f_prime = f0+f1*exp((alpha1-alpha_lag)/S2);
end

end